import Foundation

import Foundation
import Combine

public struct CapElement: Codable, Identifiable, Hashable {
    public var id: UUID
    public let name: String
    public let cap: String?
    public let children: [CapElement]?
    public let parentName: String?
    
    public init(parentName: String?, name: String, cap: String?, children: [CapElement]?) {
        self.id = UUID()
        self.parentName = parentName
        self.name = name
        self.cap = cap
        self.children = children
    }
}

public struct City: Codable {
    public let name: String
    public let cap: String
}

public struct Province: Codable {
    public var id: UUID
    public let name: String
    public let cites: [City]
}
