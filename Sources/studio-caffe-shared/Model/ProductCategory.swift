import Foundation

public enum ProductCategory: String, CaseIterable, RawRepresentable, Codable, Identifiable {
    
    public var id: String { rawValue }
    
    case prodotti
    case ricambi
    case distributori
    case generiDiConsumo = "generi di consumo"
    case utenze
    case altro
    
}

extension ProductCategory: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}
