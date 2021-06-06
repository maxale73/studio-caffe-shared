import Foundation

public enum Uom: String, Codable, CaseIterable, Identifiable {
    public var id: String { rawValue }
    case kg
    case pezzi
    case litri
    case giorni
    case confezioni
    case faldoni
    case cartoni
    case bancali
    case bottiglie
    case lattine
    case metri
    case scatole
    case buste
}

extension Uom: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}
