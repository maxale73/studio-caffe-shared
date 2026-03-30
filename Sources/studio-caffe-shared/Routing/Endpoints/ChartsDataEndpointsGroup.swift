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

public struct ChartYearlyTallyCashboxRequest: Identifiable, Codable, Equatable, Sendable, RequestBody {
    public init(
        id: UUID = .init(),
        requestDescription: String = "",
        startYear: Int = 2020,
        endYear: Int? = nil
    ) {
        self.id = id
        self.requestDescription = requestDescription
        self.startYear = startYear
        self.endYear = endYear
    }

    public var id: UUID
    public var requestDescription: String
    public var startYear: Int
    public var endYear: Int?
}

public struct ChartYearlyTallyCashboxPoint: Identifiable, Codable, Equatable, Sendable {
    public init(
        id: UUID = .init(),
        year: Int,
        tallySum: Double,
        cashboxSum: Double,
        difference: Double,
        auditsCount: Int,
        talliesCount: Int
    ) {
        self.id = id
        self.year = year
        self.tallySum = tallySum
        self.cashboxSum = cashboxSum
        self.difference = difference
        self.auditsCount = auditsCount
        self.talliesCount = talliesCount
    }

    public var id: UUID
    public var year: Int
    public var tallySum: Double
    public var cashboxSum: Double
    public var difference: Double
    public var auditsCount: Int
    public var talliesCount: Int
}

public struct ChartYearlyTallyCashboxResponse: Identifiable, Codable, Equatable, Sendable {
    public init(
        id: UUID = .init(),
        responseDescription: String,
        points: [ChartYearlyTallyCashboxPoint]
    ) {
        self.id = id
        self.responseDescription = responseDescription
        self.points = points
    }

    public var id: UUID
    public var responseDescription: String
    public var points: [ChartYearlyTallyCashboxPoint]
}

public struct ChartYearlyRistornoVendutoRatioRequest: Identifiable, Codable, Equatable, Sendable, RequestBody {
    public init(
        id: UUID = .init(),
        requestDescription: String = "",
        startYear: Int = 2020,
        endYear: Int? = nil
    ) {
        self.id = id
        self.requestDescription = requestDescription
        self.startYear = startYear
        self.endYear = endYear
    }

    public var id: UUID
    public var requestDescription: String
    public var startYear: Int
    public var endYear: Int?
}

public struct ChartYearlyRistornoVendutoRatioPoint: Identifiable, Codable, Equatable, Sendable {
    public init(
        id: UUID = .init(),
        year: Int,
        vendutoTotal: Double,
        ristornoDueTotal: Double,
        erogazioniTotal: Int,
        customersCount: Int,
        ratioPercent: Double
    ) {
        self.id = id
        self.year = year
        self.vendutoTotal = vendutoTotal
        self.ristornoDueTotal = ristornoDueTotal
        self.erogazioniTotal = erogazioniTotal
        self.customersCount = customersCount
        self.ratioPercent = ratioPercent
    }

    public var id: UUID
    public var year: Int
    public var vendutoTotal: Double
    public var ristornoDueTotal: Double
    public var erogazioniTotal: Int
    public var customersCount: Int
    public var ratioPercent: Double
}

public struct ChartYearlyRistornoVendutoRatioResponse: Identifiable, Codable, Equatable, Sendable {
    public init(
        id: UUID = .init(),
        responseDescription: String,
        points: [ChartYearlyRistornoVendutoRatioPoint]
    ) {
        self.id = id
        self.responseDescription = responseDescription
        self.points = points
    }

    public var id: UUID
    public var responseDescription: String
    public var points: [ChartYearlyRistornoVendutoRatioPoint]
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

    public static func fetchChartYearlyTallyCashboxData(dataRequest: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [PathParameter(name: "fetch_chart_yearly_tally_cashbox_data", value: nil)]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: dataRequest)
    }

    public static func fetchChartYearlyRistornoVendutoRatioData(dataRequest: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [PathParameter(name: "fetch_chart_yearly_ristorno_venduto_ratio_data", value: nil)]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: dataRequest)
    }
}
