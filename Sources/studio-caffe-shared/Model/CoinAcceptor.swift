import Foundation

public enum CoinAcceptor: String, Codable, CaseIterable, Identifiable, Sendable {
    public var id: String {
        rawValue
    }
    case MEI_CASHFLOW_9510 = "MEI Cashflow 9510"
    case MEI_CF_330 = "MEI CF 330"
    case MEI_CF_690 = "MEI CF 690"
    case MEI_CF_7400 = "MEI CF 7400"
    case MEI_CF_7900 = "MEI CF 7900"
    case MEI_CF_8000 = "MEI CF 8000"
    case MEI_GRYPHON = "MEI Gryphon"
    case COGES_PROFIT = "Coges Profit"
    case NRI_CURRENZA_C2 = "NRI Currenza C2"
    case COINCO_GUARDIAN = "Coinco Guardian"
    case ICT_CC6100 = "ICT CC6100"
    case COMESTERO_RM5 = "Comestero RM5"
    case CPI_EAGLE = "CPI Eagle"
    case none = "nessuno"
    
    public var coinAcceptorDescription: String {
        switch self {
            case .MEI_CASHFLOW_9510: return "moneta(\(rawValue))"
            case .MEI_CF_330: return "rendiresto(\(rawValue))"
            case .MEI_CF_690: return "rendiresto(\(rawValue))"
            case .MEI_CF_7400: return "rendiresto(\(rawValue))"
            case .MEI_CF_7900: return "rendiresto(\(rawValue))"
            case .MEI_CF_8000: return "rendiresto(\(rawValue))"
            case .MEI_GRYPHON: return "rendiresto(\(rawValue))"
            case .COGES_PROFIT: return "rendiresto(\(rawValue))"
            case .NRI_CURRENZA_C2: return "rendiresto(\(rawValue))"
            case .COINCO_GUARDIAN: return "rendiresto(\(rawValue))"
            case .ICT_CC6100: return "rendiresto(\(rawValue))"
            case .COMESTERO_RM5: return "moneta(\(rawValue))"
            case .CPI_EAGLE: return "moneta(\(rawValue))"
            case .none: return ""
        }
    }
}

extension CoinAcceptor: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}
