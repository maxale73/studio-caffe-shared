import Foundation

public struct EndpointConfiguration: RequestConfigurationType {
    public var group: String
    public var requiresToken: Bool
    public var clientRoute: String
    public var serverRoute: [String]
    public var allowsCaching: Bool
    public var httpMethod: HTTPMethod
    public var body: Body?
    
    init(pathConstructor: PathConstructor, method: HTTPMethod, requiresToken: Bool = true, allowsCaching: Bool = false, body: Body? = nil) {
        self.group = pathConstructor.group
        self.clientRoute = pathConstructor.clientSidePath
        self.serverRoute = pathConstructor.serverSidePath
        self.allowsCaching = allowsCaching
        self.requiresToken = requiresToken
        self.httpMethod = method
        self.body = body
    }
}
