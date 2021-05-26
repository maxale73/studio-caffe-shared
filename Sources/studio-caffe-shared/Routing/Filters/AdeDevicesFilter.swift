import Foundation

public let defaultFilterID: UUID = UUID()

public struct AdeDeviceFilters: Equatable, Codable, Identifiable,RequestBody {
    public var id: UUID
    public var installationStateFilters: [DeviceInstallationState]
    public var modelFilters: [AdeDeviceModel]
    public var qrCodeFilter: String
    public var textFilter: String
    
    public var empty: Bool {
        installationStateFilters.isEmpty && modelFilters.isEmpty && qrCodeFilter.isEmpty && textFilter.isEmpty
    }
    
    public static func ==(lhs: AdeDeviceFilters, rhs: AdeDeviceFilters) -> Bool {
        return lhs.installationStateFilters == rhs.installationStateFilters
        && lhs.modelFilters == rhs.modelFilters
        && lhs.qrCodeFilter == rhs.qrCodeFilter
        && lhs.textFilter == rhs.textFilter
    }
    
    public static var emptyFilter: AdeDeviceFilters {
        AdeDeviceFilters(id: defaultFilterID, installationStateFilters: [], modelFilters: [], qrCodeFilter: "", textFilter: "")
    }
    
    public static func qrCodeFilter(qrCode: String) -> AdeDeviceFilters {
        AdeDeviceFilters(id: defaultFilterID, installationStateFilters: [], modelFilters: [], qrCodeFilter: qrCode, textFilter: "")
    }
}
