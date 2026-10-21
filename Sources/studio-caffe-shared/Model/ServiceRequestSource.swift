import Foundation

public enum ServiceRequestSource: String, Codable, Identifiable, CaseIterable, Sendable, CustomStringConvertible {
    case cliente
    case operatore

    public var id: String { rawValue }
    public var description: String { rawValue }
}
