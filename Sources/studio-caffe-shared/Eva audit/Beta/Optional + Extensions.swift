import Foundation

extension Optional {
    var nullValue: Wrapped! {
        switch self {
            case is Double:
                return Optional.some(0.0 as! Wrapped)!
            case is Int:
                return Optional.some(0 as! Wrapped)!
            default:
                return nil
        }
    }
    
    var fbValue: Wrapped! {
        switch self {
            case is Optional<Double>:
                if self == nil {
                    return Optional.some(0.0 as! Wrapped)!
                } else {
                    return self.unsafelyUnwrapped
                }
            case is Optional<Int>:
                if self == nil {
                    return Optional.some(0 as! Wrapped)!
                } else {
                    return self.unsafelyUnwrapped
                }
            case is Optional<Date>:
                if self == nil {
                    return Optional.some(Date.distantPast as! Wrapped)!
                } else {
                    return self.unsafelyUnwrapped
                }
            case is Optional<String>:
                if self == nil {
                    return Optional.some("unknown" as! Wrapped)!
                } else {
                    return self.unsafelyUnwrapped
                }
            default:
                return nil
        }
    }
    
    var isValid: Bool {
        self != nil
    }
    
    var textDescription: String {
        switch self {
            case is Optional<Double>, is Optional<Int>:
                if self == nil {
                    return "null"
                } else {
                    return String(describing: self!)
                }
            case is Optional<Date>:
                if self == nil {
                    return "undefined"
                } else {
                    return DateFormatter.localizedString(from: self.unsafelyUnwrapped as! Date, dateStyle: .medium, timeStyle: .medium)
                }
            default:
                return "null"
        }
    }
}

