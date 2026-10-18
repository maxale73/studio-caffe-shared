import Foundation

public struct ServiceCatalogDTO: Identifiable, Codable, Equatable, Hashable, RequestBody, Sendable {
    public init(id: UUID, serviceDescription: String, isActive: Bool = true) {
        self.id = id
        self.serviceDescription = serviceDescription
        self.isActive = isActive
    }

    public var id: UUID
    public var serviceDescription: String
    public var isActive: Bool
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
}
