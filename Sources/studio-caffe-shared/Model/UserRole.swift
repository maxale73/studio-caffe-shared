import Foundation

public enum UserRole: String, Codable, CaseIterable, RawRepresentable, Identifiable, Sendable {
    public var id: String { rawValue }
    case amministratore
    case gestore
    case visitatore
}

extension UserRole: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}
