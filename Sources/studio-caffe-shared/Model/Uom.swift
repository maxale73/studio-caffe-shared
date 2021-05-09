import Foundation

public enum Uom: String, Codable, CaseIterable, Identifiable {
    public var id: String { rawValue }
    case kg
    case pezzo = "pz"
    case litri = "lt"
    case giorni = "gg"
}

extension Uom: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}
