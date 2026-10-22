import Foundation

public struct ServiceRequestDTO: Identifiable, Codable, Equatable, Sendable {
    public var id: UUID
    public var machineID: UUID
    public var requestDate: Date
    public var source: ServiceRequestSource
    public var status: ServiceRequestStatus
    public var catalog: ServiceCatalogDTO?
    public var operationType: ServiceOperationType?
    public var note: String?
    public var userID: UUID
    public var recordedAt: Date?
    public var serviceIDs: [UUID]

    public init(id: UUID, machineID: UUID, requestDate: Date, source: ServiceRequestSource,
                status: ServiceRequestStatus = .aperta, catalog: ServiceCatalogDTO? = nil,
                operationType: ServiceOperationType? = nil, note: String? = nil,
                userID: UUID, recordedAt: Date? = nil, serviceIDs: [UUID] = []) {
        self.id = id
        self.machineID = machineID
        self.requestDate = requestDate
        self.source = source
        self.status = status
        self.catalog = catalog
        self.operationType = operationType
        self.note = note
        self.userID = userID
        self.recordedAt = recordedAt
        self.serviceIDs = serviceIDs
    }

    private enum CodingKeys: String, CodingKey {
        case id, machineID, requestDate, source, status, catalog, operationType, note, userID, recordedAt, serviceIDs
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(id: try container.decode(UUID.self, forKey: .id),
                  machineID: try container.decode(UUID.self, forKey: .machineID),
                  requestDate: try container.decode(Date.self, forKey: .requestDate),
                  source: try container.decode(ServiceRequestSource.self, forKey: .source),
                  status: try container.decodeIfPresent(ServiceRequestStatus.self, forKey: .status) ?? .aperta,
                  catalog: try container.decodeIfPresent(ServiceCatalogDTO.self, forKey: .catalog),
                  operationType: try container.decodeIfPresent(ServiceOperationType.self, forKey: .operationType),
                  note: try container.decodeIfPresent(String.self, forKey: .note),
                  userID: try container.decode(UUID.self, forKey: .userID),
                  recordedAt: try container.decodeIfPresent(Date.self, forKey: .recordedAt),
                  serviceIDs: try container.decodeIfPresent([UUID].self, forKey: .serviceIDs) ?? [])
    }
}

public struct ServiceRequestToSave: Identifiable, Codable, Equatable, RequestBody, Sendable {
    public var id: UUID
    public var machineID: UUID
    public var requestDate: Date
    public var source: ServiceRequestSource
    public var status: ServiceRequestStatus
    public var catalogID: UUID?
    public var operationType: ServiceOperationType?
    public var note: String?

    public init(id: UUID, machineID: UUID, requestDate: Date, source: ServiceRequestSource,
                status: ServiceRequestStatus = .aperta, catalogID: UUID? = nil,
                operationType: ServiceOperationType? = nil, note: String? = nil) {
        self.id = id
        self.machineID = machineID
        self.requestDate = requestDate
        self.source = source
        self.status = status
        self.catalogID = catalogID
        self.operationType = operationType
        self.note = note
    }

    private enum CodingKeys: String, CodingKey {
        case id, machineID, requestDate, source, status, catalogID, operationType, note
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(id: try container.decode(UUID.self, forKey: .id),
                  machineID: try container.decode(UUID.self, forKey: .machineID),
                  requestDate: try container.decode(Date.self, forKey: .requestDate),
                  source: try container.decode(ServiceRequestSource.self, forKey: .source),
                  status: try container.decodeIfPresent(ServiceRequestStatus.self, forKey: .status) ?? .aperta,
                  catalogID: try container.decodeIfPresent(UUID.self, forKey: .catalogID),
                  operationType: try container.decodeIfPresent(ServiceOperationType.self, forKey: .operationType),
                  note: try container.decodeIfPresent(String.self, forKey: .note))
    }
}

public struct ServiceRequestPageDTO: Codable, Equatable, Sendable {
    public var items: [ServiceRequestDTO]
    public var page: Int
    public var per: Int
    public var total: Int

    public init(items: [ServiceRequestDTO], page: Int, per: Int, total: Int) {
        self.items = items
        self.page = page
        self.per = per
        self.total = total
    }
}

public struct ServiceRequestEndpointsGroup: EndpointGroupType {
    public static var group: String { "service_request" }

    public static func save(request: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [PathParameter(name: "save", value: nil)]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: request)
    }

    public static func find(id: UUID? = nil) -> EndpointConfiguration {
        let parameters = [PathParameter(name: "find", value: nil), PathParameter(name: "id", value: .uuid(id))]
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
