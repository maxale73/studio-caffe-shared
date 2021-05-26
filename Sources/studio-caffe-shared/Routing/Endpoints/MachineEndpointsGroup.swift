import Foundation

public struct MachineDTO: Identifiable, Equatable, Hashable, Codable, RequestBody {
    
    public var id: UUID
    public var internalID: Int = 1001
    public var factoryID: String
    public var model: MachineModelDTO
    public var notes: [String]?
    public var installation: InstallationType
    public var sellingPoint: UUID?
    public var adeDevice: UUID?
    
    public init(
        id: UUID,
        internalID: Int,
        factoryID: String,
        model: MachineModelDTO,
        notes: [String]?,
        installation: InstallationType,
        sellingPoint: UUID?,
        adeDevice: UUID?
    ) {
        self.id = id
        self.internalID = internalID
        self.factoryID = factoryID
        self.model = model
        self.installation = installation
        self.sellingPoint = sellingPoint
        self.adeDevice = adeDevice
    }
    
    public static func new() -> MachineDTO {
        MachineDTO(id: UUID(), internalID: 0, factoryID: "", model: .emptyModel, notes: nil, installation: .deposito, sellingPoint: nil, adeDevice: nil)
    }
    
    public static func == (lhs: MachineDTO, rhs: MachineDTO) -> Bool {
        return
            lhs.id == rhs.id
            && lhs.internalID == rhs.internalID
            && lhs.installation == rhs.installation
            && lhs.sellingPoint == rhs.sellingPoint
        && lhs.factoryID == rhs.factoryID
        && lhs.model == rhs.model
        && lhs.adeDevice == rhs.adeDevice
    }
}

public struct FilteredMachineDTO: Equatable, Identifiable, Hashable, Codable {
    
    public var id: UUID
    public var internalID: Int
    public var factoryID: String
    public var model: MachineModelDTO
    
    public init(machine: MachineDTO) {
        self.id = machine.id
        self.internalID = machine.internalID
        self.factoryID = machine.factoryID
        self.model = machine.model
    }
    
    public init(id: UUID, internalID: Int, factoryID: String, model: MachineModelDTO) {
        self.id = id
        self.internalID = internalID
        self.factoryID = factoryID
        self.model = model
    }
}

public struct MachineBySP: Codable, Hashable, Identifiable {
    public init(id: UUID, internalID: Int, factoryID: String, notes: [String]? = nil, installation: InstallationType, model: MachineModelDTO, adeDevice: AdeDeviceDTO? = nil) {
        self.id = id
        self.internalID = internalID
        self.factoryID = factoryID
        self.notes = notes
        self.installation = installation
        self.model = model
        self.adeDevice = adeDevice
    }
    
    
    public var id: UUID
    public var internalID: Int
    public var factoryID: String
    public var notes: [String]?
    public var installation: InstallationType
    
    public var model: MachineModelDTO
    public var adeDevice: AdeDeviceDTO?
    
    public static func == (lhs: MachineBySP, rhs: MachineBySP) -> Bool {
        lhs.id == rhs.id
            && lhs.internalID == rhs.internalID
            && lhs.factoryID == rhs.factoryID
            && lhs.notes == rhs.notes
            && lhs.installation == rhs.installation
            && lhs.model == rhs.model
            && lhs.adeDevice == rhs.adeDevice
    }
}

public struct MachineEndpointsGroup: EndpointGroupType {
    
    public static var group = "machine"
    
    public static func save(machine: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: machine)
    }
    
    public static func indexWithFilter(filter: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index_with_filter", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
    
    public static func indexUninstalled() -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index_uninstalled", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func saveBySP(machineBySP: RequestBody? = nil, sellingPointID: UUID? = nil, updateHistory: Bool? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save_by_sp", value: nil),
            PathParameter(name: "selling_point_id", value: .uuid(sellingPointID)),
            PathParameter(name: "update_history", value: .bool(updateHistory))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: machineBySP)
    }
    
    public static func finfComplete(id: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "find_complete", value: nil),
            PathParameter(name: "id", value: .uuid(id))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func findIn(ids: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "find_in", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: ids)
    }
    
    public static func uninstall(sellingPointID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "uninstall", value: nil),
            PathParameter(name: "selling_point_id", value: .uuid(sellingPointID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post)
    }
}
