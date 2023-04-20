import Foundation

public struct AddressBySP: Codable, Identifiable, Equatable, Hashable, RequestBody {
    public var id: UUID
    
    public var latitude: Double?
    public var longitude: Double?
    public var address1: String
    public var address2: String?
    public var city: String
    public var province: String
    public var postalCode: String
    public var isLegalAddress: Bool
    public var sellingPoints: [SellingPointBySP]
    
    public init(id: UUID, latitude: Double? = nil, longitude: Double? = nil, address1: String, address2: String? = nil, city: String, province: String, postalCode: String, isLegalAddress: Bool, sellingPoints: [SellingPointBySP]) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.province = province
        self.postalCode = postalCode
        self.isLegalAddress = isLegalAddress
        self.sellingPoints = sellingPoints
    }
    
    public static func == (lhs: AddressBySP, rhs: AddressBySP) -> Bool {
        return
            lhs.id == rhs.id
            && lhs.latitude == rhs.latitude
            && lhs.longitude == rhs.longitude
            && lhs.address1 == rhs.address1
            && lhs.address2 == rhs.address2
            && lhs.city == rhs.city
            && lhs.province == rhs.province
            && lhs.postalCode == rhs.postalCode
            && lhs.isLegalAddress == rhs.isLegalAddress
            && lhs.sellingPoints == rhs.sellingPoints
    }
}

public struct AddressEndpointsGroup: EndpointGroupType {
    
    public static var group = "address"
    
    public static func save(address: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: address)
    }
    
    public static func delete(addressID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "delete", value: nil),
            PathParameter(name: "address_ID", value: .uuid(addressID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post)
    }
}
