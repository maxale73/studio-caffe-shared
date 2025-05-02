import Foundation

public struct RistornoDTO: Codable, Equatable, Identifiable, Hashable {
    
    public init(id: UUID, importoUnitario: Double, frequenza: FrequenzaRistorno, dataUltimoPagamento: Date, dataProssimoPagamento: Date, customerID: IDType) {
        self.id = id
        self.importoUnitario = importoUnitario
        self.frequenza = frequenza
        self.dataUltimoPagamento = dataUltimoPagamento
        self.dataProssimoPagamento = dataProssimoPagamento
        self.customerID = customerID
    }
    
    
    public var id: UUID
    public var importoUnitario: Double
    public var frequenza: FrequenzaRistorno
    public var dataUltimoPagamento: Date
    public var dataProssimoPagamento: Date
    public var customerID: IDType
    
    public static func == (lhs: RistornoDTO, rhs: RistornoDTO) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.importoUnitario == rhs.importoUnitario &&
            lhs.frequenza == rhs.frequenza &&
            lhs.dataUltimoPagamento == rhs.dataUltimoPagamento &&
            lhs.dataProssimoPagamento == rhs.dataProssimoPagamento
    }
}

extension RistornoDTO {
    public mutating func scorporaIVA(si: Bool) {
        if si {
            self.importoUnitario = self.importoUnitario.scorporoIVA()
        }
    }
}

extension RistornoDTO: RequestBody {}

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
    
    public init(ristorno: RistornoDTO, cliente: String, evaReports: [AuditConsumption]) {
        self.id = ristorno.id
        self.cliente = cliente
        self.ristorno = ristorno
        self.evaReports = evaReports
    }
    
    public var id: UUID
    public var cliente: String
    public var ristorno: RistornoDTO
    public var evaReports: [AuditConsumption]
}

public struct RistornoEndpointsGroup: EndpointGroupType {
    
    public static var group: String { "ristorno" }
    
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
