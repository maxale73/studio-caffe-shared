import Foundation

public enum AdeDeviceModel: String, Codable, CaseIterable, Identifiable {
    public var id: String {
        rawValue
    }
    case NEWIS_ZIP = "Newis Zip"
    case NEWIS_HI = "Newis Hi"
    case ELKEY_BUBBLE = "ElKey Bubble"
    case ELKEY_BUBBLE_S = "ElKey Bubble S"
    case ELKEY_BUBBLE_XL = "ElKey Bubble XL"
    case ELKEY_ATTO_COIN = "ElKey Atto Coin"
    case MEI7000 = "MEI 7000"
    case MEI7900 = "MEI 7900"
    case MEI690 = "MEI 690"
    case NRI_CURRENZA_C2 = "NRI Currenza C2"
    case COINCO_GUARDIAN = "Coinco Guardian"
    case SCATTI = "Scatti"
    case none = "nessun modello"
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
            case .NRI_CURRENZA_C2: return "Curr C2"
            default:
                return rawValue
        }
    }
}
