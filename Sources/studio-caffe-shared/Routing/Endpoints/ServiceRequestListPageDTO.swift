import Foundation

public struct ServiceRequestListPageDTO: Codable, Equatable, Sendable {
    public var items: [ServiceRequestListItemDTO]
    public var page: Int
    public var per: Int
    public var total: Int

    public init(items: [ServiceRequestListItemDTO], page: Int, per: Int, total: Int) {
        self.items = items
        self.page = page
        self.per = per
        self.total = total
    }
}
