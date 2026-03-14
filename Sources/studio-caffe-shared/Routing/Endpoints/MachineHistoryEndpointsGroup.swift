import Foundation

public struct MachineHistoryDTO: Identifiable, Equatable, Codable, Sendable {
    public init(id: UUID, machineID: UUID, sellingPointID: UUID, installation: InstallationType, date: Date, sellingPoitCode: Int, customer: String) {
        self.id = id
        self.machineID = machineID
        self.sellingPointID = sellingPointID
        self.installation = installation
        self.date = date
        self.sellingPoitCode = sellingPoitCode
        self.customer = customer
    }
    
    public var id: UUID
    public var machineID: UUID
    public var sellingPointID: UUID
    public var installation: InstallationType
    public var date: Date
    public var sellingPoitCode: Int
    public var customer: String
    
    public var stateDescription: String {
        switch installation {
            case .associato: return "installato"
            case .deposito: return "ritirato"
            default: return "indefinito"
        }
    }
    
    public static func == (lhs: MachineHistoryDTO, rhs: MachineHistoryDTO) -> Bool {
        return lhs.id == rhs.id &&
            lhs.machineID == rhs.machineID &&
            lhs.sellingPointID == rhs.sellingPointID &&
            lhs.installation == rhs.installation &&
            lhs.date == rhs.date &&
            lhs.sellingPoitCode == rhs.sellingPoitCode &&
            lhs.customer == rhs.customer
    }
}

public struct HistoryDTO: Identifiable, Equatable, Codable, Hashable, Sendable {
    public init(id: UUID, machineID: Int, model: String, machineType: MachineModelType, installation: InstallationType, date: Date, customer: String, address: String, city: String) {
        self.id = id
        self.machineID = machineID
        self.model = model
        self.machineType = machineType
        self.installation = installation
        self.date = date
        self.customer = customer
        self.address = address
        self.city = city
    }
    
    public var id: UUID
    public var machineID: Int
    public var model: String
    public var machineType: MachineModelType
    public var installation: InstallationType
    public var date: Date
    public var customer: String
    public var address: String
    public var city: String
}

public struct CustomerMachineHistoryDTO: Identifiable, Codable, Equatable, Sendable {
    public init(
        id: UUID,
        date: Date,
        sellingPoint: Int,
        machineInternalID: Int,
        machineFactoryID: String,
        event: InstallationType
    ) {
        self.id = id
        self.date = date
        self.sellingPoint = sellingPoint
        self.machineInternalID = machineInternalID
        self.machineFactoryID = machineFactoryID
        self.event = event
    }

    public var id: UUID
    public var date: Date
    public var sellingPoint: Int
    public var machineInternalID: Int
    public var machineFactoryID: String
    public var event: InstallationType

    public var eventDescription: String {
        switch event {
        case .associato: return "installato"
        case .deposito: return "ritirato"
        default: return "indefinito"
        }
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
