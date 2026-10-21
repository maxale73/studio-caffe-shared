import Foundation

public struct MachineStateUpdateDTO: Codable, Equatable, RequestBody, Sendable {
    public var state: MachineState
    public var expectedState: MachineState

    public init(state: MachineState, expectedState: MachineState) {
        self.state = state
        self.expectedState = expectedState
    }
}
