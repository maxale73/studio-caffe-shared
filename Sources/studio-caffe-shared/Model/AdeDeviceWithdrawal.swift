import Foundation

/// Le sole causali ammesse per il ritiro fisico del sistema o del distributore associato.
public enum AdeDeviceWithdrawalReason: String, Codable, CaseIterable, Identifiable, Sendable {
    case warehouse = "00608"
    case malfunction = "00607"

    public var id: String { rawValue }
    public var displayName: String { fiscalReason.displayName }
    public var fiscalReason: AdeDeviceFiscalStatusReason {
        switch self {
        case .warehouse: .warehouse
        case .malfunction: .malfunction
        }
    }
}

public struct AdeDeviceWithdrawal: Codable, Equatable, RequestBody, Sendable {
    public let reason: AdeDeviceWithdrawalReason
    public init(reason: AdeDeviceWithdrawalReason) { self.reason = reason }
}
