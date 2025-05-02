import Foundation

public enum IvaType: Double, Codable, CaseIterable, Identifiable, Sendable {
    public var id: Double { rawValue }
    case quattro = 4.0
    case dieci = 10.0
    case ventidue = 22.0
}

extension IvaType: CustomStringConvertible {
    public var description: String {
        NumberFormatter.localizedString(from: NSNumber(value: (rawValue / 100)), number: .percent)
    }
}
