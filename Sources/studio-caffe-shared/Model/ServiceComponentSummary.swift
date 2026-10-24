import Foundation

public struct ServiceComponentSummary: Identifiable, Equatable, Sendable {
    public var id: UUID { catalog.id }
    public let catalog: ServiceCatalogDTO
    public let lastServiceDate: Date?
    public let operationTypes: [ServiceOperationType]
    public let counter: Int?
    public let elapsedCounter: Int?
    public let hasCounterDiscontinuity: Bool
    public let hasConflictingReadings: Bool

    public init(catalog: ServiceCatalogDTO, lastServiceDate: Date?, operationTypes: [ServiceOperationType],
                counter: Int?, elapsedCounter: Int?, hasCounterDiscontinuity: Bool = false,
                hasConflictingReadings: Bool = false) {
        self.catalog = catalog
        self.lastServiceDate = lastServiceDate
        self.operationTypes = operationTypes
        self.counter = counter
        self.elapsedCounter = elapsedCounter
        self.hasCounterDiscontinuity = hasCounterDiscontinuity
        self.hasConflictingReadings = hasConflictingReadings
    }
}
