import Foundation

public struct ProductDTO: Identifiable, Codable, Equatable, Hashable {
    
    public var id: UUID
    
    public var productDescription: String
    public var productCodes: String
    public var productCategory: ProductCategory
    public var uom: Uom
    public var iva: IvaType
    public var tags: [TagDTO]

    public init(id: UUID,
         
         productDescription: String,
         productCodes: String,
         productCategory: ProductCategory,
         uom: Uom,
         iva: IvaType,
         tags: [TagDTO]) {
        
        self.id = id
        
        self.productDescription = productDescription
        self.productCodes = productCodes
        self.productCategory = productCategory
        self.uom = uom
        self.iva = iva
        self.tags = tags
    }
}

extension ProductDTO: Body {}
extension ProductsFilter: Body {}

public struct ProductEndpointsGroup {
    
    public static let group = "product"
    
    public static func indexWithFilter(filter: Body? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index_with_filter", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
    
    public static func save(product: Body? = nil) -> EndpointConfiguration {
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
        return EndpointConfiguration(pathConstructor: constructor, method: .post)
    }
}

