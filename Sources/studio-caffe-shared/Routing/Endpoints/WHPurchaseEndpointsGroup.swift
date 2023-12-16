import Foundation

public struct WHPurchaseDTO: Codable, Identifiable, Hashable, RequestBody {
    
    public init(id: UUID, quantity: Double, purchasePrice: Double, lotto: String, index: Int, description: String, product: ProductDTO) {
        self.id = id
        self.quantity = quantity
        self.purchasePrice = purchasePrice
        self.lotto = lotto
        self.index = index
        self.description = description
        self.product = product
    }
    
    
    public var id: UUID
    public var quantity: Double
    public var purchasePrice: Double
    public var lotto: String
    public var index: Int
    public var description: String
    public var product: ProductDTO
}

public struct PurchaseHistoryItem: Identifiable, Codable, Hashable {
    
    public init(id: UUID, productID: UUID, productTypologyID: UUID? = nil, productCategory: ProductCategory, iva: IvaType, quantity: Double, price: Double, date: Date) {
        self.id = id
        self.productID = productID
        self.productTypologyID = productTypologyID
        self.productCategory = productCategory
        self.iva = iva
        self.quantity = quantity
        self.price = price
        self.date = date
    }
    
    public var id: UUID
    
    public var productID: UUID
    public var productTypologyID: UUID?
    public var productCategory: ProductCategory
    public var iva: IvaType
    
    public var quantity: Double
    public var price: Double
    public var date: Date
}

public struct WHPurchaseEndpointsGroup: EndpointGroupType {
    
    public static var group = "wh_purchase"
    
    public static func deletePurchase(purchaseID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "delete_purchase", value: nil),
            PathParameter(name: "purchase_ID", value: .uuid(purchaseID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func updatePurchase(purchase: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "update_purchase", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: purchase)
    }
    
    public static func fetchHistory() -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "fetch_history", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
