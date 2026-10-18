import Foundation

public enum ServiceOperationType: String, Codable, Identifiable, CaseIterable, RawRepresentable, Sendable {
    public var id: String { rawValue }

    case lavaggio
    case sostituzione
    case riparazione
    case altro
}

extension ServiceOperationType: CustomStringConvertible {
    public var description: String { rawValue }
}
