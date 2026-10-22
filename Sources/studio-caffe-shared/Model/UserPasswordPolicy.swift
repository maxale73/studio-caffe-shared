import Foundation

public enum UserPasswordPolicy {
    public static let minimumLength = 8
    public static let maximumUTF8Bytes = 72

    public static func isValid(_ password: String) -> Bool {
        password.count >= minimumLength && password.utf8.count <= maximumUTF8Bytes && !password.utf8.contains(0)
    }
}
