import Foundation

struct GlobalSearchResult: Codable, Hashable, Identifiable, Sendable {
    var id: UUID
    var customers: [CustomerName]
    var machines: [MachineDTO]
    var devices: [AdeDeviceDTO]
    var products: [ProductDTO]
}

public struct SearchEndpointsGroup: EndpointGroupType {
    
    public static var group: String { "search" }
    
    public static func globalSearch(searchTerm: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "global", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: searchTerm)
    }
    
    public static func barcodeSearch(searchTerm: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "barcode", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: searchTerm)
    }
}
