import Foundation
import Testing
import studio_caffe_shared

struct AdeDeviceFiscalStatusTests {
    @Test func usesOnlyTheFiveVendingStatesAndOfficialReasonCodes() throws {
        #expect(AdeDeviceFiscalStatus.allCases.map(\.rawValue) == ["ATTIVATO", "IN_SERVIZIO", "FUORI_SERVIZIO", "DISATTIVATO", "DISMESSO"])
        #expect(AdeDeviceFiscalStatus(rawValue: "CENSITO") == nil)
        #expect(AdeDeviceFiscalStatusReason.allCases.map(\.rawValue) == ["00601", "00603", "00604", "00605", "00606", "00607", "00608"])
        for status in AdeDeviceFiscalStatus.allCases {
            #expect(try JSONDecoder().decode(AdeDeviceFiscalStatus.self, from: JSONEncoder().encode(status)) == status)
        }
    }

    @Test(arguments: AdeDeviceFiscalStatusReason.allCases)
    func validatesEveryReasonAgainstEveryStatus(_ reason: AdeDeviceFiscalStatusReason) {
        for status in AdeDeviceFiscalStatus.allCases {
            let update = AdeDeviceFiscalStatusUpdate(status: status, reason: reason, reasonDescription: "Dettaglio")
            #expect((update.validationMessage == nil) == reason.compatibleStatuses.contains(status))
        }
        #expect(AdeDeviceFiscalStatusUpdate(status: nil, reason: reason).validationMessage != nil)
    }

    @Test func requiresAnExplicitStatusKeyAndAnExplanationForOther() throws {
        #expect(throws: DecodingError.self) { try JSONDecoder().decode(AdeDeviceFiscalStatusUpdate.self, from: Data("{}".utf8)) }
        let clear = AdeDeviceFiscalStatusUpdate(status: nil)
        let data = try JSONEncoder().encode(clear)
        #expect(String(decoding: data, as: UTF8.self).contains("\"status\":null"))
        #expect(try JSONDecoder().decode(AdeDeviceFiscalStatusUpdate.self, from: data) == clear)
        #expect(clear.validationMessage == nil)
        #expect(AdeDeviceFiscalStatusUpdate(status: .outOfService, reason: .other, reasonDescription: " \n").validationMessage != nil)
        #expect(AdeDeviceFiscalStatusUpdate(status: .inService, reasonDescription: "test").validationMessage != nil)
        let update = AdeDeviceFiscalStatusUpdate(status: .outOfService, reason: .other, reasonDescription: "  Manutenzione\n")
        #expect(update.validationMessage == nil && update.normalizedReasonDescription == "Manutenzione")
    }

    @Test func deviceDTOsReadOldPayloadsAndPreserveFiscalDataInRoundTripsAndEquality() throws {
        var device = AdeDeviceDTO.newDevice(adeID: "123", model: .NEWIS_HI)
        let old = try JSONEncoder().encode(device)
        #expect(try JSONDecoder().decode(AdeDeviceDTO.self, from: old).fiscalStatus == nil)
        let previous = device
        device.fiscalStatus = .outOfService
        device.fiscalStatusReason = .warehouse
        device.fiscalStatusReasonDescription = "Deposito"
        #expect(device != previous)
        #expect(try JSONDecoder().decode(AdeDeviceDTO.self, from: JSONEncoder().encode(device)) == device)
        let fetched = FetchedDevice(id: device.id, adeID: device.adeID, qrCode: device.qrCode, model: device.model,
                                   configuration: device.configuration, fiscalStatus: device.fiscalStatus,
                                   fiscalStatusReason: device.fiscalStatusReason, fiscalStatusReasonDescription: device.fiscalStatusReasonDescription)
        let copy = try JSONDecoder().decode(FetchedDevice.self, from: JSONEncoder().encode(fetched))
        #expect(copy.fiscalStatus == .outOfService && copy.fiscalStatusReason == .warehouse && copy.fiscalStatusReasonDescription == "Deposito")
        #expect(try JSONDecoder().decode(FetchedDevice.self, from: old).fiscalStatus == nil)
    }

    @Test func followsTheExistingDeviceEndpointConventions() throws {
        let id = UUID()
        let update = AdeDeviceFiscalStatusUpdate(status: .inService)
        let endpoint = AdeDeviceEndpointsGroup.saveFiscalStatus(deviceID: id, update: update)
        #expect(endpoint.clientRoute == "adeDevice/save_fiscal_status/\(id.uuidString)/")
        #expect(endpoint.serverRoute == ["save_fiscal_status", ":device_id"])
        #expect(endpoint.httpMethod == .post && endpoint.requiresToken && !endpoint.allowsCaching)
        let data = try #require(endpoint.body?.toJSONData())
        #expect(try JSONDecoder().decode(AdeDeviceFiscalStatusUpdate.self, from: data) == update)
    }
}
