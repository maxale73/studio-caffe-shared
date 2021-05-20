import Foundation

public struct MachineModelDTO: Codable, Hashable, Identifiable, Equatable {
    
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
    
    static let emptyModel: MachineModelDTO = MachineModelDTO(id: UUID(), maker: "", model: "", type: .caldo)
}

public struct MachineModelEndpointsGroup: EndpointGroupType {
    
    public static var group = "machineModel"
    
    public static func save(machineModel: Body? = nil) -> EndpointConfiguration {
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
}