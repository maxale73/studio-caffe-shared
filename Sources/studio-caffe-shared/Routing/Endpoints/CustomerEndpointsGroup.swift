import Foundation

public struct CustomerDTO: Codable, Identifiable, Hashable {
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
    
    private static let group = "customer"
    
    public static func indexWithFilter(filter: CustomersFilter) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index_with_filter", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
    
    public static func save(customer: Body) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: customer)
    }
}
