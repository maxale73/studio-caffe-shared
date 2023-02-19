import Foundation

public enum AssetsDocumentType: String, CaseIterable, RawRepresentable, Codable, Identifiable {
    
    public var id: String { rawValue }
    case acquisto
    case vendita
}
