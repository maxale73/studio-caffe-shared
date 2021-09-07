import Foundation

public struct PackageDTO: Identifiable, Codable, Equatable, Hashable {
    public init(id: UUID, uom: Uom, barcode: String? = nil, quantity: Double, product: IDType) {
        self.id = id
        self.uom = uom
        self.barcode = barcode
        self.quantity = quantity
        self.product = product
    }
    
    public var id: UUID
    
    public var uom: Uom
    public var barcode: String?
    public var quantity: Double
    public var product: IDType
}

extension PackageDTO: RequestBody {}

public struct PackageEndpointsGroup: EndpointGroupType {
    
    public static var group = "package"
    
    public static func save(package: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: package)
    }
    
}
