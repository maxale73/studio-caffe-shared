import Foundation

public struct UserCreateDTO: Codable, Equatable, RequestBody, Sendable {
    public var name: String
    public var email: String
    public var password: String
    public var role: UserRole

    public init(name: String, email: String, password: String, role: UserRole = .visitatore) {
        self.name = name
        self.email = email
        self.password = password
        self.role = role
    }
}
