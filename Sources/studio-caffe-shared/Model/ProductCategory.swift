import Foundation

public enum ProductCategory: String, CaseIterable, RawRepresentable, Codable, Identifiable {
    
    public var id: String { rawValue }
    
    case undefined
    case C_13_05_045
    case C_73_01_550
    case C_73_01_560
    case C_73_01_565
    case C_73_01_555
    case C_73_01_533
    case C_73_09_501
    case C_73_01_017
    case C_73_09_006
    case C_75_01_025
}

extension ProductCategory: CustomStringConvertible {
    public var description: String {
        switch self {
        case .undefined: return "non classificato"
        case .C_13_05_045: return "distributori automatici (13.05.045)"
        case .C_73_01_550: return "snack/bibite automatico (73.01.550)"
        case .C_73_01_560: return "caldo automatico (73.01.560)"
        case .C_73_01_565: return "OCS (73.01.565)"
        case .C_73_01_555: return "boccioni (73.01.555)"
        case .C_73_01_533: return "componenti distributori (73.01.533)"
        case .C_73_09_501: return "materiale manutenzione distributori (73.09.501)"
        case .C_73_01_017: return "materiale di consumo (73.01.017)"
        case .C_73_09_006: return "carburanti (73.09.006)"
        case .C_75_01_025: return "energia elettrica (75.01.025)"
        }
    }
}
