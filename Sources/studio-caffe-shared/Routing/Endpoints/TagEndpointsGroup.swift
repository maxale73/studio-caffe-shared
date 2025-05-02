import Foundation

public struct TagDTO: Codable, Identifiable, Hashable, Equatable {
    
    public init(id: UUID, tag: String) {
        self.id = id
        self.tag = tag
    }
    

    public var id: UUID
    public var tag: String
    
    public static func == (lhs: TagDTO, rhs: TagDTO) -> Bool {
        lhs.tag == rhs.tag
    }
}

public struct TagEndpointsGroup: EndpointGroupType {
    
    public static var group: String { "tag" }
    
    public static func create(tag: String? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "create", value: nil),
            PathParameter(name: "tag", value: .string(tag))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post)
    }
    
    public static func search(tag: String? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "search", value: nil),
            PathParameter(name: "tag_search", value: .string(tag)),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
