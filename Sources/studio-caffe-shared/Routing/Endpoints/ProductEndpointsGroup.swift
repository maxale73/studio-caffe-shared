import Foundation

public struct ProductDTO: Identifiable, Codable, Equatable, Hashable {
    
    public var id: UUID
    
    public var productDescription: String
    public var productCodes: String
    public var productCategory: ProductCategory
    public var iva: IvaType
    public var searchTerms: String
    public var typology: ProductTypologyDTO?
    public var packages: [PackageDTO]
    public var tags: [TagDTO]

    public init(id: UUID,
                productDescription: String,
                productCodes: String,
                productCategory: ProductCategory,
                iva: IvaType,
                searchTerms: String,
                typology: ProductTypologyDTO?,
                packages: [PackageDTO],
                tags: [TagDTO]) {
        
        self.id = id
        
        self.productDescription = productDescription
        self.productCodes = productCodes
        self.productCategory = productCategory
        self.iva = iva
        self.searchTerms = searchTerms
        self.typology = typology
        self.packages = packages
        self.tags = tags
    }
    
    public static var empty: ProductDTO {
        let productID = UUID()
        return ProductDTO(id: productID, productDescription: "nuovo prodotto", productCodes: "", productCategory: .undefined, iva: .ventidue, searchTerms: "", typology: nil, packages: [PackageDTO(id: .init(), uom: .pezzi, quantity: 1.0, product: .init(id: productID))], tags: [])
    }
}

public struct ProductID: Identifiable, Codable, Equatable, Hashable {
    
    public init(id: UUID, productDescription: String) {
        self.id = id
        self.productDescription = productDescription
    }
    
    public let id: UUID
    public let productDescription: String
}

public struct ProductPurchase: Identifiable, Codable, Equatable, Hashable {
    
    public init(id: UUID = UUID(), quantity: Double, purchasePrice: Double, documentRef: String, lotto: String, date: Date, supplierName: String, description: String) {
        self.id = id
        self.quantity = quantity
        self.purchasePrice = purchasePrice
        self.documentRef = documentRef
        self.lotto = lotto
        self.date = date
        self.supplierName = supplierName
        self.description = description
    }
    
    public let id: UUID
    public var quantity: Double
    public var purchasePrice: Double
    public var documentRef: String
    public var lotto: String
    public var date: Date
    public var supplierName: String
    public var description: String
}

public struct ProductAndPurchases: Identifiable, Codable, Equatable, Hashable, RequestBody {
    public init(productDTO: ProductDTO, purchases: [ProductPurchase]) {
        self.productDTO = productDTO
        self.purchases = purchases
    }
    
    public var id: UUID { productDTO.id }
    public var productDTO: ProductDTO
    public var purchases: [ProductPurchase]
}

extension ProductAndPurchases {
    public static var empty: ProductAndPurchases {
        ProductAndPurchases(productDTO: .empty, purchases: [])
    }
}

public struct ProductAndTypology: Identifiable, Codable, Equatable, Hashable, RequestBody {
    
    public init(id: UUID, typologyID: UUID?, productDescription: String, typologyDescription: String?) {
        self.id = id
        self.typologyID = typologyID
        self.productDescription = productDescription
        self.typologyDescription = typologyDescription
    }
    
    public var id: UUID
    public var typologyID: UUID?
    public var productDescription: String
    public var typologyDescription: String?
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
    
    public static func lightIndexWithFilter(filter: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "light_index_with_filter", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
    
    public static func indexWithTypology() -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index_with_typology", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func fetchProductsBySearchTerms(searchTerms: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "fetch_products_by_search_terms", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: searchTerms)
    }
    
    public static func save(product: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: product)
    }
    
    public static func saveWithTypology(products: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save_with_typology", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: products)
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
    
    public static func productsAndPurchasesBySupplier(supplierID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "products_and_purchases_by_supplier", value: nil),
            PathParameter(name: "id", value: .uuid(supplierID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func searchByBarcode(barcode: String? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "search_by_barcode", value: nil),
            PathParameter(name: "barcode", value: .string(barcode))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func productDTO(id: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "product_dto", value: nil),
            PathParameter(name: "id", value: .uuid(id))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}

