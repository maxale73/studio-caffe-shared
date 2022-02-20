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

public protocol ASLSellingPoint {
    var communications: [ASLCommunicationDTO] { get set }
    func communicationsBalance() -> Int
    func communicationsAnomalies() -> Bool
    func noCommunications() -> Bool
}

extension ASLSellingPoint {
    public func communicationsBalance() -> Int {
        let disinstallations = communications.filter({ $0.type == .disinstallazione }).count
        let installations = communications.filter({ $0.type == .installazione }).count
        return installations - disinstallations
    }
    
    public func communicationsAnomalies() -> Bool {
        let bal = communicationsBalance()
        return bal < 0 || bal > 1
    }
    
    public func noCommunications() -> Bool {
        communications.isEmpty
    }
}

public struct ASLCommunicationsBySP: Identifiable, Equatable, Codable, ASLSellingPoint {
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

public struct ASLCommunicationsSellingPoint: Identifiable, Equatable, Codable, ASLSellingPoint {
    
    public init(id: UUID, communications: [ASLCommunicationDTO], sellingPointID: Int, site: String, currentlyInstalled: Bool) {
        self.id = id
        self.communications = communications
        self.sellingPointID = sellingPointID
        self.site = site
        self.currentlyInstalled = currentlyInstalled
    }
    
    public var id: UUID //sellingPointID
    public var communications: [ASLCommunicationDTO]
    public var sellingPointID: Int
    public var site: String
    public var currentlyInstalled: Bool
}

public struct ASLCommunicationsByAddress: Identifiable, Equatable, Codable {
    public init(id: UUID, city: String, addressDescription: String, customer: String, sellingPoints: [ASLCommunicationsSellingPoint]) {
        self.id = id
        self.city = city
        self.addressDescription = addressDescription
        self.customer = customer
        self.sellingPoints = sellingPoints
    }
    
    public var id: UUID //addressID
    public var city: String
    public var addressDescription: String
    public var customer: String
    public var sellingPoints: [ASLCommunicationsSellingPoint]
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
    
    public static func indexByAddress(customerID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index_by_address", value: nil),
            PathParameter(name: "customer_id", value: .uuid(customerID))
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
