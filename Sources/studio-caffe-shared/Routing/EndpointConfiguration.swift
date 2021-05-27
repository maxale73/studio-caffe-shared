import Foundation

public struct EndpointConfiguration: RequestConfigurationType {
    public var group: String
    public var requiresToken: Bool
    public var clientRoute: String
    public var serverRoute: [String]
    public var allowsCaching: Bool
    public var httpMethod: HTTPMethod
    public var body: RequestBody?
    public var loginString: String?
    
    init(pathConstructor: PathConstructor, method: HTTPMethod, requiresToken: Bool = true, allowsCaching: Bool = false, body: RequestBody? = nil, loginString: String? = nil) {
        self.group = pathConstructor.group
        self.clientRoute = pathConstructor.clientSidePath
        self.serverRoute = pathConstructor.serverSidePath
        self.allowsCaching = allowsCaching
        self.requiresToken = requiresToken
        self.httpMethod = method
        self.body = body
        self.loginString = loginString
    }
}
