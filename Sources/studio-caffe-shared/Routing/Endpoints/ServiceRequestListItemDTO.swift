import Foundation

public struct ServiceRequestListItemDTO: Identifiable, Codable, Equatable, Sendable {
    public var id: UUID { request.id }
    public var request: ServiceRequestDTO
    public var machine: FilteredMachineDTO

    public init(request: ServiceRequestDTO, machine: FilteredMachineDTO) {
        self.request = request
        self.machine = machine
    }
}
