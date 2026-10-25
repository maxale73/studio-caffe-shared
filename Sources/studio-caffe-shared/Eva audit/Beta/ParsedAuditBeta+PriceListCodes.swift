import Foundation

extension ParsedAuditBeta {
    /// Restituisce il codice della pista fisica rappresentata da un record LA1.
    ///
    /// Nei Newis HI la lista 5 usa gli indici 101...200 per le vendite con punti
    /// fedeltà delle piste 1...100. Questi record non definiscono altre piste.
    /// Le altre liste e i dispositivi differenti conservano il codice originale.
    ///
    /// Funziona anche prima di `parseReport()`, leggendo i metadati del dispositivo:
    /// il seed server e il browser audit devono applicare la stessa corrispondenza.
    /// - SeeAlso: `docs/newis-hi-price-list.md` per la documentazione del produttore.
    public func priceListProductCode(listNumber: Int?, productCode: String) -> String {
        guard listNumber == 5, let index = Int(productCode), (101...200).contains(index),
              priceListDeviceModel == .NEWIS_HI else { return productCode }
        return String(index - 100)
    }

    private var priceListDeviceModel: AdeDeviceModel {
        guard detectedDeviceModel == .none else { return detectedDeviceModel }
        let blocks = rawReport.split(separator: "\n").map {
            $0.split(separator: "*", omittingEmptySubsequences: false)
        }
        // Same identification priority as parseReport(), without parsing counters.
        for (name, index) in [("DXS", 1), ("ID1", 2), ("ID7", 5), ("AM1", 2)] {
            guard let fields = blocks.first(where: { $0.first == Substring(name) }), fields.count > index else { continue }
            let model = AdeDeviceModel.type(from: String(fields[index]))
            if model != .none { return model }
        }
        return .none
    }
}
