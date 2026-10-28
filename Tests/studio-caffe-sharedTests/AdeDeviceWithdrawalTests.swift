import Foundation
import Testing
@testable import studio_caffe_shared

struct AdeDeviceWithdrawalTests {
    @Test(arguments: AdeDeviceWithdrawalReason.allCases)
    func requestsCarryAnExplicitReasonAndWithdrawalSetsOutOfService(_ reason: AdeDeviceWithdrawalReason) throws {
        let body = AdeDeviceWithdrawal(reason: reason)
        for endpoint in [AdeDeviceEndpointsGroup.uninstall(withdrawal: body), MachineEndpointsGroup.uninstall(withdrawal: body)] {
            let data = try #require(endpoint.body?.toJSONData())
            #expect(try JSONDecoder().decode(AdeDeviceWithdrawal.self, from: data) == body)
        }
        let decision = AdeDeviceLifecycleDecision(event: .withdrawal(reason), currentStatus: .inService,
                                                  hasBeenMaster: true, hasImportedAudit: true)
        #expect(decision.resultingStatus == .outOfService && decision.resultingReason == reason.fiscalReason)
        let resumed = AdeDeviceLifecycleDecision(event: .auditImport, currentStatus: .outOfService,
                                                 hasBeenMaster: true, hasImportedAudit: true,
                                                 currentReason: reason.fiscalReason, awaitingServiceAfterWithdrawal: true)
        #expect(resumed.resultingStatus == .inService && resumed.resultingReason == nil && !resumed.isInconsistent)
    }

    @Test(arguments: ["{}", "{\"reason\":null}", "{\"reason\":\"00606\"}", "{\"reason\":\"invalid\"}"])
    func rejectsMissingAndUnsupportedReasons(_ json: String) {
        #expect(throws: DecodingError.self) { try JSONDecoder().decode(AdeDeviceWithdrawal.self, from: Data(json.utf8)) }
    }

    @Test func manualMalfunctionIsPreservedWithoutARecordedWithdrawal() {
        let decision = AdeDeviceLifecycleDecision(event: .auditImport, currentStatus: .outOfService,
                                                  hasBeenMaster: true, hasImportedAudit: true, currentReason: .malfunction)
        #expect(!decision.updatesFiscalStatus && decision.resultingReason == .malfunction)
    }
}
