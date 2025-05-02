import Foundation

public struct WeekdayDTO: Codable, Hashable, Identifiable, Sendable {
    
    public var id: UUID
    
    public var index: Int
    public var weekdayDescription: String

    public init(id: UUID,
         
         index: Int,
         weekdayDescription: String) {
        
        self.id = id
        
        self.index = index
        self.weekdayDescription = weekdayDescription
    }
}

public struct WeekdayEndpointsGroup: EndpointGroupType {
    
    public static var group: String { "weekdays" }
    
    public static func index() -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
