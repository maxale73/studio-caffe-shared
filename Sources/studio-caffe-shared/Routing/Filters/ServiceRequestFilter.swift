import Foundation

public struct ServiceRequestFilter: Codable, Equatable, RequestBody, Sendable {
    public var statuses: [ServiceRequestStatus]
    public var source: ServiceRequestSource?
    public var catalogID: UUID?
    public var page: Int
    public var per: Int

    public init(statuses: [ServiceRequestStatus] = [], source: ServiceRequestSource? = nil, catalogID: UUID? = nil,
                page: Int = 1, per: Int = 50) {
        self.statuses = statuses
        self.source = source
        self.catalogID = catalogID
        self.page = page
        self.per = per
    }

    private enum CodingKeys: String, CodingKey { case statuses, source, catalogID, page, per }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(statuses: try container.decodeIfPresent([ServiceRequestStatus].self, forKey: .statuses) ?? [],
                  source: try container.decodeIfPresent(ServiceRequestSource.self, forKey: .source),
                  catalogID: try container.decodeIfPresent(UUID.self, forKey: .catalogID),
                  page: try container.decodeIfPresent(Int.self, forKey: .page) ?? 1,
                  per: try container.decodeIfPresent(Int.self, forKey: .per) ?? 50)
    }
}
