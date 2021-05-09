import Foundation

public enum IvaType: Double, Codable, CaseIterable, Identifiable {
    public var id: Double { rawValue }
    case quattro = 4.0
    case dieci = 10.0
    case ventidue = 22.0
}

extension IvaType: CustomStringConvertible {
    public var description: String {
        NumberFormatter.decimalFormatter().string(from: .init(value: rawValue))!
    }
}
