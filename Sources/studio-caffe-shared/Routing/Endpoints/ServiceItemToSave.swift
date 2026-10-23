import Foundation

public struct ServiceItemToSave: Identifiable, Codable, Equatable, Hashable, Sendable {
    public var id: UUID
    public var catalogID: UUID
    public var operationType: ServiceOperationType

    public init(id: UUID = UUID(), catalogID: UUID, operationType: ServiceOperationType) {
        self.id = id
        self.catalogID = catalogID
        self.operationType = operationType
    }

    public static func isValidSelection(_ items: [Self]) -> Bool {
        (1...50).contains(items.count)
            && Set(items.map(\.id)).count == items.count
            && Set(items.map { $0.catalogID.uuidString + ":" + $0.operationType.rawValue }).count == items.count
    }
}
