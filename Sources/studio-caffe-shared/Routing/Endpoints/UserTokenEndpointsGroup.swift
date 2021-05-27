import Foundation

public struct SavedToken: Codable, Equatable {
    public init(id: UUID, username: String, role: String, token: String) {
        self.id = id
        self.username = username
        self.role = role
        self.token = token
    }
    
    public var id: UUID
    public var username: String
    public var role: String
    public var token: String
}

public struct UserTokenEndpointsGroup: EndpointGroupType {
    
    public static var group = ""
    
    public static func login(email: String, password: String) -> EndpointConfiguration {
        let loginData = ("\(email):\(password)").data(using: .utf8)!
        let base64LoginString = loginData.base64EncodedString(options: .lineLength64Characters)
        let parameters = [
            PathParameter(name: "st_login", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, requiresToken: false, loginString: base64LoginString)
    }
}
