import Foundation

public struct AuditEndpointsGroup {
    
    private static let group = "evaReport"
    
    public static func reports_reportsByMachine(machineID: Int? = nil, from: Date? = nil, to: Date? = nil) -> EndpointConfiguration {
        let parameters = [ PathParameter(name: "reports_by_machine", value: nil),
                           PathParameter(name: "id", value: .int(machineID)),
                           PathParameter(name: "from", value: .date(from)),
                           PathParameter(name: "to", value: .date(to))]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
