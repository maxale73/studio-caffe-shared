import Foundation

public struct AssetsDocumentFilter: Equatable, Codable, Identifiable, RequestBody, Sendable {
    
    public init(supplierNameFilter: String? = nil, documentTypeFilter: AssetsDocumentType? = nil, fromDate: Date? = nil, toDate: Date? = nil) {
        self.id = UUID()
        self.supplierNameFilter = supplierNameFilter
        self.documentTypeFilter = documentTypeFilter
        self.fromDate = fromDate
        self.toDate = toDate
    }
    
    public var id: UUID
    public var supplierNameFilter: String?
    public var documentTypeFilter: AssetsDocumentType?
    public var fromDate: Date?
    public var toDate: Date?
    
    public var empty: Bool {
        supplierNameFilter == nil && documentTypeFilter == nil && fromDate == nil && toDate == nil
    }
    
    public static var emptyFilter: AssetsDocumentFilter {
        AssetsDocumentFilter()
    }
}
