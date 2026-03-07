import Foundation

public extension ProductCategory {
    static let goodsToSell: [ProductCategory] = [
        .C_73_01_551,
        .C_73_01_552,
        .C_73_01_553,
        .C_73_01_554,
        .C_73_01_561,
        .C_73_01_562,
        .C_73_01_563,
        .C_73_01_564
    ]
}

public struct ChartPurchaseDataRequest: Identifiable, Codable, Equatable, Sendable, RequestBody {
    public init(id: UUID = .init(), requestDescription: String, purchaseFilters: [PurchaseHistoryFilter], intervals: [CustomTimeInterval]) {
        self.id = id
        self.requestDescription = requestDescription
        self.purchaseFilters = purchaseFilters
        self.intervals = intervals
    }

    public var id: UUID
    public var requestDescription: String
    public var purchaseFilters: [PurchaseHistoryFilter]
    public var intervals: [CustomTimeInterval]
}

public struct ChartCategoryIncomeCorrelationRequest: Identifiable, Codable, Equatable, Sendable, RequestBody {
    public init(id: UUID = .init(), requestDescription: String = "", intervals: [CustomTimeInterval]) {
        self.id = id
        self.requestDescription = requestDescription
        self.intervals = intervals
    }

    public var id: UUID
    public var requestDescription: String
    public var intervals: [CustomTimeInterval]
}

public struct ChartPurchasePeriod: Identifiable, Codable, Equatable, Sendable {
    public init(id: UUID = .init(), interval: CustomTimeInterval, periodDescription: String, purchaseValue: Double, purchaseAmount: Double, sellValue: Double = 0.0, sellAmount: Int = 0) {
        self.id = id
        self.interval = interval
        self.periodDescription = periodDescription
        self.purchaseValue = purchaseValue
        self.purchaseAmount = purchaseAmount
        self.sellValue = sellValue
        self.sellAmount = sellAmount
    }

    public var id: UUID
    public var interval: CustomTimeInterval
    public var periodDescription: String
    public var purchaseValue: Double
    public var purchaseAmount: Double

    public var sellValue: Double
    public var sellAmount: Int
}

public struct ChartPurchaseDataResponse: Identifiable, Codable, Equatable, Sendable {
    public init(id: UUID, responseDescription: String, periods: [ChartPurchasePeriod]) {
        self.id = id
        self.responseDescription = responseDescription
        self.periods = periods
    }

    public var id: UUID
    public var responseDescription: String
    public var periods: [ChartPurchasePeriod]
}

public struct ChartDataEndpointsGroup: EndpointGroupType {
    public static var group: String { "chartData" }

    public static func fetchChartPurchaseData(dataRequest: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [PathParameter(name: "fetch_chart_purchase_data", value: nil)]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: dataRequest)
    }

    public static func fetchChartPurchaseSellRatioData(dataRequest: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [PathParameter(name: "fetch_chart_purchase_sell_ratio_data", value: nil)]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: dataRequest)
    }

    public static func fetchChartCategoryIncomeCorrelationData(dataRequest: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [PathParameter(name: "fetch_chart_category_income_correlation_data", value: nil)]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: dataRequest)
    }
}
