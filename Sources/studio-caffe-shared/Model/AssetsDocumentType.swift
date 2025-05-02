import Foundation

public enum AssetsDocumentType: String, CaseIterable, RawRepresentable, Codable, Identifiable, CustomStringConvertible, Sendable {
    
    public var id: String { rawValue }
    case acquisto
    case vendita
    
    public var description: String {
        rawValue
    }
}
