import Foundation

public struct DocumentoCespiteDTO: Codable, Identifiable, Hashable {
    public var id: UUID
    public var documentType: DocumentoCespitiType
    public var documentRef: String
    public var supplierName: String
}

public struct DocumentoCespitiEndpointGroup: EndpointGroupType {
    
    public static var group = "documento_cespiti"
    
    public static func indexWithFilter(filter: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index_with_filter", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
}
