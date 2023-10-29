import Foundation

public struct ProductTypologyFilter: Equatable, Codable, Identifiable {
    public var id: UUID
    public var textFilter: String
    
    public init(textFilter: String) {
        self.id = UUID()
        self.textFilter = textFilter
    }
    
    public var empty: Bool {
        textFilter.isEmpty
    }
    
    public static var emptyFilter: ProductTypologyFilter {
        ProductTypologyFilter(textFilter: "")
    }
}
