import Foundation

enum MachineModelType: String, Codable, CaseIterable, RawRepresentable, Identifiable {
    var id: String {
        rawValue
    }
    case caldo, freddo, snack, misto
}

extension MachineModelType: CustomStringConvertible {
    var description: String {
        rawValue
    }
}
