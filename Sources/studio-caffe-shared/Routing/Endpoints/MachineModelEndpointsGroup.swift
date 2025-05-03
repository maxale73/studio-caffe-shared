import Foundation

public let emptyMachineModelID = UUID()

public struct MachineModelDTO: Codable, Hashable, Identifiable, Equatable, Sendable {
    
    public var id: UUID
    public var maker: String
    public var model: String
    public var type: MachineModelType

    public init(id: UUID,
         maker: String,
         model: String,
         type: MachineModelType) {
        
        self.id = id
        self.maker = maker
        self.model = model
        self.type = type
    }
    
    public static func == (lhs: MachineModelDTO, rhs: MachineModelDTO) -> Bool {
        return
            lhs.id == rhs.id
            && lhs.maker == rhs.maker
            && lhs.model == rhs.model
            && lhs.type == rhs.type
    }
}

public extension MachineModelDTO {
    var makerPlusModel: String {
        maker + " " + model
    }
    
    static var emptyModel: MachineModelDTO {
        MachineModelDTO(id: emptyMachineModelID, maker: "", model: "", type: .caldo)
    }
}

public struct MachineByModel: Codable, Hashable, Identifiable, Equatable, Sendable {
    
    public init(id: UUID, internalID: Int, factoryID: String, installation: InstallationType) {
        self.id = id
        self.internalID = internalID
        self.factoryID = factoryID
        self.installation = installation
    }
    
    public var id: UUID
    public var internalID: Int
    public var factoryID: String
    public var installation: InstallationType
}

public struct ModelWithStocks: Codable, Hashable, Identifiable, Equatable, Sendable {
    public init(id: UUID, model: MachineModelDTO, stocks: [AverageStockDTO]) {
        self.id = id
        self.model = model
        self.stocks = stocks
    }
    
    public var id: UUID
    public var model: MachineModelDTO
    public var stocks: [AverageStockDTO]
}

public struct MachineModelEndpointsGroup: EndpointGroupType {
    
    public static var group: String { "machineModel" }
    
    public static func fetchModel(id: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "fetch_model", value: nil),
            PathParameter(name: "modelID", value: .uuid(id))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func fetchModelWithStocks(id: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "fetch_model_with_stocks", value: nil),
            PathParameter(name: "modelID", value: .uuid(id))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func save(machineModel: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: machineModel)
    }
    
    public static func index() -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func machinesByModel(modelID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "machines_by_model", value: nil),
            PathParameter(name: "modelID", value: .uuid(modelID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
