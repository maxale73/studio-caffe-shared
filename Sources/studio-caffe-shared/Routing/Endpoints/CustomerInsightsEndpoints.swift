import Foundation

public struct CustomerInsightsRequest: Identifiable, Codable, Equatable, Sendable, RequestBody {
    public init(id: UUID = .init(), requestDescription: String = "", intervals: [CustomTimeInterval]) {
        self.id = id
        self.requestDescription = requestDescription
        self.intervals = intervals
    }

    public var id: UUID
    public var requestDescription: String
    public var intervals: [CustomTimeInterval]
}

public struct CustomerInsightPeriod: Identifiable, Codable, Equatable, Sendable {
    public init(
        id: UUID = .init(),
        interval: CustomTimeInterval,
        periodDescription: String,
        venduto: Double,
        erogazioni: Int,
        reportsCount: Int
    ) {
        self.id = id
        self.interval = interval
        self.periodDescription = periodDescription
        self.venduto = venduto
        self.erogazioni = erogazioni
        self.reportsCount = reportsCount
    }

    public var id: UUID
    public var interval: CustomTimeInterval
    public var periodDescription: String
    public var venduto: Double
    public var erogazioni: Int
    public var reportsCount: Int
}

public struct CustomerInsightsResponse: Identifiable, Codable, Equatable, Sendable {
    public init(id: UUID = .init(), customerID: UUID, responseDescription: String, periods: [CustomerInsightPeriod]) {
        self.id = id
        self.customerID = customerID
        self.responseDescription = responseDescription
        self.periods = periods
    }

    public var id: UUID
    public var customerID: UUID
    public var responseDescription: String
    public var periods: [CustomerInsightPeriod]
}

public extension CustomerEndpointsGroup {
    static func fetchInsights(customerID: UUID? = nil, request: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "fetch_insights", value: nil),
            PathParameter(name: "customer_id", value: .uuid(customerID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: request)
    }
}
