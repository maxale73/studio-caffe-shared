import Foundation

public enum MachineHistoryEventType: String, Codable, Identifiable, CaseIterable, Sendable, CustomStringConvertible {
    case installazione
    case ritiro

    public var id: String { rawValue }
    public var description: String { self == .installazione ? "installato" : "ritirato" }

    public init?(installation: InstallationType) {
        switch installation {
        case .master, .slave, .associato: self = .installazione
        case .deposito: self = .ritiro
        case .dismesso, .venduto, .rottamato: return nil
        }
    }

    public var legacyInstallation: InstallationType { self == .installazione ? .associato : .deposito }
}
