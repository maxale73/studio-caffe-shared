import Foundation

public struct ProductTypologyDTO: Identifiable, Codable, Equatable, Hashable {
    
    public init(id: UUID, typologyDescription: String) {
        self.id = id
        self.typologyDescription = typologyDescription
    }
    
    public var id: UUID
    public var typologyDescription: String
    
}

extension ProductTypologyDTO: RequestBody {}

public struct ProductTypologyEndpointsGroup: EndpointGroupType {
    
    public static var group = "productTypology"
    
    public static func index(filter: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
    
    public static func save(typology: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: typology)
    }
    
}
