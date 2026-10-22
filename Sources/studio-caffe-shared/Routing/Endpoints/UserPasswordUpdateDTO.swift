import Foundation

public struct UserPasswordUpdateDTO: Codable, Equatable, RequestBody, Sendable {
    public var password: String

    public init(password: String) { self.password = password }
}
