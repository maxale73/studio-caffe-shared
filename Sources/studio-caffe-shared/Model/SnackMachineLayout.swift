import Foundation

/// Ricostruzione dei cassetti snack a partire dai settori delle piste PriceHolding.
///
/// Le decine identificano i cassetti e le unità le posizioni. La griglia comune
/// contiene da tre a otto posizioni; una selezione può occuparne una o due.
/// Per esempio, i settori `11, 13, 15`, insieme a `20...25`, producono tre
/// selezioni doppie nel primo cassetto e sei singole nel secondo.
///
/// È una rappresentazione derivata: non modifica listini o settori e non inventa
/// associazioni per piste senza un settore numerico univoco. Se il settore è
/// vuoto, usa per impostazione predefinita l'indice pista come codice settore.
public struct SnackMachineLayout: Equatable, Sendable {
    /// Selezione reale, con fotografia della pista e intervallo di colonne occupate.
    public struct Selection: Identifiable, Equatable, Sendable {
        public let sector: Int
        public let channel: PriceChannelDTO
        public let columns: Range<Int>
        public var id: UUID { channel.id }
        public var columnSpan: Int { columns.count }
    }

    /// Una cella del cassetto: selezione oppure spazio che non si può ricostruire.
    public enum Cell: Identifiable, Equatable, Sendable {
        case selection(Selection)
        case gap(Range<Int>)

        public var id: String {
            switch self {
            case .selection(let selection): selection.id.uuidString
            case .gap(let columns): "gap-\(columns.lowerBound)"
            }
        }

        public var columns: Range<Int> {
            switch self {
            case .selection(let selection): selection.columns
            case .gap(let columns): columns
            }
        }
    }

    public struct Drawer: Identifiable, Equatable, Sendable {
        public let number: Int
        public let cells: [Cell]
        public var id: Int { number }
        public var selections: [Selection] {
            cells.compactMap { if case .selection(let value) = $0 { value } else { nil } }
        }
        public var hasUnresolvedGaps: Bool { cells.contains { if case .gap = $0 { true } else { false } } }
    }

    public enum UnplacedReason: String, Equatable, Sendable {
        case missingSector
        case invalidSector
        case duplicateSector
        case incompatibleNumbering

        public var displayName: String {
            switch self {
            case .missingSector: "Settore mancante"
            case .invalidSector: "Settore non numerico o senza decina del cassetto"
            case .duplicateSector: "Settore assegnato a più piste"
            case .incompatibleNumbering: "Posizione incompatibile con una griglia da 3 a 8 settori"
            }
        }
    }

    public struct UnplacedChannel: Identifiable, Equatable, Sendable {
        public let channel: PriceChannelDTO
        public let reason: UnplacedReason
        public var id: UUID { channel.id }
    }

    /// Numero di posizioni elementari, oppure zero quando nessuna pista è collocabile.
    public let columnCount: Int
    /// Origine inferita della numerazione delle unità: zero oppure uno.
    public let firstPosition: Int
    public let drawers: [Drawer]
    public let unplacedChannels: [UnplacedChannel]

    private struct Entry {
        let sector: Int
        let channel: PriceChannelDTO
        var position: Int { sector % 10 }
        var drawer: Int { sector / 10 }
    }

