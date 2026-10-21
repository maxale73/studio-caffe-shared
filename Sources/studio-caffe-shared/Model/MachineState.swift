import Foundation

public enum MachineState: String, Codable, Identifiable, CaseIterable, Sendable, CustomStringConvertible, CustomRawRepresentable {
    case deposito
    case installato
    case dismesso
    case venduto
    case rottamato

    public var id: String { rawValue }
    public var description: String { rawValue }

    public var manualTransitions: [MachineState] {
        switch self {
        case .installato, .venduto: []
        case .deposito, .dismesso, .rottamato: [.deposito, .dismesso, .rottamato].filter { $0 != self }
        }
    }
}
