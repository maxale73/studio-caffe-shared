import Foundation

public struct AdeDeviceDTO: Codable, Equatable, Hashable, AdeDeviceType, Body {

    public var id: UUID
    public var adeID: String
    public var qrCode: String
    public var model: AdeDeviceModel
    public var configuration: AdeDeviceConfigurationDTO

    public init(id: UUID,
         adeID: String,
         qrCode: String,
         model: AdeDeviceModel,
         configuration: AdeDeviceConfigurationDTO) {

        self.id = id
        self.adeID = adeID
        self.qrCode = qrCode
        self.model = model
        self.configuration = configuration
    }

    public static func == (lhs: AdeDeviceDTO, rhs: AdeDeviceDTO) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.adeID == rhs.adeID &&
            lhs.qrCode == rhs.qrCode &&
            lhs.model == rhs.model &&
            lhs.configuration == rhs.configuration
    }

    public static func newDevice(adeID: String, model: AdeDeviceModel ) -> AdeDeviceDTO {
        AdeDeviceDTO(id: UUID(),
                  adeID: adeID,
                  qrCode: adeID,
                  model: model,
                  configuration: AdeDeviceConfigurationDTO(id: UUID(),
                                                        coinnAcceptor: .none,
                                                        billAcceptor: .none,
                                                        appEnabled: false))
    }
}

public struct FilteredDeviceDTO: Codable, Equatable, Hashable, Identifiable {
    public init(id: UUID, adeID: String, model: AdeDeviceModel) {
        self.id = id
        self.adeID = adeID
        self.model = model
    }
    
    public let id: UUID
    public let adeID: String
    public let model: AdeDeviceModel
}

public struct AdeDeviceEndpointsGroup: EndpointGroupType {
    
    public static var group = "adeDevice"
    
    public static func uninstalled() -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "uninstalled", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func mastersByAddress(addressID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "masters_by_address", value: nil),
            PathParameter(name: "address_id", value: .uuid(addressID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func save(adeDevice: Body? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: adeDevice)
    }
    
    public static func uninstall(deviceID: UUID? = nil, machineID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "uninstall", value: nil),
            PathParameter(name: "device_id", value: .uuid(deviceID)),
            PathParameter(name: "machine_id", value: .uuid(machineID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post)
    }
    
    public static func indexWithFilter(filter: Body? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index_with_filter", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
    
    public static func findComplete(deviceID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "find_complete", value: nil),
            PathParameter(name: "device_id", value: .uuid(deviceID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func tubesStatistics(fromDate: Date? = nil, toDate: Date? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "tubes_statistics_by_device", value: nil),
            PathParameter(name: "from_date", value: .date(fromDate)),
            PathParameter(name: "to_date", value: .date(toDate))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
