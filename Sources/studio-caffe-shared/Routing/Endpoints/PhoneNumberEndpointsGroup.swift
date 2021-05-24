import Foundation

public struct PhoneNumberEndpointsGroup: EndpointGroupType {
    
    public static var group = "phoneNumber"
    
    public static func save(phoneNumber: Body? = nil) -> EndpointConfiguration {
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
