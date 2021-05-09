import Foundation

public enum MachineModelType: String, Codable, CaseIterable, RawRepresentable, Identifiable {
    public var id: String {
        rawValue
    }
    case caldo, freddo, snack, misto
}

extension MachineModelType: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}
