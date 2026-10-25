import Foundation

/// Una pista PriceHolding modificabile, con importi espressi in euro.
///
/// L'identificativo rimane stabile anche quando cambia l'indice della pista.
/// Il dispositivo proprietario è specificato nel percorso dell'endpoint.
public struct PriceChannelDTO: Identifiable, Codable, Equatable, Sendable, RequestBody {
    public var id: UUID
    public var index: Int
    public var type: PriceChannelType
    public var price1: Decimal
    public var price2: Decimal?
    public var description: String?
    public var machineSectorCode: String?

    public init(id: UUID = UUID(), index: Int, type: PriceChannelType = .undefined,
                price1: Decimal, price2: Decimal? = nil, description: String? = nil,
                machineSectorCode: String? = nil) {
        self.id = id
        self.index = index
        self.type = type
        self.price1 = price1
        self.price2 = price2
        self.description = description
        self.machineSectorCode = machineSectorCode
    }

    /// Primo vincolo di dominio violato, condiviso da client e server.
    ///
    /// L'unicità dell'indice e la proprietà della pista sono verificate dal server.
    public var validationMessage: String? {
        guard index > 0 else { return "L'indice della pista deve essere maggiore di zero." }
        for price in [price1, price2].compactMap({ $0 }) {
            guard !price.isNaN, price >= 0, price <= Decimal(9_999_999_999 as Int64) / 100 else {
                return "I prezzi devono essere compresi tra 0 e 99.999.999,99 euro."
            }
            var value = price
            var rounded = Decimal()
            NSDecimalRound(&rounded, &value, 2, .plain)
            guard rounded == price else { return "I prezzi possono avere al massimo due decimali." }
        }
        return nil
    }
}
