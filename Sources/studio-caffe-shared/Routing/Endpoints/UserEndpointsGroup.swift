import Foundation

public struct UserDTO: Codable, Identifiable, Hashable, Equatable, Sendable {

    public var id: UUID
    public var name: String
    public var email: String
    public var role: UserRole

    public init(id: UUID, name: String, email: String, role: UserRole) {
        self.id = id
        self.name = name
        self.email = email
        self.role = role
    }

    @available(*, deprecated, message: "Password hashes are not part of user data.")
    public var passwordHash: String { "" }

    @available(*, deprecated, message: "Use init(id:name:email:role:).")
    public init(id: UUID, name: String, email: String, passwordHash: String, role: UserRole) {
        self.init(id: id, name: name, email: email, role: role)
    }

    private enum CodingKeys: String, CodingKey { case id, name, email, passwordHash, role }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(id: try container.decode(UUID.self, forKey: .id), name: try container.decode(String.self, forKey: .name),
                  email: try container.decode(String.self, forKey: .email), role: try container.decode(UserRole.self, forKey: .role))
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(role, forKey: .role)
        // Older app releases require this key; no credential hash is transmitted.
        try container.encode("", forKey: .passwordHash)
    }
    
    public static func == (lhs: UserDTO, rhs: UserDTO) -> Bool {
        lhs.name == rhs.name
            && lhs.email == rhs.email
            && lhs.role == rhs.role
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(email)
        hasher.combine(role)
    }
    
    public static func emptyUser() -> UserDTO {
        UserDTO(id: UUID(), name: "", email: "", role: .visitatore)
    }
}

public struct UserEndpointsGroup: EndpointGroupType {
    
    public static var group: String { "user" }

    public static func administration() -> EndpointConfiguration {
        configuration("administration", method: .get)
    }

    public static func create(user: RequestBody? = nil) -> EndpointConfiguration {
        configuration("create", method: .post, body: user)
    }

    public static func delete(userID: UUID? = nil) -> EndpointConfiguration {
        configuration("delete", parameter: PathParameter(name: "user_id", value: .uuid(userID)), method: .post)
    }

    public static func changePassword(userID: UUID? = nil, password: RequestBody? = nil) -> EndpointConfiguration {
        configuration("change_password", parameter: PathParameter(name: "user_id", value: .uuid(userID)), method: .post, body: password)
    }

    private static func configuration(_ action: String, parameter: PathParameter? = nil, method: HTTPMethod, body: RequestBody? = nil) -> EndpointConfiguration {
        var parameters = [PathParameter(name: action, value: nil)]
        if let parameter { parameters.append(parameter) }
        return EndpointConfiguration(pathConstructor: PathConstructor(group: group, elements: parameters), method: method, body: body)
    }
    
    public static func me() -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "me", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func index() -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
