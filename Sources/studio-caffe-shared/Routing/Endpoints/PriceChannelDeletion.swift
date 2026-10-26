import Foundation

/// Richiesta di eliminazione atomica di una o più piste dello stesso dispositivo.
///
/// Contiene soltanto gli UUID selezionati: il server verifica l'appartenenza al
/// layout prima di cancellare qualsiasi pista. Prezzi e indici non sono necessari.
public struct PriceChannelDeletion: Codable, Equatable, Sendable, RequestBody {
    public var channelIDs: [UUID]

    public init(channelIDs: [UUID]) {
        self.channelIDs = channelIDs
    }

    /// Una richiesta deve identificare almeno una pista, senza UUID ripetuti.
    public var isValidSelection: Bool {
        !channelIDs.isEmpty && Set(channelIDs).count == channelIDs.count
    }
}
