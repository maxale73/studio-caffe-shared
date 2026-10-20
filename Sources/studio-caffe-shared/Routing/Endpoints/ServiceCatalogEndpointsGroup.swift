import Foundation

public struct ServiceCatalogDTO: Identifiable, Codable, Equatable, Hashable, RequestBody, Sendable {
    public init(id: UUID, serviceDescription: String, isActive: Bool = true, hasBeenUsed: Bool = false) {
        self.id = id
        self.serviceDescription = serviceDescription
        self.isActive = isActive
        self.hasBeenUsed = hasBeenUsed
    }

    public var id: UUID
    public var serviceDescription: String
    public var isActive: Bool
    public var hasBeenUsed: Bool

    private enum CodingKeys: String, CodingKey {
        case id, serviceDescription, isActive, hasBeenUsed
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(id: try container.decode(UUID.self, forKey: .id),
                  serviceDescription: try container.decode(String.self, forKey: .serviceDescription),
                  isActive: try container.decode(Bool.self, forKey: .isActive),
                  hasBeenUsed: try container.decodeIfPresent(Bool.self, forKey: .hasBeenUsed) ?? false)
    }
}

public struct ServiceCatalogEndpointsGroup: EndpointGroupType {
    public static var group: String { "service_catalog" }

    public static func index() -> EndpointConfiguration {
        let parameters = [PathParameter(name: "index", value: nil)]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }

    public static func save(service: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [PathParameter(name: "save", value: nil)]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: service)
    }

    public static func delete(catalogID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [PathParameter(name: "delete", value: nil),
                          PathParameter(name: "catalog_id", value: .uuid(catalogID))]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post)
    }
}
