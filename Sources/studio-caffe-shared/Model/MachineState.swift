import Foundation

public enum MachineState: String, Codable, Identifiable, CaseIterable, Sendable, CustomStringConvertible, CustomRawRepresentable {
    case deposito
    case installato
    case dismesso
    case venduto
    case rottamato

    public var id: String { rawValue }
    public var description: String { rawValue }

    /// Il ruolo descrive il collegamento fisico al pagamento, anche durante il deposito.
    public var permitsPaymentAssociation: Bool { self == .installato || self == .deposito }

    public func associationValidationMessage(hasSellingPoint: Bool, hasAdeDevice: Bool,
                                              installationRole: InstallationRole?) -> String? {
        guard (self == .installato) == hasSellingPoint else {
            return "Il punto vendita deve essere presente solo per una macchina installata."
        }
        guard (installationRole != nil) == hasAdeDevice else {
            return "Il ruolo di pagamento deve corrispondere al sistema AdE associato."
        }
        guard installationRole == nil || permitsPaymentAssociation else {
            return "Un sistema di pagamento può restare associato solo a una macchina installata o in deposito."
        }
        return nil
    }

    public var manualTransitions: [MachineState] {
        switch self {
        case .installato, .venduto: []
        case .deposito, .dismesso, .rottamato: [.deposito, .dismesso, .rottamato].filter { $0 != self }
        }
    }
}
