import Foundation

/// Sostituisce soltanto lo stato fiscale locale e la sua eventuale causale.
///
/// `status: null` rimuove un dato non noto o registrato per errore. La chiave
/// `status` è obbligatoria nel JSON per distinguere la cancellazione da un body vuoto.
/// L'operazione non invia richieste all'Agenzia delle Entrate.
public struct AdeDeviceFiscalStatusUpdate: Codable, Equatable, RequestBody, Sendable {
    public var status: AdeDeviceFiscalStatus?
    public var reason: AdeDeviceFiscalStatusReason?
    public var reasonDescription: String?

    public init(status: AdeDeviceFiscalStatus?, reason: AdeDeviceFiscalStatusReason? = nil,
                reasonDescription: String? = nil) {
        self.status = status
        self.reason = reason
        self.reasonDescription = reasonDescription
    }

    /// Descrizione ripulita; testo vuoto e soli spazi sono rappresentati come dato assente.
    public var normalizedReasonDescription: String? {
        guard let value = reasonDescription?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty else { return nil }
        return value
    }

    /// Vincoli condivisi da interfaccia e server, inclusa la descrizione obbligatoria per `00601`.
    public var validationMessage: String? {
        if let reason {
            guard let status else { return "Seleziona uno stato fiscale prima della causale." }
            guard reason.compatibleStatuses.contains(status) else { return "La causale non è compatibile con lo stato fiscale." }
            if reason == .other && normalizedReasonDescription == nil { return "Descrivi la causale Altro." }
        } else if normalizedReasonDescription != nil {
            return "Seleziona una causale per inserire la descrizione."
        }
        return nil
    }

    private enum CodingKeys: String, CodingKey { case status, reason, reasonDescription }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(AdeDeviceFiscalStatus?.self, forKey: .status)
        reason = try container.decodeIfPresent(AdeDeviceFiscalStatusReason.self, forKey: .reason)
        reasonDescription = try container.decodeIfPresent(String.self, forKey: .reasonDescription)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(status, forKey: .status)
        try container.encodeIfPresent(reason, forKey: .reason)
        try container.encodeIfPresent(reasonDescription, forKey: .reasonDescription)
    }
}
