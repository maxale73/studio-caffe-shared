import Foundation

public enum AdeDeviceLifecycleEvent: Sendable {
    case masterAssociation
    case auditImport
    case warehouseReturn
}

/// Regole locali del ciclo fiscale. I primi eventi prevalgono anche sulle annotazioni manuali.
public struct AdeDeviceLifecycleDecision: Equatable, Sendable {
    public let expectedStatus: AdeDeviceFiscalStatus?
    public let resultingStatus: AdeDeviceFiscalStatus?
    public let isFirstEvent: Bool
    public let isInconsistent: Bool
    public let updatesFiscalStatus: Bool
    public let resultingReason: AdeDeviceFiscalStatusReason?
    private let previousStatus: AdeDeviceFiscalStatus?

    public init(event: AdeDeviceLifecycleEvent, currentStatus: AdeDeviceFiscalStatus?,
                hasBeenMaster: Bool, hasImportedAudit: Bool,
                currentReason: AdeDeviceFiscalStatusReason? = nil) {
        previousStatus = currentStatus
        let isInWarehouse = currentStatus == .outOfService && currentReason == .warehouse
        switch event {
        case .masterAssociation:
            isFirstEvent = !hasBeenMaster
            expectedStatus = hasBeenMaster ? (isInWarehouse ? .outOfService : (hasImportedAudit ? .inService : .activated)) : nil
            resultingStatus = hasBeenMaster ? currentStatus : .activated
            updatesFiscalStatus = !hasBeenMaster
            resultingReason = hasBeenMaster ? currentReason : nil
        case .auditImport:
            isFirstEvent = !hasImportedAudit
            expectedStatus = isInWarehouse ? .outOfService : (hasImportedAudit ? .inService : .activated)
            updatesFiscalStatus = !hasImportedAudit || isInWarehouse
            resultingStatus = updatesFiscalStatus ? .inService : currentStatus
            resultingReason = updatesFiscalStatus ? nil : currentReason
        case .warehouseReturn:
            isFirstEvent = false
            expectedStatus = isInWarehouse ? .outOfService : (hasImportedAudit ? .inService : (hasBeenMaster ? .activated : nil))
            resultingStatus = .outOfService
            resultingReason = .warehouse
            updatesFiscalStatus = true
        }
        isInconsistent = currentStatus != expectedStatus
    }

    /// Testo da mostrare dopo il successo dell'operazione, senza interromperla.
    public func alertMessage(adeID: String) -> String? {
        guard isInconsistent else { return nil }
        let device = String(adeID.prefix(80))
        let previous = previousStatus?.rawValue ?? "nullo"
        let expected = expectedStatus?.rawValue ?? "nullo"
        let action = updatesFiscalStatus
            ? "Stato aggiornato automaticamente a \(resultingStatus?.rawValue ?? "nullo")."
            : "Lo stato è stato conservato. Verificare il dispositivo."
        return "Dispositivo \(device): stato fiscale \(previous), atteso \(expected). \(action)"
    }
}

/// Avvisi accessori alle risposte HTTP: il corpo JSON esistente rimane compatibile.
public struct AdeDeviceLifecycleAlerts: Codable, Equatable, Sendable {
    public static let responseHeader = "X-Ade-Device-Lifecycle-Alerts"
    public let messages: [String]
    public let additionalCount: Int

    public init(messages: [String]) {
        self.messages = Array(messages.prefix(4))
        additionalCount = max(0, messages.count - self.messages.count)
    }

    public var message: String {
        let remainder = additionalCount > 0 ? "\n\nAltri \(additionalCount) dispositivi con stato non coerente." : ""
        return messages.joined(separator: "\n\n") + remainder
    }

    public func headerValue() throws -> String {
        try JSONEncoder().encode(self).base64EncodedString()
    }

    public init?(headerValue: String?) {
        guard let headerValue, let data = Data(base64Encoded: headerValue),
              let value = try? JSONDecoder().decode(Self.self, from: data),
              !value.messages.isEmpty else { return nil }
        self = value
    }
}
