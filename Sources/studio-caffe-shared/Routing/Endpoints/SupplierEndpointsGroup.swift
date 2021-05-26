import Foundation

public struct SupplierName: Codable, Identifiable, Equatable, Hashable {
    
    public init(id: UUID, businessName: String) {
        self.id = id
        self.businessName = businessName
    }
    
    public var id: UUID
    public var businessName: String
}

extension SuppliersFilter: RequestBody {}

public struct SupplierEndpointsGroup: EndpointGroupType {
    
    public static var group = "supplier"
    
    public static func indexWithFilter(filter: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index_with_filter", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
    
    public static func save(supplier: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: supplier)
    }
    
    public static func find(id: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "find", value: nil),
            PathParameter(name: "id", value: .uuid(id))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
