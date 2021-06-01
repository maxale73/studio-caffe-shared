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
    public init(customer: String, sellingPoint: Int, site: String, machineID: Int, machineModel: String, machineType: String, reports: [EvaReportDTO]) {
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
    public var reports: [EvaReportDTO]
}

public struct ReportsByCustomer: Codable, Identifiable, Equatable {
    
    public init(id: UUID, customerName: String, reports: [EvaReportDTO]) {
        self.id = id
        self.customerName = customerName
        self.reports = reports
    }
    
    public var id: UUID
    public var customerName: String
    public var reports: [EvaReportDTO]
}

public struct ReportByRistorno: Codable, Identifiable, Equatable {
    
    public init(id: UUID, erogazioni: Int, machineID: Int, machineModel: String, site: String, readingDate: Date) {
        self.id = id
        self.erogazioni = erogazioni
        self.machineID = machineID
        self.machineModel = machineModel
        self.site = site
        self.readingDate = readingDate
    }
    
    public var id: UUID
    public var erogazioni: Int
    public var machineID: Int
    public var machineModel: String
    public var site: String
    public var readingDate: Date
}

public struct ReportByMachine: Identifiable, Equatable, Codable {
    public init(customer: String, sellingPoint: Int, site: String, deviceID: String, deviceModel: String, date: Date) {
        self.customer = customer
        self.sellingPoint = sellingPoint
        self.site = site
        self.deviceID = deviceID
        self.deviceModel = deviceModel
        self.date = date
    }
    
    public var id: UUID { UUID() }
    public var customer: String
    public var sellingPoint: Int
    public var site: String
    public var deviceID: String
    public var deviceModel: String
    public var date: Date
}

public struct ToCheckAuditDTO: Codable, Identifiable, RequestBody {
    public init(id: UUID, deviceId: String, progressivoLettura: Int, dataLettura: Date, dataLetturaPrecedente: Date) {
        self.id = id
        self.deviceId = deviceId
        self.progressivoLettura = progressivoLettura
        self.dataLettura = dataLettura
        self.dataLetturaPrecedente = dataLetturaPrecedente
    }
    
    public let id: UUID
    public let deviceId: String
    public let progressivoLettura: Int
    public let dataLettura: Date
    public let dataLetturaPrecedente: Date
}

public enum AuditImportFailureReason: String, RawRepresentable, Codable {
    case exists = "esistente"
    case noDevice = "nessun dispositivo"
    case noSellingPoint = "non installato"
    case noPrevious = "nessuna rilevazione precedente"
    case success = ""
}

public struct AuditCheckResult: Codable, Identifiable, Equatable, Hashable {
    public let id: UUID
    public let previousRawReport: String
    public let success: Bool
    public let message: String
    
    public init(report: ToCheckAuditDTO, previuosRawReport: String, success: Bool, message: AuditImportFailureReason) {
        self.id = report.id
        self.previousRawReport = previuosRawReport
        self.success = success
        self.message = message.rawValue
    }
}

public struct ParsedAuditToSave: Codable, RequestBody {
    public var id: UUID
    public var deviceId: String
    public var progressivoLettura: Int
    public var dataLettura: Date
    public var dataLetturaPrecedente: Date
    public var rawReport: String
    
    public var erogazioni: Int
    public var venduto: Double
    
    public static func createFrom(report: ParsedAudit, id: UUID) -> ParsedAuditToSave? {
        guard let values = report.modelValues() else {
            return nil
        }
        
        return ParsedAuditToSave(id: id,deviceId: values.deviceId, progressivoLettura: values.progressivoLettura, dataLettura: values.dataLettura, dataLetturaPrecedente: values.dataLetturaPrecedente, rawReport: values.rawReport, erogazioni: values.erogazioni, venduto: values.venduto)
    }
}

public struct CorrispettiviPerData: Codable, Equatable {
    public init(date: Date, values: EvaAdeValues) {
        self.date = date
        self.values = values
    }
    
    public var date: Date
    public var values: EvaAdeValues
    
    public static func == (lhs: CorrispettiviPerData, rhs: CorrispettiviPerData) -> Bool {
        return lhs.date == rhs.date &&
            lhs.values == rhs.values
    }
}


public struct AuditEndpointsGroup: EndpointGroupType {
    
    public static var group = "evaReport"
    
    public static func index(filter: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [ PathParameter(name: "index", value: nil) ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
    
    public static func checkBeforeImport(auditsToCheck: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [ PathParameter(name: "check_before_import", value: nil) ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: auditsToCheck)
    }
    
    public static func create(auditsToCreate: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [ PathParameter(name: "create", value: nil) ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: auditsToCreate)
    }
    
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
    
    public static func reportsByCustomer(from: Date? = nil, to: Date? = nil) -> EndpointConfiguration {
        let parameters = [ PathParameter(name: "reports_by_customer", value: nil),
                           PathParameter(name: "from", value: .date(from)),
                           PathParameter(name: "to", value: .date(to))]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func reportsByRistorno(customerID: UUID? = nil, from: Date? = nil, to: Date? = nil) -> EndpointConfiguration {
        let parameters = [ PathParameter(name: "reports_by_ristorno", value: nil),
                           PathParameter(name: "customer_id", value: .uuid(customerID)),
                           PathParameter(name: "from", value: .date(from)),
                           PathParameter(name: "to", value: .date(to))]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func reportsByMachine(machineID: Int? = nil, from: Date? = nil, to: Date? = nil) -> EndpointConfiguration {
        let parameters = [ PathParameter(name: "reports_by_machine", value: nil),
                           PathParameter(name: "machine_id", value: .int(machineID)),
                           PathParameter(name: "from", value: .date(from)),
                           PathParameter(name: "to", value: .date(to))]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func corrispettivi(filter: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [ PathParameter(name: "corrispettivi", value: nil) ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
}
