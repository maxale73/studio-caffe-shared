import Foundation

/// Settore fisico a due cifre, con un eventuale prefisso che identifica il distributore.
///
/// `11` appartiene al distributore senza prefisso; `011` e `x11` identificano
/// il settore 11 di altri due distributori. Il prefisso è una lettera o cifra
/// e viene conservato esattamente, compreso lo zero iniziale.
public struct PriceChannelSector: RawRepresentable, Equatable, Hashable, Sendable {
    public let rawValue: String
    public let machinePrefix: String
    public let sectorNumber: Int

    /// Accetta esattamente due cifre ASCII, precedute al massimo da una lettera o cifra.
    /// Gli spazi esterni sono ignorati; il valore vuoto è gestito come settore assente dal DTO.
    public init?(rawValue: String) {
        let text = rawValue.trimmingCharacters(in: .whitespacesAndNewlines)
        guard (2...3).contains(text.count) else { return nil }
        let digits = String(text.suffix(2))
        guard digits.utf8.allSatisfy({ (48...57).contains($0) }), let number = Int(digits) else { return nil }
        let prefix = String(text.dropLast(2))
        guard prefix.isEmpty || prefix.first.map({ $0.isLetter || $0.isNumber }) == true else { return nil }
        self.rawValue = text
        machinePrefix = prefix
        sectorNumber = number
    }
}
