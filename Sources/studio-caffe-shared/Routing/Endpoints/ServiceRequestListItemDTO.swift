import Foundation

public struct ServiceRequestListItemDTO: Identifiable, Codable, Equatable, Sendable {
    public var id: UUID { request.id }
    public var request: ServiceRequestDTO
    public var machine: FilteredMachineDTO
    public var customer: CustomerName?

    public init(request: ServiceRequestDTO, machine: FilteredMachineDTO, customer: CustomerName? = nil) {
        self.request = request
        self.machine = machine
        self.customer = customer
    }
}
