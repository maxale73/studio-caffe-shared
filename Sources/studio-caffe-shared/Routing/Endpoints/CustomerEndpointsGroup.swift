import Foundation

public struct CustomerDTO: Codable, Identifiable, Hashable {
    var id: UUID
    
    var businessName: String
    var alias: String
    var partitaIva: String
    var codiceFiscale: String
    var cuFatturazione: String
    var iban: String
    var referencePerson: String
    var notes: [String]?
    
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
