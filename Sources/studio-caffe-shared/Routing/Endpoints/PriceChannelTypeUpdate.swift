import Foundation

/// Aggiornamento atomico del solo tipo di un insieme di piste dello stesso dispositivo.
///
/// Il payload non contiene prezzi, indici o descrizioni: questi campi non possono
/// essere sovrascritti da una bozza del client durante una modifica multipla.
public struct PriceChannelTypeUpdate: Codable, Equatable, Sendable, RequestBody {
    public var channelIDs: [UUID]
    public var type: PriceChannelType

    public init(channelIDs: [UUID], type: PriceChannelType) {
        self.channelIDs = channelIDs
        self.type = type
    }

    public var isValidSelection: Bool {
        !channelIDs.isEmpty && Set(channelIDs).count == channelIDs.count
    }
}
