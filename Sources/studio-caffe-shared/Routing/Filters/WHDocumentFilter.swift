import Foundation

public struct WHDocumentFilter: Equatable, Codable, Identifiable, RequestBody {
    
    public init(supplierNameFilter: String? = nil, closedFilter: Bool? = nil) {
        self.id = UUID()
        self.supplierNameFilter = supplierNameFilter
        self.closedFilter = closedFilter
    }
    
    public var id: UUID
    public var supplierNameFilter: String?
    public var closedFilter: Bool?
}