    /// Esclude i tipi diversi da snack; conserva tutte le piste snack, anche se non collocabili.
    ///
    /// - Parameter useChannelIndexForMissingSector: Se `true`, un settore assente
    ///   o composto soltanto da spazi è sostituito dall'indice della pista.
    /// La numerazione contigua da uno è riconosciuta se manca qualsiasi posizione zero.
    /// Negli altri casi si assume l'origine zero, anche per soli cassetti `11,13,15`.
    /// I salti di due identificano selezioni doppie quando l'intero cassetto è
    /// ricostruibile. Salti più grandi rimangono spazi irrisolti, non selezioni triple.
    public init(channels: [PriceChannelDTO], useChannelIndexForMissingSector: Bool = true) {
        var entries: [Entry] = []
        var unplaced: [UnplacedChannel] = []
        for channel in channels.filter({ $0.type == .snack }).sorted(by: Self.channelOrder) {
            let explicitSector = channel.machineSectorCode?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let text = explicitSector.isEmpty && useChannelIndexForMissingSector ? String(channel.index) : explicitSector
            guard !text.isEmpty else {
                unplaced.append(.init(channel: channel, reason: .missingSector))
                continue
            }
            guard text.utf8.allSatisfy({ (48...57).contains($0) }), let sector = Int(text), sector >= 10 else {
                unplaced.append(.init(channel: channel, reason: .invalidSector))
                continue
            }
            entries.append(.init(sector: sector, channel: channel))
        }
        let bySector = Dictionary(grouping: entries, by: \.sector)
        entries = entries.filter { entry in
            guard bySector[entry.sector]?.count == 1 else {
                unplaced.append(.init(channel: entry.channel, reason: .duplicateSector))
                return false
            }
            return true
        }
        // La cifra 9 non appartiene a nessuna griglia supportata, né zero-based né one-based.
        entries = entries.filter { entry in
            guard entry.position < 9 else {
                unplaced.append(.init(channel: entry.channel, reason: .incompatibleNumbering))
                return false
            }
            return true
        }
        let groups = Dictionary(grouping: entries, by: \.drawer)
        let hasContiguousRowFromOne = groups.values.contains { row in
            let positions = row.map(\.position).sorted()
            return positions.count >= 3 && positions.first == 1
                && zip(positions, positions.dropFirst()).allSatisfy { $1 - $0 == 1 }
        }
        let origin = !entries.contains(where: { $0.position == 0 })
            && (hasContiguousRowFromOne || entries.contains(where: { $0.position == 8 })) ? 1 : 0
        entries = entries.filter { entry in
            guard (origin..<(origin + 8)).contains(entry.position) else {
                unplaced.append(.init(channel: entry.channel, reason: .incompatibleNumbering))
                return false
            }
            return true
        }
        firstPosition = origin
        columnCount = entries.map { $0.position - origin + 1 }.max().map { max(3, $0) } ?? 0
        let columns = columnCount
        drawers = Dictionary(grouping: entries, by: \.drawer).sorted { $0.key < $1.key }.map { number, row in
            let ordered = row.sorted { $0.position < $1.position }
            let positions = ordered.map { $0.position - origin }
            var ranges: [Range<Int>] = []
            if positions.last == columns - 1 {
                // Codice sulla posizione finale della coppia: 11 copre 10 e 11.
                var start = 0
                for position in positions {
                    ranges.append(start..<(position + 1))
                    start = position + 1
                }
            } else if positions.first == 0 {
                // Codice sulla posizione iniziale: 10,12,14 coprono anch'essi sei posizioni.
                ranges = positions.indices.map { index in
                    positions[index]..<(index + 1 < positions.count ? positions[index + 1] : columns)
                }
            }
            let canInfer = ranges.count == ordered.count && ranges.allSatisfy { (1...2).contains($0.count) }
            if canInfer {
                return Drawer(number: number, cells: zip(ordered, ranges).map { entry, range in
                    .selection(.init(sector: entry.sector, channel: entry.channel, columns: range))
                })
            }
            var cells: [Cell] = []
            var start = 0
            for entry in ordered {
                let column = entry.position - origin
                if start < column { cells.append(.gap(start..<column)) }
                cells.append(.selection(.init(sector: entry.sector, channel: entry.channel, columns: column..<(column + 1))))
                start = column + 1
            }
            if start < columns { cells.append(.gap(start..<columns)) }
            return Drawer(number: number, cells: cells)
        }
        unplacedChannels = unplaced.sorted { Self.channelOrder($0.channel, $1.channel) }
    }

    private static func channelOrder(_ lhs: PriceChannelDTO, _ rhs: PriceChannelDTO) -> Bool {
        if lhs.index != rhs.index { return lhs.index < rhs.index }
        return lhs.id.uuidString < rhs.id.uuidString
    }
}
