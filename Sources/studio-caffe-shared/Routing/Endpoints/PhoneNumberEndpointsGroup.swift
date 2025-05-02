import Foundation

public struct PhoneNumberDTO: Codable, Equatable, Identifiable, Hashable, Sendable {
    
    public init(id: UUID, number: String, numberDescription: String, customer: IDType) {
        self.id = id
        self.number = number
        self.numberDescription = numberDescription
        self.customer = customer
    }
    
    
    public var id: UUID
    
    public var number: String
    public var numberDescription: String
    public var customer: IDType
    
    public static func == (lhs: PhoneNumberDTO, rhs: PhoneNumberDTO) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.number == rhs.number &&
            lhs.numberDescription == rhs.numberDescription &&
            lhs.customer == rhs.customer
    }
}

extension PhoneNumberDTO: RequestBody {}

public struct PhoneNumberEndpointsGroup: EndpointGroupType {
    
    public static var group: String { "phoneNumber" }
    
    public static func save(phoneNumber: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: phoneNumber)
    }
    
    public static func delete(numberID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "delete", value: nil),
            PathParameter(name: "number_ID", value: .uuid(numberID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post)
    }
}
