import Foundation

public struct BrewDTO: Codable, Equatable, Hashable, Identifiable {
    
    public var id: UUID
    
    public var index: Int
    public var brewDescription: String

    public init(id: UUID,
         
         index: Int,
         brewDescription: String) {
        
        self.id = id
        
        self.index = index
        self.brewDescription = brewDescription
    }
}

public struct BrewEndpointsGroup: EndpointGroupType {
    
    public static var group: String { "brew" }
    
    public static func index() -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
