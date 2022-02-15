import Foundation

public struct ASLCommunicationDTO: Identifiable, Equatable, Codable, RequestBody {
    
    public init(id: UUID,
                type: ASLCommunicationType,
                referencePeriod: String,
                date: Date,
                controlledTemperature: Bool,
                sellingPointID: UUID) {
        
        self.id = id
        self.type = type
        self.referencePeriod = referencePeriod
        self.controlledTemperature = controlledTemperature
        self.date = date
        self.sellingPointID = sellingPointID
    }
    
    public var id: UUID
    public var type: ASLCommunicationType
    public var referencePeriod: String
    public var date: Date
    public var controlledTemperature: Bool
    public var sellingPointID: UUID
    
    public static func == (lhs: ASLCommunicationDTO, rhs: ASLCommunicationDTO) -> Bool {
        return lhs.id == rhs.id &&
            lhs.type == rhs.type &&
            lhs.referencePeriod == rhs.referencePeriod &&
            lhs.controlledTemperature == rhs.controlledTemperature &&
            lhs.date == rhs.date &&
            lhs.sellingPointID == rhs.sellingPointID
    }
}

public struct ASLCommunicationsBySP: Identifiable, Equatable, Codable {
    public var id: UUID
    public var communications: [ASLCommunicationDTO]
    public var customer: String
    public var sellingPoint: String
    public var ubicazione: String
}

public struct ASLCommunicationEndpointsGroup: EndpointGroupType {
    public static var group = "asl_communication"
    
    public static func create(communication: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "create", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: communication)
    }
    
    public static func indexBySellingPoint(sellingPointID: UUID) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index_by_selling_point", value: nil),
            PathParameter(name: "selling_point_id", value: .uuid(sellingPointID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get, body: nil)
    }
}
