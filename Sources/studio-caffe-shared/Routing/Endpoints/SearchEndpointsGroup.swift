import Foundation

public struct GlobalSearchResult: Codable, Hashable, Identifiable, Sendable {
    
    public init(customers: [CustomerName], machines: [MachineDTO], devices: [AdeDeviceDTO], products: [ProductDTO]) {
        
        self.id = .init()
        self.customers = customers
        self.machines = machines
        self.devices = devices
        self.products = products
    }
    
    
    public var id: UUID
    public var customers: [CustomerName]
    public var machines: [MachineDTO]
    public var devices: [AdeDeviceDTO]
    public var products: [ProductDTO]
}

public struct BarcodeSearchResult: Codable, Hashable, Identifiable, Sendable {
    
    public init(customers: [CustomerName], machines: [MachineDTO], devices: [AdeDeviceDTO], products: [ProductDTO]) {
        
        self.id = .init()
        self.customers = customers
        self.machines = machines
        self.devices = devices
        self.products = products
    }
    
    public var id: UUID
    public var customers: [CustomerName]
    public var machines: [MachineDTO]
    public var devices: [AdeDeviceDTO]
    public var products: [ProductDTO]
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
