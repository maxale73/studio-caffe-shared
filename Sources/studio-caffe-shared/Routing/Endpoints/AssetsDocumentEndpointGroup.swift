import Foundation

public struct AssetsDocumentDTO: Codable, Identifiable, Hashable, RequestBody {
    
    public init(id: UUID, documentType: AssetsDocumentType, documentRef: String, date: Date, supplierName: String) {
        self.id = id
        self.documentType = documentType
        self.documentRef = documentRef
        self.date = date
        self.supplierName = supplierName
    }
    
    public var id: UUID
    public var documentType: AssetsDocumentType
    public var documentRef: String
    public var date: Date
    public var supplierName: String
}

public struct AssetDTO: Codable, Identifiable, Hashable {
    public init(id: UUID, buyPrice: Double, sellPrice: Double? = nil, machine: FilteredMachineDTO) {
        self.id = id
        self.buyPrice = buyPrice
        self.sellPrice = sellPrice
        self.machine = machine
    }
    
    public var id: UUID
    public var buyPrice: Double
    public var sellPrice: Double?
    public var machine: FilteredMachineDTO
}

public struct AssetsDocumentWithAssets: Codable, Identifiable, Hashable, RequestBody {
    
    public init(id: UUID, documentType: AssetsDocumentType, documentRef: String, date: Date, supplierName: String, assets: [AssetDTO]) {
        self.id = id
        self.documentType = documentType
        self.documentRef = documentRef
        self.date = date
        self.supplierName = supplierName
        self.assets = assets
    }
    
    
    public var id: UUID
    public var documentType: AssetsDocumentType
    public var documentRef: String
    public var date: Date
    public var supplierName: String
    public var assets: [AssetDTO]
}

public struct AssetsDocumentEndpointGroup: EndpointGroupType {
    
    public static var group = "assets_document"
    
    public static func saveNewEmptyDocument(document: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save_new_empty_document", value: nil)
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
    
    public static func assetsByDocument(documentID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "assets_by_document", value: nil),
            PathParameter(name: "document_id", value: .uuid(documentID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func fetchFreeAssests(documentType: String? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "fetch_free_asets", value: nil),
            PathParameter(name: "type", value: .string(documentType))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func addAssetsToDocument(document: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "add_assets_to_document", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: document)
    }
    
    public static func removeAssetsFromDocument(document: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "remove_assets_from_document", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: document)
    }
}
//
