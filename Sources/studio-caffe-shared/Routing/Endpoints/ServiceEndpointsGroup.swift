import Foundation

public struct ServicePartDTO: Identifiable, Codable, Equatable, Hashable, Sendable {
    public init(id: UUID, product: ProductID, quantity: Double) {
        self.id = id
        self.product = product
        self.quantity = quantity
    }

    public var id: UUID
    public var product: ProductID
    public var quantity: Double
}

public struct ServiceDTO: Identifiable, Codable, Equatable, Hashable, Sendable {
    public init(id: UUID, machineID: UUID, items: [ServiceItemDTO],
                serviceDate: Date, counter: Int?, userID: UUID, recordedAt: Date?, note: String?, parts: [ServicePartDTO],
                requestID: UUID? = nil) {
        self.id = id
        self.machineID = machineID
        self.items = items
        self.serviceDate = serviceDate
        self.counter = counter
        self.userID = userID
        self.recordedAt = recordedAt
        self.note = note
        self.parts = parts
        self.requestID = requestID
    }

    public var id: UUID
    public var machineID: UUID
    public var items: [ServiceItemDTO]
    public var serviceDate: Date
    public var counter: Int?
    public var userID: UUID
    public var recordedAt: Date?
    public var note: String?
    public var parts: [ServicePartDTO]
    public var requestID: UUID?
}

public struct ServicePartToSave: Codable, Equatable, Hashable, Sendable {
    public init(productID: UUID, quantity: Double) {
        self.productID = productID
        self.quantity = quantity
    }

    public var productID: UUID
    public var quantity: Double
}

public struct ServiceToSave: Identifiable, Codable, Equatable, Hashable, RequestBody, Sendable {
    public init(id: UUID, machineID: UUID, items: [ServiceItemToSave],
                serviceDate: Date, counter: Int?, note: String? = nil, parts: [ServicePartToSave] = [],
                allowInconsistentCounter: Bool? = nil, requestID: UUID? = nil) {
        self.id = id
        self.machineID = machineID
        self.items = items
        self.serviceDate = serviceDate
        self.counter = counter
        self.note = note
        self.parts = parts
        self.allowInconsistentCounter = allowInconsistentCounter
        self.requestID = requestID
    }

    public var id: UUID
    public var machineID: UUID
    public var items: [ServiceItemToSave]
    public var serviceDate: Date
    public var counter: Int?
    public var note: String?
    public var parts: [ServicePartToSave]
    // Missing/false requires validation; true records an explicit user confirmation.
    public var allowInconsistentCounter: Bool?
    public var requestID: UUID?
}

public struct ServicePageDTO: Codable, Equatable, Sendable {
    public init(items: [ServiceDTO], page: Int, per: Int, total: Int) {
        self.items = items
        self.page = page
        self.per = per
        self.total = total
    }

    public var items: [ServiceDTO]
    public var page: Int
    public var per: Int
    public var total: Int
}

public struct ServiceEndpointsGroup: EndpointGroupType {
    public static var group: String { "service" }

    public static func save(service: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [PathParameter(name: "save", value: nil)]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: service)
    }

    public static func find(id: UUID? = nil) -> EndpointConfiguration {
        let parameters = [PathParameter(name: "find", value: nil),
                          PathParameter(name: "id", value: .uuid(id))]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }

    public static func fetchByMachine(machineID: UUID? = nil, filter: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [PathParameter(name: "fetch_by_machine", value: nil),
                          PathParameter(name: "machine_id", value: .uuid(machineID))]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
}
