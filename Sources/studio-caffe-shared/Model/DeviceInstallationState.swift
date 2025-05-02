
import Foundation

public enum DeviceInstallationState: String, CaseIterable, RawRepresentable, Identifiable, Codable, Sendable {
    
    public var id: String {
        rawValue
    }
    case uninstalled = "non installati"
    case installed = "installati"
}

extension DeviceInstallationState: CustomRawRepresentable {}
