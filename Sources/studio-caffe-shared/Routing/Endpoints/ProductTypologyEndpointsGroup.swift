import Foundation

public struct ProductTypologyDTO: Identifiable, Codable, Equatable, Hashable, Sendable {
    
    public init(id: UUID, typologyDescription: String) {
        self.id = id
        self.typologyDescription = typologyDescription
    }
    
    public var id: UUID
    public var typologyDescription: String
    
}

public struct InventoryPurchaseDTO: Identifiable, Codable, Equatable, Hashable, Sendable {
    
    public init(id: UUID, amount: Double, price: Double, date: Date) {
        self.id = id
        self.amount = amount
        self.price = price
        self.date = date
    }
    
    public var id: UUID
    public var amount: Double
    public var price: Double
    public var date: Date
}

public struct InventoryProductDTO: Identifiable, Codable, Equatable, Hashable, Sendable {
    
    public init(id: UUID, description: String, iva: IvaType, purchases: [InventoryPurchaseDTO], packages: [PackageDTO]) {
        self.id = id
        self.description = description
        self.iva = iva
        self.purchases = purchases
        self.packages = packages
    }
    
    public var id: UUID
    public var description: String
    public var iva: IvaType
    public var purchases: [InventoryPurchaseDTO]
    public var packages: [PackageDTO]
}

extension ProductTypologyDTO: RequestBody {}

public struct ProductTypologyEndpointsGroup: EndpointGroupType {
    
    public static var group: String { "productTypology" }
    
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
    
    public static func productsByTypology(typologyID: UUID? = nil, date: Date? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "products_by_typology", value: nil),
            PathParameter(name: "typology_id", value: .uuid(typologyID)),
            PathParameter(name: "date", value: .date(date))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
}
