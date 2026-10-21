import Foundation

public enum ServiceRequestStatus: String, Codable, Identifiable, CaseIterable, Sendable, CustomStringConvertible {
    case aperta
    case risolta
    case nonRisolta = "non_risolta"
    case pendente

    public var id: String { rawValue }
    public var description: String { self == .nonRisolta ? "non risolta" : rawValue }
}
