import Foundation

public enum BillAcceptor: String, Codable, CaseIterable, Identifiable, Sendable {
    public var id: String {
        rawValue
    }
    case MEI_CF_2612 = "MEI CF 2612"
    case ICT_V7 = "ICT V7"
    case none = "nessuno"
    
    public var billAcceptorDescription: String {
        switch self {
        case .none: return ""
        default: return "lettore banconote(\(rawValue))"
        }
    }
}

extension BillAcceptor: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}
