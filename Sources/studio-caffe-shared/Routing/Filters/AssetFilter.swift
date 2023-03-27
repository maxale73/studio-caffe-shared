import Foundation

public enum DocumentTypeFilter: String, RawRepresentable, CaseIterable, Identifiable, Codable {
    case both = "tutti i documenti"
    case buy = "documenti di acquisto"
    case sell = "documenti di vendita"
    
    public var id: String { rawValue }
}

extension DocumentTypeFilter: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}

public enum AssetStateFilter: String, RawRepresentable, CaseIterable, Identifiable, Codable {
    case all = "tutti i cespiti"
    case registered = "cespiti registrati"
    case notRegistered = "cespiti non registrati"
    
    public var id: String { rawValue }
}

extension AssetStateFilter: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}

public struct AssetFilter: Identifiable, Equatable, Codable, RequestBody {
    
    public init(id: UUID = UUID(), textFilter: String = "", supplierFilter: UUID? = nil, type: DocumentTypeFilter = .both, assetState: AssetStateFilter = .all) {
        self.id = id
        self.textFilter = textFilter
        self.supplierFilter = supplierFilter
        self.type = type
        self.assetState = assetState
    }
    
    public var id: UUID
    public var textFilter: String
    public var supplierFilter: UUID?
    public var type: DocumentTypeFilter
    public var assetState: AssetStateFilter
}
