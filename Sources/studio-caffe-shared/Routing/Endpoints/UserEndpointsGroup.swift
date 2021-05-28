import Foundation

public struct UserDTO: Codable, Identifiable, Hashable, Equatable {

    public var id: UUID
    public var name: String
    public var email: String
    public var passwordHash: String
    public var role: UserRole

    public init(id: UUID, name: String, email: String, passwordHash: String, role: UserRole) {
        self.id = id
        self.name = name
        self.email = email
        self.passwordHash = passwordHash
        self.role = role
    }
    
    public static func == (lhs: UserDTO, rhs: UserDTO) -> Bool {
        lhs.name == rhs.name
            && lhs.email == rhs.email
            && lhs.passwordHash == rhs.passwordHash
            && lhs.role == rhs.role
    }
    
    public static func emptyUser() -> UserDTO {
        UserDTO(id: UUID(), name: "", email: "", passwordHash: "", role: .visitatore)
    }
}

public struct UserEndpointsGroup: EndpointGroupType {
    
    public static var group = "user"
    
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
