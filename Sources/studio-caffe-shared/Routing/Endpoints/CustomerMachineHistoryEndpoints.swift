import Foundation

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

public extension CustomerEndpointsGroup {
    static func fetchMachineHistory(customerID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "fetch_machine_history", value: nil),
            PathParameter(name: "customer_id", value: .uuid(customerID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
