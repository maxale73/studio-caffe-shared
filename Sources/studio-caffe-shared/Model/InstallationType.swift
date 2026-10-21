import Foundation

public enum InstallationType: String, Codable, Identifiable, CaseIterable, RawRepresentable, Sendable {
    
    public var id: String {
        rawValue
    }
    case master
    case slave
    case associato
    case deposito
    case dismesso
    case venduto
    case rottamato
}

extension InstallationType: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}

// Compatibility with clients using the original combined installation field.
extension InstallationType {
    public var machineState: MachineState {
        switch self {
        case .master, .slave, .associato: return .installato
        case .deposito: return .deposito
        case .dismesso: return .dismesso
        case .venduto: return .venduto
        case .rottamato: return .rottamato
        }
    }

    public var installationRole: InstallationRole? {
        switch self {
        case .master: return .master
        case .slave: return .slave
        default: return nil
        }
    }

    public init(state: MachineState, installationRole: InstallationRole?) {
        switch state {
        case .installato:
            switch installationRole {
            case .master: self = .master
            case .slave: self = .slave
            case nil: self = .associato
            }
        case .deposito: self = .deposito
        case .dismesso: self = .dismesso
        case .venduto: self = .venduto
        case .rottamato: self = .rottamato
        }
    }
}
