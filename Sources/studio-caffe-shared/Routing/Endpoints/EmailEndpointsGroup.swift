import Foundation

public struct EmailDTO: Codable, Equatable, Identifiable, Hashable {
    
    public var id: UUID
    public var address: String
    public var emailDescription: String
    public var customer: IDType

    public init(id: UUID,
         address: String,
         emailDescription: String,
         customer: IDType) {
        
        self.id = id
        self.address = address
        self.emailDescription = emailDescription
        self.customer = customer
    }
    
    public static func == (lhs: EmailDTO, rhs: EmailDTO) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.address == rhs.address &&
            lhs.emailDescription == rhs.emailDescription &&
            lhs.customer == rhs.customer
    }
}

extension EmailDTO: RequestBody {}

public struct EmailEndpointsGroup: EndpointGroupType {
    
    public static var group = "email"
    
    public static func save(email: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: email)
    }
    
    public static func delete(emailID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "delete", value: nil),
            PathParameter(name: "email_ID", value: .uuid(emailID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post)
    }
}
