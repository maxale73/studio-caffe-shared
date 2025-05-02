import Foundation

public enum InstallationType: String, Codable, Identifiable, CaseIterable, RawRepresentable, Sendable {
    
    public var id: String {
        rawValue
    }
    case master
    case slave
    case associato
    case deposito
    case dismesso
    case venduto
    case rottamato
}

extension InstallationType: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}
