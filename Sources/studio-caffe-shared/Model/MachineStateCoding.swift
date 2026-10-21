import Foundation

extension KeyedDecodingContainer {
    func machineState(stateKey: Key, roleKey: Key, legacyKey: Key) throws -> (MachineState, InstallationRole?) {
        if let state = try decodeIfPresent(MachineState.self, forKey: stateKey) {
            return (state, try decodeIfPresent(InstallationRole.self, forKey: roleKey))
        }
        let legacy = try decode(InstallationType.self, forKey: legacyKey)
        return (legacy.machineState, legacy.installationRole)
    }

    func machineHistoryEvent(eventKey: Key, legacyKey: Key) throws -> MachineHistoryEventType {
        if let event = try decodeIfPresent(MachineHistoryEventType.self, forKey: eventKey) { return event }
        let legacy = try decode(InstallationType.self, forKey: legacyKey)
        guard let event = MachineHistoryEventType(installation: legacy) else {
            throw DecodingError.dataCorruptedError(forKey: legacyKey, in: self,
                                                   debugDescription: "Il valore storico non rappresenta un'installazione o un ritiro.")
        }
        return event
    }
}
