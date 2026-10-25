import Foundation

/// Stato fiscale corrente di un sistema master vending nel sistema AdE.
///
/// I raw value coincidono con `StatoDispositivo` delle API REST Gestionali.
/// `CENSITO` appartiene al contratto generale dei dispositivi, ma il ciclo dei
/// sistemi master vending inizia da ``activated``. Un dato non noto è `nil`.
/// Lo stato fiscale è distinto dall'installazione fisica del distributore.
public enum AdeDeviceFiscalStatus: String, Codable, CaseIterable, Identifiable, Sendable {
    case activated = "ATTIVATO"
    case inService = "IN_SERVIZIO"
    case outOfService = "FUORI_SERVIZIO"
    case deactivated = "DISATTIVATO"
    case decommissioned = "DISMESSO"

    public var id: String { rawValue }

    /// Etichetta italiana, distinta dal valore stabile usato per JSON e database.
    public var displayName: String {
        switch self {
        case .activated: "Attivato"
        case .inService: "In servizio"
        case .outOfService: "Fuori servizio"
        case .deactivated: "Disattivato"
        case .decommissioned: "Dismesso"
        }
    }
}

/// Causale dell'ultimo stato fiscale annotato, secondo la tabella AdE dei sistemi master.
///
/// Non include `00602` (assistenza hot-swap), che riguarda i dispositivi mobili.
public enum AdeDeviceFiscalStatusReason: String, Codable, CaseIterable, Identifiable, Sendable {
    case other = "00601"
    case transfer = "00603"
    case theft = "00604"
    case recovery = "00605"
    case disposal = "00606"
    case malfunction = "00607"
    case warehouse = "00608"

    public var id: String { rawValue }

    public var displayName: String {
        switch self {
        case .other: "Altro"
        case .transfer: "Cessione"
        case .theft: "Furto"
        case .recovery: "Ritrovamento"
        case .disposal: "Smaltimento"
        case .malfunction: "Malfunzionamento"
        case .warehouse: "Magazzino"
        }
    }

    /// Stati compatibili con la causale; non impone transizioni tra stati precedenti.
    public var compatibleStatuses: [AdeDeviceFiscalStatus] {
        switch self {
        case .other: AdeDeviceFiscalStatus.allCases
        case .transfer, .theft: [.deactivated]
        case .recovery: [.activated]
        case .disposal: [.decommissioned]
        case .malfunction, .warehouse: [.outOfService]
        }
    }
}
