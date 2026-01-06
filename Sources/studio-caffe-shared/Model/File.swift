import Foundation

public struct CustomTimeInterval: Equatable, Codable, Sendable {
    
    public init(from: Date, to: Date, intervalDescription: String) {
        self.from = from
        self.to = to
        self.intervalDescription = intervalDescription
    }
    
    
    public var from: Date
    public var to: Date
    public var intervalDescription: String
    
    public static func ever() -> CustomTimeInterval {
        CustomTimeInterval(from: .distantPast, to: .distantFuture, intervalDescription: "ever")
    }
    
    public static func defaultInterval() -> CustomTimeInterval {
        CustomTimeInterval(from: .defaultStartDate, to: .init(), intervalDescription: "default")
    }
    
    public static func nullInterval() -> CustomTimeInterval {
        CustomTimeInterval(from: .legalDistantPast, to: .distantFuture, intervalDescription: "null")
    }
    
}
