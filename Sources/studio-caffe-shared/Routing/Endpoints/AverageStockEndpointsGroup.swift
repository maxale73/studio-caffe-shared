import Foundation

public struct AverageStockDTO: Identifiable, Equatable, Codable, Hashable {
    
    public init(id: UUID, amount: Double, productTypology: ProductTypologyDTO) {
        self.id = id
        self.amount = amount
        self.productTypology = productTypology
    }
    
    public var id: UUID
    public var amount: Double
    public var productTypology: ProductTypologyDTO
}

extension AverageStockDTO: RequestBody {}

public struct AverageStockEndpointsGroup: EndpointGroupType {
    
    public static var group = "average_stock"
    
    public static func fetchByModel(modelID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "fetch_by_model", value: nil),
            PathParameter(name: "model_id", value: .uuid(modelID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func updateForModel(modelID: UUID? = nil, stocks: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [ PathParameter(name: "update_for_model", value: nil),
                           PathParameter(name: "model_id", value: .uuid(modelID))
                           ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: stocks)
    }
    
    public static func inventory() -> EndpointConfiguration {
        let parameters = [ PathParameter(name: "inventory", value: nil)
                           ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}

