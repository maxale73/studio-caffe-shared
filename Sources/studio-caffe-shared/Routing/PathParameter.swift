import Foundation

public enum PathParameterValue {
    case bool(Bool?)
    case int(Int?)
    case string(String?)
    case date(Date?)
    case uuid(UUID?)
    
    public var desc: String {
        switch self {
            case .bool(let value):
                if let v = value {
                    return v ? "true" : "false"
                } else {
                    return "false"
                }
            case .int(let value):
                return String(value ?? 0)
            case .string(let value):
                return value ?? ""
            case .date(let value):
                let date = value ?? .legalDistantPast
                return date.ISO8601Formatted
            case .uuid(let value):
                return value?.uuidString ?? ""
        }
    }
}

public struct PathParameter {
    public init(name: String, value: PathParameterValue? = nil) {
        self.name = name
        self.value = value
    }
    
    public var name: String
    public var value: PathParameterValue?
}

public struct PathConstructor {
    public var group: String
    public var elements: [PathParameter] = []
    
    public init(group: String, elements: [PathParameter] ) {
        self.group = group
        self.elements = elements
    }
    
    public var clientSidePath: String {
        let final = elements.reduce("") { partial, element in
            if let v = element.value {
                return "\(partial)\(v.desc)/"
            } else {
                return "\(partial)\(element.name)/"
            }
        }
        if group.isEmpty {
            return final
        } else {
            return "\(group)/\(final)"
        }
    }
    
    public var serverSidePath: [String] {
        elements.map { _el -> String in
            if let _ = _el.value {
                return ":\(_el.name)"
            } else {
                return "\(_el.name)"
            }
        }
    }
}
