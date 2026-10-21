import Foundation

public enum InstallationRole: String, Codable, Identifiable, CaseIterable, Sendable, CustomStringConvertible, CustomRawRepresentable {
    case master
    case slave

    public var id: String { rawValue }
    public var description: String { rawValue }
}
