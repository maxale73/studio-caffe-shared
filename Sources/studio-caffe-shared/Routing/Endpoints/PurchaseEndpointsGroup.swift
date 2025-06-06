import Foundation

public struct PurchaseEndpointsGroup: EndpointGroupType {
    
    public static var group: String { "purchase" }
    
    public static func createDocument(document: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "create_document", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: document)
    }
    
    public static func fetchProductsFromDocument(document: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "fetch_products_from_document", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: document)
    }
    
    public static func fetchDocumentsWithFilter(filter: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "fetch_documents_with_filter", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
    
    public static func lastPurchase(supplierID: UUID? = nil, productID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "last_purchase", value: nil),
            PathParameter(name: "supplier_ID", value: .uuid(supplierID)),
            PathParameter(name: "product_ID", value: .uuid(productID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
