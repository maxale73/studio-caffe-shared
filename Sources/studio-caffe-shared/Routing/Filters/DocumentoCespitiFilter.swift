import Foundation

public struct DocumentiCespitiFilter: Equatable, Codable, Identifiable, RequestBody {
    
    public init(supplierNameFilter: String? = nil, documentTypeFilter: DocumentoCespitiType? = nil) {
        self.id = UUID()
        self.supplierNameFilter = supplierNameFilter
        self.documentTypeFilter = documentTypeFilter
    }
    
    public var id: UUID
    public var supplierNameFilter: String?
    public var documentTypeFilter: DocumentoCespitiType?
}
