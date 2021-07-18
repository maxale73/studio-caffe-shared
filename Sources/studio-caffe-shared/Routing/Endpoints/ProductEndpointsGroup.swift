import Foundation

public struct PackageDTO: Identifiable, Codable, Equatable, Hashable {
    public init(id: UUID, uom: Uom, barcode: String? = nil, quantity: Double, product: IDType) {
        self.id = id
        self.uom = uom
        self.barcode = barcode
        self.quantity = quantity
        self.product = product
    }
    
    public var id: UUID
    
    public var uom: Uom
    public var barcode: String?
    public var quantity: Double
    public var product: IDType
}

public struct ProductDTO: Identifiable, Codable, Equatable, Hashable {
    
    public var id: UUID
    
    public var productDescription: String
    public var productCodes: String
    public var productCategory: ProductCategory
    public var iva: IvaType
    public var packages: [PackageDTO]
    public var tags: [TagDTO]

    public init(id: UUID,
         
         productDescription: String,
         productCodes: String,
         productCategory: ProductCategory,
         iva: IvaType,
         packages: [PackageDTO],
         tags: [TagDTO]) {
        
        self.id = id
        
        self.productDescription = productDescription
        self.productCodes = productCodes
        self.productCategory = productCategory
        self.iva = iva
        self.packages = packages
        self.tags = tags
    }
}

public struct ProductPurchase: Identifiable, Codable, Equatable, Hashable {
    public init(id: UUID = UUID(), quantity: Double, purchasePrice: Double, documentRef: String, lotto: String, date: Date, supplierName: String) {
        self.id = id
        self.quantity = quantity
        self.purchasePrice = purchasePrice
        self.documentRef = documentRef
        self.lotto = lotto
        self.date = date
        self.supplierName = supplierName
    }
    public let id: UUID
    public var quantity: Double
    public var purchasePrice: Double
    public var documentRef: String
    public var lotto: String
    public var date: Date
    public var supplierName: String
}

public struct ProductAndPurchases: Identifiable, Codable, Equatable, Hashable, RequestBody {
    internal init(productDTO: ProductDTO, purchases: [ProductPurchase]) {
        self.productDTO = productDTO
        self.purchases = purchases
    }
    
    public var id: UUID { productDTO.id }
    public var productDTO: ProductDTO
    public var purchases: [ProductPurchase]
}

extension ProductDTO: RequestBody {}
extension ProductsFilter: RequestBody {}
extension ProductPurchase: RequestBody {}

public struct ProductEndpointsGroup: EndpointGroupType {
    
    public static var group = "product"
    
    public static func indexWithFilter(filter: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index_with_filter", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
    
    public static func save(product: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: product)
    }
    
    public static func fetchPurchases(id: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "fetch_purchases", value: nil),
            PathParameter(name: "id", value: .uuid(id))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func fetchProductAndPurchases(id: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "fetch_product_and_purchases", value: nil),
            PathParameter(name: "id", value: .uuid(id))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}

