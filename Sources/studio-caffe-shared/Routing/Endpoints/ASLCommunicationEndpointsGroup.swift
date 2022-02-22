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
    var currentlyInstalled: Bool { get set }
    var sellingPoint: Int { get set }
    func communicationsBalance() -> Int
    func communicationsAnomalies() -> Bool
    func noCommunications() -> Bool
    func notCommunicated() -> Bool
    func correctlyCommunicated() -> Bool
    func incorrectlyCommunicated() -> Bool
    func notes() -> [String]
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
    
    public func notCommunicated() -> Bool {
        currentlyInstalled && communicationsBalance() == 0
    }
    
    public func correctlyCommunicated() -> Bool {
        (!currentlyInstalled && communicationsBalance() == 0) || (currentlyInstalled && communicationsBalance() == 1)
    }
    
    public func incorrectlyCommunicated() -> Bool {
        (!currentlyInstalled && communicationsBalance() == 1) || communicationsAnomalies()
    }
    
    public func notes() -> [String] {
        var notes = [String]()
        for com in communications {
            if !com.note.isEmpty {
                notes.append(sellingPoint.textDescription)
                notes.append(" - ")
                notes.append(com.date.formatted(date: .numeric, time: .omitted))
                notes.append(" - ")
                notes.append(com.note)
                notes.append("\n")
            }
        }
        if !notes.isEmpty {
            notes.removeLast()
        }
        return notes
    }
}

public struct ASLCommunicationsBySP: Identifiable, Equatable, Codable, ASLSellingPoint {
    public var id: UUID
    public var communications: [ASLCommunicationDTO]
    public var customer: String
    public var sellingPoint: Int
    public var ubicazione: String
    public var currentlyInstalled: Bool = false
    
    public init(id: UUID, communications: [ASLCommunicationDTO], customer: String, sellingPoint: Int, ubicazione: String) {
        self.id = id
        self.communications = communications
        self.customer = customer
        self.sellingPoint = sellingPoint
        self.ubicazione = ubicazione
    }
}

public struct ASLCommunicationsSellingPoint: Identifiable, Equatable, Codable, ASLSellingPoint {
    
    public init(id: UUID, communications: [ASLCommunicationDTO], sellingPoint: Int, site: String, currentlyInstalled: Bool) {
        self.id = id
        self.communications = communications
        self.sellingPoint = sellingPoint
        self.site = site
        self.currentlyInstalled = currentlyInstalled
    }
    
    public var id: UUID //sellingPointID
    public var communications: [ASLCommunicationDTO]
    public var sellingPoint: Int
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
    
    public var installedMachines: Int {
        sellingPoints.filter({ $0.currentlyInstalled }).count
    }
    
    public var communicationsBalance: Int {
        sellingPoints.reduce(0) { partialResult, sp in
            partialResult + sp.communicationsBalance()
        }
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
    
    public static func indexByAddress(filter: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index_by_address", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
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
