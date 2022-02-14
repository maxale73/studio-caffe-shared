import Foundation

public enum ASLCommunicationType: String, Codable, Identifiable, CaseIterable, RawRepresentable {
    
    public var id: String {
        rawValue
    }
    case installazione
    case disintallazione
}

extension ASLCommunicationType: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}
