import Foundation

public struct CapElementEndpointsGroup: EndpointGroupType {
    
    public static var group: String { "capElement" }
    
    public static func index() -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
