import Foundation

public protocol Body: Encodable {
    func toJSONData() -> Data?
}

public extension Body {
    func toJSONData() -> Data? { try? JSONEncoder.scEncoder.encode(self) }
}
