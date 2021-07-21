import Foundation

public struct RawAuditInfo: Identifiable, Codable, Equatable {
    
    public init(id: UUID, rawAudit: String, machineID: Int, machineModel: MachineModelDTO, deviceModel: AdeDeviceModel, sellingPointID: Int, customer: String) {
        self.id = id
        self.rawAudit = rawAudit
        self.machineID = machineID
        self.machineModel = machineModel
        self.deviceModel = deviceModel
        self.sellingPointID = sellingPointID
        self.customer = customer
    }
    
    public var id: UUID
    public var rawAudit: String
    public var machineID: Int
    public var machineModel: MachineModelDTO
    public var deviceModel: AdeDeviceModel
    public var sellingPointID: Int
    public var customer: String
}

public struct RawAuditEndpointsGroup: EndpointGroupType {
    
    public static var group = "rawAudit"
    
    public static func find(auditID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "find", value: nil),
            PathParameter(name: "id", value: .uuid(auditID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func findRawAuditInfo(auditID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "find_raw_audit_info", value: nil),
            PathParameter(name: "id", value: .uuid(auditID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
