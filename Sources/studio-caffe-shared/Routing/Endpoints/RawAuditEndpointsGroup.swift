import Foundation

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
}
