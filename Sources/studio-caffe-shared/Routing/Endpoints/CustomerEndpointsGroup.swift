import Foundation

public struct CustomerDTO: Codable, Identifiable, Hashable {
    
    public init(id: UUID, businessName: String, alias: String, partitaIva: String, codiceFiscale: String, cuFatturazione: String, iban: String, referencePerson: String, notes: [String]? = nil) {
        self.id = id
        self.businessName = businessName
        self.alias = alias
        self.partitaIva = partitaIva
        self.codiceFiscale = codiceFiscale
        self.cuFatturazione = cuFatturazione
        self.iban = iban
        self.referencePerson = referencePerson
        self.notes = notes
    }
    
    public var id: UUID
    
    public var businessName: String
    public var alias: String
    public var partitaIva: String
    public var codiceFiscale: String
    public var cuFatturazione: String
    public var iban: String
    public var referencePerson: String
    public var notes: [String]?
    
}

public struct CustomerEndpointsGroup {
    
    public static let group = "customer"
    
    public static func indexWithFilter(filter: Body? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index_with_filter", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
    
    public static func save(customer: Body? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: customer)
    }
}
