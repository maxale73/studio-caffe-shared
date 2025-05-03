//
//  File.swift
//  
//
//  Created by Massimo Di Leonardo on 26/05/21.
//

import Foundation

public struct EvaAuditFilter: Codable, RequestBody, Equatable, Sendable {
    public init(id: UUID = UUID(), customerID: UUID? = nil, sellingPointID: UUID? = nil, deviceID: String? = nil, machineID: Int? = nil, deviceModel: AdeDeviceModel, fromDate: Date, toDate: Date) {
        self.id = id
        self.customerID = customerID
        self.sellingPointID = sellingPointID
        self.deviceID = deviceID
        self.machineID = machineID
        self.deviceModel = deviceModel
        self.fromDate = fromDate
        self.toDate = toDate
    }
    
    public var id: UUID
    public var customerID: UUID?
    public var sellingPointID: UUID?
    public var deviceID: String?
    public var machineID: Int?
    public var deviceModel: AdeDeviceModel
    public var fromDate: Date
    public var toDate: Date
    
    public static var defaultFilter: EvaAuditFilter {
        EvaAuditFilter(id: defaultFilterID, deviceModel: .none, fromDate: Date.defaultStartDate, toDate: .init())
    }
    
    public static var nullFilter: EvaAuditFilter {
        EvaAuditFilter(id: defaultFilterID, deviceModel: .none, fromDate: .legalDistantPast, toDate: .distantFuture)
    }
    
    public static func == (lhs: EvaAuditFilter, rhs: EvaAuditFilter) -> Bool {
        return lhs.id == rhs.id &&
            lhs.customerID == rhs.customerID &&
            lhs.sellingPointID == rhs.sellingPointID &&
            lhs.deviceID == rhs.deviceID &&
            lhs.machineID == rhs.machineID &&
            lhs.deviceModel == rhs.deviceModel &&
            lhs.fromDate == rhs.fromDate &&
            lhs.toDate == rhs.toDate
    }
}
