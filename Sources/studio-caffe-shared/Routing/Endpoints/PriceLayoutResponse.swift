import Foundation

/// Risposta di lettura o salvataggio del listino associato al dispositivo richiesto.
///
/// `layout == nil` indica un dispositivo esistente senza configurazione.
/// Il primo salvataggio di una pista crea il layout sul server.
public struct PriceLayoutResponse: Codable, Equatable, Sendable {
    public var adeDeviceID: UUID
    public var layout: PriceLayoutDTO?

    public init(adeDeviceID: UUID, layout: PriceLayoutDTO? = nil) {
        self.adeDeviceID = adeDeviceID
        self.layout = layout
    }
}
