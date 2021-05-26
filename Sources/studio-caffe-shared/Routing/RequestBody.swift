import Foundation

public protocol RequestBody: Encodable {
    func toJSONData() -> Data?
}

public extension RequestBody {
    func toJSONData() -> Data? { try? JSONEncoder.scEncoder.encode(self) }
}

extension Array: RequestBody where Element: Encodable {
    public func toJSONData() -> Data? { try? JSONEncoder.scEncoder.encode(self) }
}
