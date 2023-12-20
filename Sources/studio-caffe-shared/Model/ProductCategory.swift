import Foundation

public enum ProductCategory: String, CaseIterable, RawRepresentable, Codable, Identifiable {
    
    public var id: String { rawValue }
    
    case undefined
    case C_13_05_045
    
//    case C_73_01_550 //old
    case C_73_01_551
    case C_73_01_552
    case C_73_01_553
    case C_73_01_554
    
//    case C_73_01_560 //old
    case C_73_01_561
    case C_73_01_562
    case C_73_01_563
    case C_73_01_564
    
    case C_73_01_565
    case C_73_01_555
    
    case C_73_01_533
    case C_73_01_534
    case C_73_01_535
    
    case C_73_09_501
    case C_73_09_502
    case C_73_09_503
    
    case C_73_01_017
    case C_73_09_006
    case C_75_01_025
    
    case C_75_11_509
}

extension ProductCategory: CustomStringConvertible {
    public var description: String {
        switch self {
        case .undefined: return "non classificato"
        case .C_13_05_045: return "distributori automatici (13.05.045)"
            
//        case .C_73_01_550: return "snack/bibite automatico (73.01.550)" //old
        case .C_73_01_551: return "acqua (73.01.551)"
        case .C_73_01_552: return "altre bibite (73.01.552)"
        case .C_73_01_553: return "snack (73.01.553)"
        case .C_73_01_554: return "freschi (73.01.554)"
            
//        case .C_73_01_560: return "caldo automatico (73.01.560)" //old
        case .C_73_01_561: return "caffè in grani (73.01.561)"
        case .C_73_01_562: return "caffè in cialda (73.01.562)"
        case .C_73_01_563: return "accessori automatico (73.01.563)"
        case .C_73_01_564: return "solubili (73.01.564)"
            
        case .C_73_01_565: return "OCS (73.01.565)"
        case .C_73_01_555: return "boccioni (73.01.555)"
            
        case .C_73_01_533: return "Gettoniere/rendiresto/lettori banconote (73.01.533)"
        case .C_73_01_534: return "Sistemi cashless (73.01.534)"
        case .C_73_01_535: return "Altri componenti distributori (73.01.535)"
            
        case .C_73_09_501: return "materiale manutenzione distributori (73.09.501)"
        case .C_73_09_502: return "ricambi freddo (73.09.502)"
        case .C_73_09_503: return "ricambi caldo (73.09.503)"
            
        case .C_73_01_017: return "materiale di consumo (73.01.017)"
        case .C_73_09_006: return "carburanti (73.09.006)"
        case .C_75_01_025: return "energia elettrica (75.01.025)"
        case .C_75_11_509: return "ristorni (75.11.509)"
        }
    }
    
    public var codeDescription: String {
        switch self {
        case .undefined: return "nd"
        case .C_13_05_045: return "13.05.045"
            
//        case .C_73_01_550: return "73.01.550"
        case .C_73_01_551: return "73.01.551"
        case .C_73_01_552: return "73.01.552"
        case .C_73_01_553: return "73.01.553"
        case .C_73_01_554: return "73.01.554"
            
//        case .C_73_01_560: return "73.01.560"
        case .C_73_01_561: return "73.01.561"
        case .C_73_01_562: return "73.01.562"
        case .C_73_01_563: return "73.01.563"
        case .C_73_01_564: return "73.01.564"
            
        case .C_73_01_565: return "73.01.565"
        case .C_73_01_555: return "73.01.555"
            
        case .C_73_01_533: return "73.01.533"
        case .C_73_01_534: return "73.01.534"
        case .C_73_01_535: return "73.01.535"
            
        case .C_73_09_501: return "73.09.501"
        case .C_73_09_502: return "73.09.502"
        case .C_73_09_503: return "73.09.503"
            
        case .C_73_01_017: return "73.01.017"
        case .C_73_09_006: return "73.09.006"
        case .C_75_01_025: return "75.01.025"
        case .C_75_11_509: return "75.11.509"
        }
    }
}
