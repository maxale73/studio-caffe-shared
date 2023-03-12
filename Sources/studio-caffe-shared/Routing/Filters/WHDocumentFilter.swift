import Foundation

public struct WHDocumentFilter: Equatable, Codable, Identifiable, RequestBody {
    
    internal init(supplierID: String? = nil, from: Date, to: Date, closed: Bool? = nil) {
        self.id = UUID()
        self.supplierID = supplierID
        self.from = from
        self.to = to
        self.closed = closed
    }
    
    public var id: UUID
    public var supplierID: String?
    public var from: Date
    public var to: Date
    public var closed: Bool?
    
    public var empty: Bool {
        supplierID == nil && closed == nil
    }
    
    public static var emptyFilter: WHDocumentFilter {
        WHDocumentFilter(from: .defaultStartDate, to: Date())
    }
}
