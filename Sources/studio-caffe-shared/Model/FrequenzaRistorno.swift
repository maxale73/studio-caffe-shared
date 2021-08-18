import Foundation

public enum FrequenzaRistorno: String, Codable, CaseIterable, Identifiable {
    
    public var id: String { rawValue }
    case mensile
    case trimestrale
    case quadrimestrale
    case semestrale
    case annuale
}

extension FrequenzaRistorno: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}

extension Date {
    public static func newRistornoPeriod(fromOldEndDate oldEndDate: Date, frequenzaRistorno: FrequenzaRistorno) -> (start: Date, end: Date) {
        let calendar = Calendar(identifier: .gregorian)
        let startDate = Date.beginOfNextDay(from: oldEndDate)
        let endDate: Date
        switch frequenzaRistorno {
            case .mensile:
                endDate = calendar.date(byAdding: .month, value: 1, to: oldEndDate)!
            case .trimestrale:
                endDate = calendar.date(byAdding: .month, value: 3, to: oldEndDate)!
            case .quadrimestrale:
                endDate = calendar.date(byAdding: .month, value: 4, to: oldEndDate)!
            case .semestrale:
                endDate = calendar.date(byAdding: .month, value: 6, to: oldEndDate)!
            case .annuale:
                endDate = calendar.date(byAdding: .month, value: 12, to: oldEndDate)!
        }
        return (startDate, Date.endOfDay(from: endDate))
    }
}
