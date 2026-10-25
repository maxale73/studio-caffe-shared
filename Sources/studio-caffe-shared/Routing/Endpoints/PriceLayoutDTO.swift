import Foundation

/// Configurazione corrente delle piste di un dispositivo, ordinata per indice.
public struct PriceLayoutDTO: Identifiable, Codable, Equatable, Sendable {
    public var id: UUID
    public var adeDeviceID: UUID
    public var channels: [PriceChannelDTO]
    public var createdAt: Date?
    public var updatedAt: Date?

    public init(id: UUID, adeDeviceID: UUID, channels: [PriceChannelDTO],
                createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self.adeDeviceID = adeDeviceID
        self.channels = channels
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
