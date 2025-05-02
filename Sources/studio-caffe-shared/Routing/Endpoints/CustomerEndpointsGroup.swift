import Foundation

public struct CustomerCompleteDTO: Codable, Identifiable, Hashable, Equatable, Sendable {
    
    public init(id: UUID, businessName: String, alias: String? = nil, partitaIva: String? = nil, codiceFiscale: String? = nil, cuFatturazione: String? = nil, iban: String? = nil, referencePerson: String, notes: [String]? = nil, addresses: [AddressBySP], phoneNumbers: [PhoneNumberDTO], emails: [EmailDTO], ristorni: [RistornoDTO]) {
        self.id = id
        self.businessName = businessName
        self.alias = alias
        self.partitaIva = partitaIva
        self.codiceFiscale = codiceFiscale
        self.cuFatturazione = cuFatturazione
        self.iban = iban
        self.referencePerson = referencePerson
        self.notes = notes
        self.addresses = addresses
        self.phoneNumbers = phoneNumbers
        self.emails = emails
        self.ristorni = ristorni
    }
    
    
    public var id: UUID
    public var businessName: String
    public var alias: String?
    public var partitaIva: String?
    public var codiceFiscale: String?
    public var cuFatturazione: String?
    public var iban: String?
    public var referencePerson: String
    public var notes: [String]?
    public var addresses: [AddressBySP]
    public var phoneNumbers: [PhoneNumberDTO]
    public var emails: [EmailDTO]
    public var ristorni: [RistornoDTO]
    
    public static func == (lhs: CustomerCompleteDTO, rhs: CustomerCompleteDTO) -> Bool {
        return lhs.id == rhs.id &&
            lhs.businessName == rhs.businessName &&
            lhs.alias == rhs.alias &&
            lhs.partitaIva == rhs.partitaIva &&
            lhs.codiceFiscale == rhs.codiceFiscale &&
            lhs.cuFatturazione == rhs.cuFatturazione &&
            lhs.iban == rhs.iban &&
            lhs.referencePerson == rhs.referencePerson &&
            lhs.notes == rhs.notes &&
            lhs.addresses == rhs.addresses &&
            lhs.phoneNumbers == rhs.phoneNumbers &&
            lhs.emails == rhs.emails &&
            lhs.ristorni == rhs.ristorni
    }
    
    public static var empty: CustomerCompleteDTO {
        CustomerCompleteDTO(id: .init(), businessName: "", alias: nil, partitaIva: nil, codiceFiscale: nil, cuFatturazione: nil, iban: nil, referencePerson: "", notes: nil, addresses: [], phoneNumbers: [], emails: [], ristorni: [])
    }
}


public struct CustomerBySP: Codable, Identifiable, Hashable, Equatable, RequestBody, Sendable {
    public var id: UUID
    
    public var businessName: String
    public var alias: String?
    
    public var addresses: [AddressBySP]
    
    public init(id: UUID,
         businessName: String,
         alias: String?,
         addresses: [AddressBySP] = []) {
        
        self.id = id
        self.businessName = businessName
        self.alias = alias
        
        self.addresses = addresses
    }
    
    public static func == (lhs: CustomerBySP, rhs: CustomerBySP) -> Bool {
        return
            lhs.id == rhs.id
            && lhs.businessName == rhs.businessName
            && lhs.alias == rhs.alias
            && lhs.addresses == rhs.addresses
    }
}

public struct CustomerDTO: Codable, Identifiable, Hashable, Sendable {
    
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

public struct CustomerName: Codable, Identifiable, Equatable, Hashable, Sendable {
    
    public init(id: UUID, businessName: String, alias: String? = nil) {
        self.id = id
        self.businessName = businessName
        self.alias = alias
    }
    
    public var id: UUID
    public var businessName: String
    public var alias: String?
}

public struct CustomerEndpointsGroup: EndpointGroupType {
    
    public static var group: String { "customer" }
    
    public static func indexWithFilter(filter: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index_with_filter", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
    
    public static func save(customer: RequestBody? = nil) -> EndpointConfiguration {
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
    
    public static func findComplete(customerID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "find_complete", value: nil),
            PathParameter(name: "customer_id", value: .uuid(customerID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
