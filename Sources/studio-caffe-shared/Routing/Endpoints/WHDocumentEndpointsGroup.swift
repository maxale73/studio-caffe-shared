import Foundation

public struct WHDocumentDTO: Codable, Identifiable, Hashable, RequestBody, Sendable {
    
    public init(id: UUID, documentRef: String, date: Date, closed: Bool, supplierName: String) {
        self.id = id
        self.documentRef = documentRef
        self.date = date
        self.closed = closed
        self.supplierName = supplierName
    }
    
    public var id: UUID
    public var documentRef: String
    public var date: Date
    public var closed: Bool
    public var supplierName: String
}

public struct WHDocumentComplete: Codable, Identifiable, Hashable, RequestBody, Sendable {
    
    public init(document: WHDocumentDTO, purchases: [WHPurchaseDTO]) {
        self.document = document
        self.purchases = purchases
    }
    
    public var id: UUID { document.id }
    public var document: WHDocumentDTO
    public var purchases: [WHPurchaseDTO]
}

public struct WHPurchaseToSave: Codable, Identifiable, Hashable, Sendable {
    
    public init(id: UUID, quantity: Double, purchasePrice: Double, lotto: String, index: Int, description: String, product: IDType) {
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
    public var product: IDType
}

public struct WHDocumentToSave: Codable, Identifiable, Hashable, RequestBody, Sendable {
    
    public init(document: WHDocumentDTO, purchases: [WHPurchaseToSave]) {
        self.document = document
        self.purchases = purchases
    }
    
    public var id: UUID { document.id }
    public var document: WHDocumentDTO
    public var purchases: [WHPurchaseToSave]
}

public struct WHDocumentEndpointsGroup: EndpointGroupType {
    
    public static var group: String { "wh_document" }
    
    public static func saveNewEmptyDocument(document: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save_new_empty_document", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: document)
    }
    
    public static func checkDocumentUniqueness(document: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "check_document_uniqueness", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: document)
    }
    
    public static func indexWithFilter(filter: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index_with_filter", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
    
    public static func fetchCompleteDocument(documentID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "fetch_complete_document", value: nil),
            PathParameter(name: "document_id", value: .uuid(documentID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func fetchCompleteDocumentsWithFilter(filter: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "fetch_complete_document_with_filter", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
    
    public static func purchasesByDocument(documentID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "purchases_by_document", value: nil),
            PathParameter(name: "document_id", value: .uuid(documentID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func saveDocumentWithPurchases(document: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save_document_with_purchases", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: document)
    }
    
    public static func AddPurchaseToDocument(document: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "add_purchase_to_document", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: document)
    }
    
    public static func markDocumentAsClosed(documentID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "mark_document_as_closed", value: nil),
            PathParameter(name: "document_id", value: .uuid(documentID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func deleteDocument(documentID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "delete_document", value: nil),
            PathParameter(name: "document_id", value: .uuid(documentID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}


