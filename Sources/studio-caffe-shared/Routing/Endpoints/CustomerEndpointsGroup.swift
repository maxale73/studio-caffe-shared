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

public struct CustomerName: Codable, Identifiable, Equatable, Hashable {
    public var id: UUID
    public var businessName: String
    public var alias: String?
}

public struct CustomerEndpointsGroup: EndpointGroupType {
    
    public static var group = "customer"
    
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
    
    public static func findBySP(customerID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "find_by_sp", value: nil),
            PathParameter(name: "customer_id", value: .uuid(customerID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func findBySPWithSellingPoint(sellingPointID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "find_by_sp_with_sp", value: nil),
            PathParameter(name: "selling_point_id", value: .uuid(sellingPointID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func installedMachines() -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "installed_machines", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
