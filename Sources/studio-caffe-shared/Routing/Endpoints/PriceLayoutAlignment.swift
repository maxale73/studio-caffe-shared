import Foundation

public enum PriceLayoutAlignmentMode: String, Codable, CaseIterable, Sendable {
    case updateAndAdd = "update_and_add"
    case exact
}

public struct PriceLayoutAlignmentRequest: Codable, Equatable, Sendable, RequestBody {
    public var rawAudit: String
    public var expectedLayoutID: UUID?
    public var expectedUpdatedAt: Date?
    public var mode: PriceLayoutAlignmentMode

    public init(rawAudit: String, expectedLayoutID: UUID?, expectedUpdatedAt: Date?,
                mode: PriceLayoutAlignmentMode) {
        self.rawAudit = rawAudit
        self.expectedLayoutID = expectedLayoutID
        self.expectedUpdatedAt = expectedUpdatedAt
        self.mode = mode
    }
}
