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
    
    public static var group: String { "" }
    
    public static func login(email: String? = nil, password: String? = nil) -> EndpointConfiguration {
        var base64LoginString: String? = nil
        if let _email = email, let _password = password {
            let loginData = ("\(_email):\(_password)").data(using: .utf8)!
            base64LoginString = loginData.base64EncodedString(options: .lineLength64Characters)
        }
        let parameters = [
            PathParameter(name: "st_login", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, requiresToken: false, loginString: base64LoginString)
    }
}
