import Foundation

public struct IDType: Codable, Equatable, Hashable {
    
    public init(id: UUID) {
        self.id = id
    }
    
    public var id: UUID
}
