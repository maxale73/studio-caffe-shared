import Foundation

public struct ServiceHistoryFilter: Codable, Equatable, RequestBody, Sendable {
    public init(page: Int = 1, per: Int = 50, catalogID: UUID? = nil, operationType: ServiceOperationType? = nil,
                requestID: UUID? = nil) {
        self.page = page
        self.per = per
        self.catalogID = catalogID
        self.operationType = operationType
        self.requestID = requestID
    }

    public var page: Int
    public var per: Int
    public var catalogID: UUID?
    public var operationType: ServiceOperationType?
    public var requestID: UUID?
}
