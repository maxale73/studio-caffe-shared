import Foundation

public struct BarcodeEndpointsGroup: EndpointGroupType {
    
    public static var group = "barcode"
    
    public static func search(searchTerm: String? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "search", value: nil),
            PathParameter(name: "search_term", value: .string(searchTerm))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
