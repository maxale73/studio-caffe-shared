import Foundation

public struct ServiceItemDTO: Identifiable, Codable, Equatable, Hashable, Sendable {
    public var id: UUID
    public var catalog: ServiceCatalogDTO
    public var operationType: ServiceOperationType

    public init(id: UUID, catalog: ServiceCatalogDTO, operationType: ServiceOperationType) {
        self.id = id
        self.catalog = catalog
        self.operationType = operationType
    }

    public var description: String {
        catalog.serviceDescription + " · " + operationType.description
    }
}
