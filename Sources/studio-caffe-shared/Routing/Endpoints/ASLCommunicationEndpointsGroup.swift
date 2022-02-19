import Foundation

public struct ASLCommunicationDTO: Identifiable, Equatable, Codable, RequestBody {
    
    public init(id: UUID,
                type: ASLCommunicationType,
                referencePeriod: String,
                date: Date,
                controlledTemperature: Bool,
                note: String,
                sellingPointID: IDType) {
        
        self.id = id
        self.type = type
        self.referencePeriod = referencePeriod
        self.controlledTemperature = controlledTemperature
        self.note = note
        self.date = date
        self.sellingPoint = sellingPointID
    }
    
    public var id: UUID
    public var type: ASLCommunicationType
    public var referencePeriod: String
    public var date: Date
    public var controlledTemperature: Bool
    public var note: String
    public var sellingPoint: IDType
    
    public static func == (lhs: ASLCommunicationDTO, rhs: ASLCommunicationDTO) -> Bool {
        return lhs.id == rhs.id &&
            lhs.type == rhs.type &&
            lhs.referencePeriod == rhs.referencePeriod &&
            lhs.controlledTemperature == rhs.controlledTemperature &&
            lhs.date == rhs.date &&
            lhs.note == rhs.note &&
            lhs.sellingPoint == rhs.sellingPoint
    }
}

public struct ASLCommunicationsBySP: Identifiable, Equatable, Codable {
    public var id: UUID
    public var communications: [ASLCommunicationDTO]
    public var customer: String
    public var sellingPoint: Int
    public var ubicazione: String
    
    public init(id: UUID, communications: [ASLCommunicationDTO], customer: String, sellingPoint: Int, ubicazione: String) {
        self.id = id
        self.communications = communications
        self.customer = customer
        self.sellingPoint = sellingPoint
        self.ubicazione = ubicazione
    }
}

public struct ASLCommunicationEndpointsGroup: EndpointGroupType {
    public static var group = "asl_communication"
    
    public static func save(communication: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "create", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: communication)
    }
    
    public static func indexBySellingPoint(sellingPointID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index_by_selling_point", value: nil),
            PathParameter(name: "selling_point_id", value: .uuid(sellingPointID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get, body: nil)
    }
    
    public static func delete(communicationID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "delete", value: nil),
            PathParameter(name: "communication_ID", value: .uuid(communicationID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: nil)
    }
}
