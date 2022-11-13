import Foundation

public enum ProductCategory: String, CaseIterable, RawRepresentable, Codable, Identifiable {
    
    public var id: String { rawValue }
    
    case prodotti
    case ricambi
    case distributori
    case generiDiConsumo = "generi di consumo"
    case utenze
    case altro
    
    case undefined
    case C_73_01_550
    case C_73_01_560
    case C_73_01_565
    case C_73_01_555
    case C_73_01_533
    case C_73_09_501
    case C_73_01_017
}

extension ProductCategory: CustomStringConvertible {
    public var description: String {
        switch self {
        case .altro, .distributori, .prodotti, .ricambi, .utenze, .generiDiConsumo:
            return rawValue
        case .undefined: return "non classificato"
        case .C_73_01_550: return "snack/bibite automatico (73.01.550)"
        case .C_73_01_560: return "caldo automatico (73.01.560)"
        case .C_73_01_565: return "OCS (73.01.565)"
        case .C_73_01_555: return "boccioni (73.01.555)"
        case .C_73_01_533: return "componenti distributori (73.01.533)"
        case .C_73_09_501: return "materiale manutenzione distributori (73.09.501)"
        case .C_73_01_017: return "materiale di consumo (73.01.017)"
        }
    }
}
