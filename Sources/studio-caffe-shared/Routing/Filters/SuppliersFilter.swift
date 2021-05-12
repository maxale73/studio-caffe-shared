import Foundation

public struct SuppliersFilter: Equatable, Codable, Identifiable {
    public var id: UUID
    public var textFilter: String
    
    public var empty: Bool {
        textFilter.isEmpty
    }
    
    public static var emptyFilter: SuppliersFilter {
        SuppliersFilter(id: UUID(), textFilter: "")
    }
}
