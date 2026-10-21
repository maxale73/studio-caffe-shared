import Foundation
import Testing
import studio_caffe_shared

struct MachineStateTests {
    @Test(arguments: InstallationType.allCases)
    func legacyMachineStatesHaveALosslessConversion(_ legacy: InstallationType) throws {
        #expect(InstallationType(state: legacy.machineState, installationRole: legacy.installationRole) == legacy)
        let machine = MachineDTO(id: UUID(), internalID: 100001, factoryID: "TEST123", model: .emptyModel,
                                 notes: ["nota"], installation: legacy, sellingPoint: nil, adeDevice: nil)
        let data = try JSONEncoder.scEncoder.encode(machine)
        let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
        #expect(json["state"] as? String == legacy.machineState.rawValue)
        #expect(json["installation"] as? String == legacy.rawValue)
        #expect(try JSONDecoder().decode(MachineDTO.self, from: data).installation == legacy)
        var old = json
        old.removeValue(forKey: "state")
        old.removeValue(forKey: "installationRole")
        let decoded = try JSONDecoder().decode(MachineDTO.self, from: JSONSerialization.data(withJSONObject: old))
        #expect(decoded.state == legacy.machineState)
        #expect(decoded.installationRole == legacy.installationRole)
        #expect(decoded.notes == ["nota"])
        let deviceMachine = try JSONDecoder().decode(MachineByDeviceDTO.self, from: data)
        #expect(deviceMachine.state == legacy.machineState)
        #expect(deviceMachine.installationRole == legacy.installationRole)
        #expect(try JSONDecoder().decode(MachineByDeviceDTO.self, from: JSONSerialization.data(withJSONObject: old)) == deviceMachine)
    }

    @Test func newStateFieldsTakePrecedenceOverLegacyCompatibilityFields() throws {
        let machine = MachineBySP(id: UUID(), internalID: 100001, factoryID: "TEST123", notes: nil,
                                  state: .installato, installationRole: nil, model: .emptyModel, adeDevice: nil)
        var json = try #require(JSONSerialization.jsonObject(with: JSONEncoder.scEncoder.encode(machine)) as? [String: Any])
        json["installation"] = "master"
        let decoded = try JSONDecoder().decode(MachineBySP.self, from: JSONSerialization.data(withJSONObject: json))
        #expect(decoded.state == .installato)
        #expect(decoded.installationRole == nil)
        #expect(decoded.installation == .associato)
    }

    @Test(arguments: MachineHistoryEventType.allCases)
    func historyEventsPreserveLegacyWireFormatWithoutAPaymentRole(_ event: MachineHistoryEventType) throws {
        let history = MachineHistoryDTO(id: UUID(), machineID: UUID(), sellingPointID: UUID(), eventType: event,
                                       date: Date(timeIntervalSince1970: 1_000), sellingPoitCode: 1, customer: "Cliente")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let data = try JSONEncoder.scEncoder.encode(history)
        var json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
        #expect(json["eventType"] as? String == event.rawValue)
        #expect(json["installationRole"] == nil)
        #expect(try decoder.decode(MachineHistoryDTO.self, from: data) == history)
        json.removeValue(forKey: "eventType")
        #expect(try decoder.decode(MachineHistoryDTO.self, from: JSONSerialization.data(withJSONObject: json)) == history)
        #expect(history.stateDescription == event.description)
    }

    @Test func unclassifiedLegacyHistoryIsNotSilentlyConvertedToARetirement() {
        #expect(MachineHistoryEventType(installation: .dismesso) == nil)
        #expect(MachineHistoryEventType(installation: .venduto) == nil)
        #expect(MachineHistoryEventType(installation: .rottamato) == nil)
        #expect(MachineHistoryEventType(installation: .master) == .installazione)
        #expect(MachineHistoryEventType(installation: .slave) == .installazione)
    }

    @Test func newFiltersRoundTripAndOldFiltersRemainReadable() throws {
        let filter = MachineFilters(stateFilters: [.installato], roleFilters: [.slave])
        #expect(!filter.empty)
        #expect(try JSONDecoder().decode(MachineFilters.self, from: JSONEncoder.scEncoder.encode(filter)) == filter)
        let old = Data("{\"installationFilters\":[\"master\"],\"textFilter\":\"\",\"typeFilters\":[],\"modelFilters\":[]}".utf8)
        let decoded = try JSONDecoder().decode(MachineFilters.self, from: old)
        #expect(decoded.installationFilters == [.master])
        #expect(decoded.stateFilters.isEmpty && decoded.roleFilters.isEmpty)
    }
}
