import Foundation

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
