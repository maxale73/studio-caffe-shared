import Foundation

public struct WHDocumentFilter: Equatable, Codable, Identifiable, RequestBody, Sendable {
    
    public init(supplierID: String? = nil, from: Date? = nil, to: Date? = nil, closed: Bool? = nil) {
        self.id = UUID()
        self.supplierID = supplierID
        self.fromDate = from
        self.toDate = to
        self.closed = closed
    }
    
    public var id: UUID
    public var supplierID: String?
    public var fromDate: Date?
    public var toDate: Date?
    public var closed: Bool?
    
    public var empty: Bool {
        supplierID == nil && closed == nil && fromDate == nil && toDate == nil
    }
    
    public static var emptyFilter: WHDocumentFilter {
        WHDocumentFilter()
    }
}
