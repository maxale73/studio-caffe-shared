import Foundation

public enum AdeDeviceModel: String, Codable, CaseIterable, Identifiable, Equatable, Sendable {
    public var id: String {
        rawValue
    }
    case TELEVEND = "Televend"
    case NEWIS_ZIP = "Newis Zip"
    case NEWIS_HI = "Newis Hi"
    case ELKEY_BUBBLE = "ElKey Bubble"
    case ELKEY_BUBBLE_S = "ElKey Bubble S"
    case ELKEY_BUBBLE_XL = "ElKey Bubble XL"
    case ELKEY_ATTO_COIN = "ElKey Atto Coin"
    case MEI7000 = "MEI 7000"
    case MEI7900 = "MEI 7900"
    case MEI690 = "MEI 690"
    case MEI8000 = "MEI 8000"
    case MEI_GRYPHON = "MEI Gryphon"
    case COGES_PROFIT = "Coges Profit"
    case NRI_CURRENZA_C2 = "NRI Currenza C2"
    case COINCO_GUARDIAN = "Coinco Guardian"
    case ICT_CC6100 = "ICT CC6100"
    case SCATTI = "Scatti"
    case none = "nessun modello"
    
    public static func type(from string: String) -> Self {
        let reference = string.lowercased()
        if reference.contains("ELK ATTO COIN".lowercased()) {
            return .ELKEY_ATTO_COIN
        } else if reference.contains("ELK Bubble".lowercased()) {
            return .ELKEY_BUBBLE
        } else if reference.contains("zip".lowercased()) {
            return .NEWIS_ZIP
        } else if reference.contains("platinum exe".lowercased()) {
            return .NEWIS_HI
        } else if reference.contains("CF7900".lowercased()) {
            return .MEI7900
        } else if reference.contains("CF8000".lowercased()) {
            return .MEI8000
        } else if reference.contains("GRYPHON".lowercased()) {
            return .MEI_GRYPHON
        } else if reference.contains("NRI C2".lowercased()) {
            return .NRI_CURRENZA_C2
        } else if reference.contains("PROFIT".lowercased()) {
            return .COGES_PROFIT
        }
        
        return .none
    }
}

extension AdeDeviceModel: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}

extension AdeDeviceModel: CustomRawRepresentable {
    public static var representableCases: [AdeDeviceModel] {
        allCases.dropLast()
    }
    
    public var representableValue: String {
        switch self {
            case .ELKEY_BUBBLE: return "Bubble"
            case .ELKEY_BUBBLE_S: return "Bubble S"
            case .ELKEY_BUBBLE_XL: return "Bubble XL"
            case .ELKEY_ATTO_COIN: return "Atto Coin"
            case .MEI_GRYPHON: return "Gryphon"
            case .COGES_PROFIT: return "Profit"
            case .NRI_CURRENZA_C2: return "Curr C2"
            default:
                return rawValue
        }
    }
}
