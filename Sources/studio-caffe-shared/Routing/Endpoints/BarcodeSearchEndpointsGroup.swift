import Foundation

public struct BarcodeEndpointsGroup: EndpointGroupType {
    
    public static var group: String { "barcode" }
    
    public static func search(searchTerm: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "search", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: searchTerm)
    }
}
