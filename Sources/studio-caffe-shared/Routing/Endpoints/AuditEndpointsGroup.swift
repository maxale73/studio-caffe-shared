import Foundation

public struct ReportAroundDate:Codable, Equatable, Identifiable {
    
    public init(adeID: String, machineID: Int? = nil, previousDate: Date? = nil, nextDate: Date? = nil, rawReport: String? = nil, customer: String, site: String, note: String) {
        self.adeID = adeID
        self.machineID = machineID
        self.previousDate = previousDate
        self.nextDate = nextDate
        self.rawReport = rawReport
        self.customer = customer
        self.site = site
        self.note = note
    }
    
    
    public var id: String { adeID }
    public var adeID: String
    public var machineID: Int?
    public var previousDate: Date?
    public var nextDate: Date?
    public var rawReport: String?
    public var customer: String
    public var site: String
    public var note: String
}

public struct ReportsBySellingPoint: Identifiable, Equatable, Codable {
    public init(customer: String, sellingPoint: Int, site: String, machineID: Int, machineModel: String, machineType: String, reports: [EvaAuditDTO]) {
        self.customer = customer
        self.sellingPoint = sellingPoint
        self.site = site
        self.machineID = machineID
        self.machineModel = machineModel
        self.machineType = machineType
        self.reports = reports
    }
    
    public var id: Int {
        return sellingPoint
    }
    public var customer: String
    public var sellingPoint: Int
    public var site: String
    public var machineID: Int
    public var machineModel: String
    public var machineType: String
    public var reports: [EvaAuditDTO]
}

public struct AuditEndpointsGroup: EndpointGroupType {
    
    public static var group = "evaReport"
    
    public static func reportsAroundDate(date: Date? = nil) -> EndpointConfiguration {
        let parameters = [ PathParameter(name: "reports_around_date", value: nil),
                           PathParameter(name: "date", value: .date(date))]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func reportsBySellingPoint(from: Date? = nil, to: Date? = nil) -> EndpointConfiguration {
        let parameters = [ PathParameter(name: "reports_by_selling_point", value: nil),
                           PathParameter(name: "from", value: .date(from)),
                           PathParameter(name: "to", value: .date(to))]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func reportsByDevice(deviceID: String? = nil, from: Date? = nil, to: Date? = nil) -> EndpointConfiguration {
        let parameters = [ PathParameter(name: "reports_by_device", value: nil),
                           PathParameter(name: "device_id", value: .string(deviceID)),
                           PathParameter(name: "from", value: .date(from)),
                           PathParameter(name: "to", value: .date(to))]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
