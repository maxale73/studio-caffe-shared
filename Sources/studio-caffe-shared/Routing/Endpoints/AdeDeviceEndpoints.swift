import Foundation

public struct AdeDeviceDTO: Codable, Equatable, Hashable, AdeDeviceType, RequestBody, Sendable {

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

public struct FilteredDeviceDTO: Codable, Equatable, Hashable, Identifiable, Sendable {
    public init(id: UUID, adeID: String, model: AdeDeviceModel) {
        self.id = id
        self.adeID = adeID
        self.model = model
    }
    
    public let id: UUID
    public let adeID: String
    public let model: AdeDeviceModel
}

public struct FetchedDevice: Codable, Equatable, Identifiable, Sendable {
    
    public init(id: UUID, adeID: String, qrCode: String, model: AdeDeviceModel, configuration: AdeDeviceConfigurationDTO, machineModel: MachineModelDTO? = nil, machineID: Int? = nil, customer: String? = nil, site: String? = nil) {
        self.id = id
        self.adeID = adeID
        self.qrCode = qrCode
        self.model = model
        self.configuration = configuration
        self.machineModel = machineModel
        self.machineID = machineID
        self.customer = customer
        self.site = site
    }
    
    public var id: UUID
    public var adeID: String
    public var qrCode: String
    public var model: AdeDeviceModel
    public var configuration: AdeDeviceConfigurationDTO
    public var machineModel: MachineModelDTO?
    public var machineID: Int?
    public var customer: String?
    public var site: String?
    
    public static func == (lhs: FetchedDevice, rhs: FetchedDevice) -> Bool {
        return lhs.id == rhs.id
    }
}

public struct AdeDeviceEndpointsGroup: EndpointGroupType {
    
    public static var group: String { "adeDevice" }
    
    public static func uninstalled(filter: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "uninstalled", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
    
    public static func mastersByAddress(addressID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "masters_by_address", value: nil),
            PathParameter(name: "address_id", value: .uuid(addressID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func save(adeDevice: RequestBody? = nil) -> EndpointConfiguration {
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
    
    public static func indexWithFilter(filter: RequestBody? = nil) -> EndpointConfiguration {
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
    
    public static func fetch(filter: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "fetch", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
    
    public static func auditsForDeviceByAdeID(deviceID: String? = nil, from: Date? = nil, to: Date? = nil) -> EndpointConfiguration {
        let parameters = [ PathParameter(name: "audits_for_device", value: nil),
                           PathParameter(name: "device_id", value: .string(deviceID)),
                           PathParameter(name: "from", value: .date(from)),
                           PathParameter(name: "to", value: .date(to))]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
