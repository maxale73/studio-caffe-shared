/// La categoria di un canale prezzo del sistema PriceHolding.
///
/// I raw value costituiscono il contratto di persistenza e serializzazione:
/// `snack`, `hot` e `undefined`. Le etichette localizzate dell'interfaccia
/// non devono modificarli. Il database del server li conserva come stringhe.
public enum PriceChannelType: String, Codable, CaseIterable, Sendable {
    /// Canale destinato al comparto snack.
    case snack
    /// Canale destinato al comparto bevande calde.
    case hot
    /// Categoria non ancora assegnata; valore iniziale delle piste migrate.
    case undefined
}
