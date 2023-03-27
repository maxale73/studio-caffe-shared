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
    public var id: UUID = UUID()
    public var textFilter: String = ""
    public var supplierFilter: UUID?
    public var type: DocumentTypeFilter = .both
    public var assetState: AssetStateFilter = .all
}
