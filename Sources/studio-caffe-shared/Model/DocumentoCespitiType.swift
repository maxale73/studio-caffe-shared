import Foundation

public enum DocumentoCespitiType: String, CaseIterable, RawRepresentable, Codable, Identifiable {
    
    public var id: String { rawValue }
    case acquisto
    case vendita
}
