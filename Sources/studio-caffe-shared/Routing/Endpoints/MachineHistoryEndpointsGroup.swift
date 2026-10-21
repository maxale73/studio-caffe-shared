import Foundation

public struct MachineHistoryDTO: Identifiable, Equatable, Codable, Sendable {
    public init(id: UUID, machineID: UUID, sellingPointID: UUID, eventType: MachineHistoryEventType, date: Date, sellingPoitCode: Int, customer: String) {
        self.id = id
        self.machineID = machineID
        self.sellingPointID = sellingPointID
        self.eventType = eventType
        self.date = date
        self.sellingPoitCode = sellingPoitCode
        self.customer = customer
    }
    
    public var id: UUID
    public var machineID: UUID
    public var sellingPointID: UUID
    public var eventType: MachineHistoryEventType
    public var installation: InstallationType { eventType.legacyInstallation }
    public var date: Date
    public var sellingPoitCode: Int
    public var customer: String
    
    public var stateDescription: String { eventType.description }
    
    public static func == (lhs: MachineHistoryDTO, rhs: MachineHistoryDTO) -> Bool {
        return lhs.id == rhs.id &&
            lhs.machineID == rhs.machineID &&
            lhs.sellingPointID == rhs.sellingPointID &&
            lhs.eventType == rhs.eventType &&
            lhs.date == rhs.date &&
            lhs.sellingPoitCode == rhs.sellingPoitCode &&
            lhs.customer == rhs.customer
    }

    private enum CodingKeys: String, CodingKey {
        case id, machineID, sellingPointID, eventType, date, sellingPoitCode, customer, installation
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        eventType = try container.machineHistoryEvent(eventKey: .eventType, legacyKey: .installation)
        id = try container.decode(UUID.self, forKey: .id)
        machineID = try container.decode(UUID.self, forKey: .machineID)
        sellingPointID = try container.decode(UUID.self, forKey: .sellingPointID)
        date = try container.decode(Date.self, forKey: .date)
        sellingPoitCode = try container.decode(Int.self, forKey: .sellingPoitCode)
        customer = try container.decode(String.self, forKey: .customer)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(machineID, forKey: .machineID)
        try container.encode(sellingPointID, forKey: .sellingPointID)
        try container.encode(eventType, forKey: .eventType)
        try container.encode(date, forKey: .date)
        try container.encode(sellingPoitCode, forKey: .sellingPoitCode)
        try container.encode(customer, forKey: .customer)
        try container.encode(eventType.legacyInstallation, forKey: .installation)
    }
}

public struct HistoryDTO: Identifiable, Equatable, Codable, Hashable, Sendable {
    public init(id: UUID, machineID: Int, model: String, machineType: MachineModelType, eventType: MachineHistoryEventType, date: Date, customer: String, address: String, city: String) {
        self.id = id
        self.machineID = machineID
        self.model = model
        self.machineType = machineType
        self.eventType = eventType
        self.date = date
        self.customer = customer
        self.address = address
        self.city = city
    }
    
    public var id: UUID
    public var machineID: Int
    public var model: String
    public var machineType: MachineModelType
    public var eventType: MachineHistoryEventType
    public var installation: InstallationType { eventType.legacyInstallation }
    public var date: Date
    public var customer: String
    public var address: String
    public var city: String

    private enum CodingKeys: String, CodingKey {
        case id, machineID, model, machineType, eventType, date, customer, address, city, installation
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        eventType = try container.machineHistoryEvent(eventKey: .eventType, legacyKey: .installation)
        id = try container.decode(UUID.self, forKey: .id)
        machineID = try container.decode(Int.self, forKey: .machineID)
        model = try container.decode(String.self, forKey: .model)
        machineType = try container.decode(MachineModelType.self, forKey: .machineType)
        date = try container.decode(Date.self, forKey: .date)
        customer = try container.decode(String.self, forKey: .customer)
        address = try container.decode(String.self, forKey: .address)
        city = try container.decode(String.self, forKey: .city)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(machineID, forKey: .machineID)
        try container.encode(model, forKey: .model)
        try container.encode(machineType, forKey: .machineType)
        try container.encode(eventType, forKey: .eventType)
        try container.encode(date, forKey: .date)
        try container.encode(customer, forKey: .customer)
        try container.encode(address, forKey: .address)
        try container.encode(city, forKey: .city)
        try container.encode(eventType.legacyInstallation, forKey: .installation)
    }
}

public struct CustomerMachineHistoryDTO: Identifiable, Codable, Equatable, Sendable {
    public init(
        id: UUID,
        date: Date,
        sellingPoint: Int,
        site: String,
        machineInternalID: Int,
        model: String,
        machineFactoryID: String,
        eventType: MachineHistoryEventType
    ) {
        self.id = id
        self.date = date
        self.sellingPoint = sellingPoint
        self.site = site
        self.machineInternalID = machineInternalID
        self.model = model
        self.machineFactoryID = machineFactoryID
        self.eventType = eventType
    }

    public var id: UUID
    public var date: Date
    public var sellingPoint: Int
    public var site: String
    public var machineInternalID: Int
    public var model: String
    public var machineFactoryID: String
    public var eventType: MachineHistoryEventType
    public var event: InstallationType { eventType.legacyInstallation }

    public var eventDescription: String { eventType.description }

    private enum CodingKeys: String, CodingKey {
        case id, date, sellingPoint, site, machineInternalID, model, machineFactoryID, eventType, event
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        eventType = try container.machineHistoryEvent(eventKey: .eventType, legacyKey: .event)
        id = try container.decode(UUID.self, forKey: .id)
        date = try container.decode(Date.self, forKey: .date)
        sellingPoint = try container.decode(Int.self, forKey: .sellingPoint)
        site = try container.decode(String.self, forKey: .site)
        machineInternalID = try container.decode(Int.self, forKey: .machineInternalID)
        model = try container.decode(String.self, forKey: .model)
        machineFactoryID = try container.decode(String.self, forKey: .machineFactoryID)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(sellingPoint, forKey: .sellingPoint)
        try container.encode(site, forKey: .site)
        try container.encode(machineInternalID, forKey: .machineInternalID)
        try container.encode(model, forKey: .model)
        try container.encode(machineFactoryID, forKey: .machineFactoryID)
        try container.encode(eventType, forKey: .eventType)
        try container.encode(eventType.legacyInstallation, forKey: .event)
    }
}

public struct MachineHistoryEndpointsGroup: EndpointGroupType {
    
    public static var group: String { "machine_history" }
    
    public static func fetchSellingPoints(machineID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "fetch_selling_points", value: nil),
            PathParameter(name: "machine_id", value: .uuid(machineID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func fetchHistory(from: Date? = nil, to: Date? = nil) -> EndpointConfiguration {
        let parameters = [ PathParameter(name: "fetch_history", value: nil),
                           PathParameter(name: "from", value: .date(from)),
                           PathParameter(name: "to", value: .date(to))]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func fetchMachineHistory(customerID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "fetch_machine_history", value: nil),
            PathParameter(name: "customer_id", value: .uuid(customerID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
