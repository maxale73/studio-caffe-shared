import Foundation

public struct ASLCommunicationsFilter: Equatable, Codable, Identifiable, RequestBody {
    
    public init(customerFilter: UUID? = nil, cityFilter: String? = nil, addressFilter: UUID? = nil, sellingPointFilter: UUID? = nil) {
        self.id = UUID()
        self.customerFilter = customerFilter
        self.cityFilter = cityFilter
        self.addressFilter = addressFilter
        self.sellingPointFilter = sellingPointFilter
    }
    
    public var id: UUID
    public var customerFilter: UUID?
    public var cityFilter: String?
    public var addressFilter: UUID?
    public var sellingPointFilter: UUID?
    
    public static var emptyFilter: ASLCommunicationsFilter {
        ASLCommunicationsFilter(customerFilter: nil, cityFilter: nil, addressFilter: nil, sellingPointFilter: nil)
    }
}
