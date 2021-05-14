import Foundation

public protocol AdeDeviceType {
    var adeID: String { get set }
    var qrCode: String { get set }
    func qrCodeState() -> QRCodeState
}

public extension AdeDeviceType {
    func qrCodeState() -> QRCodeState {
        if qrCode.contains("https://ivaservizi.agenziaentrate.gov.it") {
            return .generato
        } else if adeID == qrCode {
            return .nonGenerato
        } else {
            return .nonValido
        }
    }
}
