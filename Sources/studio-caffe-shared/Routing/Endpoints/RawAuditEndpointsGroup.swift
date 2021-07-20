import Foundation

public struct RawAuditInfo: Identifiable, Codable {
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
