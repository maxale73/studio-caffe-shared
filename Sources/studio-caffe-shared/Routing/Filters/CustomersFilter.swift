import Foundation

public struct CustomersFilter: Equatable, Codable, Identifiable, RequestBody {
    public var id: UUID
    public var textFilter: String
    
    public init(textFilter: String) {
        self.id = UUID()
        self.textFilter = textFilter
    }
    
    public var empty: Bool {
        textFilter.isEmpty
    }
    
    public static var emptyFilter: CustomersFilter {
        CustomersFilter(textFilter: "")
    }
}
