import Foundation

public struct AuditConsumption: Codable, Identifiable, Equatable {
    public init(id: UUID, dataRilevazione: Date, erogazioni: Int) {
        self.id = id
        self.dataRilevazione = dataRilevazione
        self.erogazioni = erogazioni
    }
    
    public var id: UUID
    public var dataRilevazione: Date
    public var erogazioni: Int
}

public struct AuditsRistorno: Codable, Identifiable, Equatable {
    public init(id: UUID, cliente: String, importoUnitario: Double, frequenza: FrequenzaRistorno, dataUltimoPagamento: Date, dataProssimoPagamento: Date, evaReports: [AuditConsumption]) {
        self.id = id
        self.cliente = cliente
        self.importoUnitario = importoUnitario
        self.frequenza = frequenza
        self.dataUltimoPagamento = dataUltimoPagamento
        self.dataProssimoPagamento = dataProssimoPagamento
        self.evaReports = evaReports
    }
    
    public var id: UUID
    public var cliente: String
    public var importoUnitario: Double
    public var frequenza: FrequenzaRistorno
    public var dataUltimoPagamento: Date
    public var dataProssimoPagamento: Date
    public var evaReports: [AuditConsumption]
}

public struct RistornoEndpointsGroup: EndpointGroupType {
    
    public static var group = "ristorno"
    
    public static func save(ristorno: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: ristorno)
    }
    
    public static func ristorniToDate() -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "ristorni_to_date", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
