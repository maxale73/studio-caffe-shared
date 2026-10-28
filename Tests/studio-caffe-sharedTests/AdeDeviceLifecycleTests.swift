import Foundation
import Testing
@testable import studio_caffe_shared

struct AdeDeviceLifecycleTests {
    @Test func warehouseReturnAndNextAuditStartANewServicePeriod() {
        let withdrawal = AdeDeviceLifecycleDecision(event: .warehouseReturn, currentStatus: .inService,
                                                    hasBeenMaster: true, hasImportedAudit: true)
        #expect(withdrawal.updatesFiscalStatus && !withdrawal.isInconsistent)
        #expect(withdrawal.resultingStatus == .outOfService && withdrawal.resultingReason == .warehouse)
        let reinstallation = AdeDeviceLifecycleDecision(event: .masterAssociation, currentStatus: .outOfService,
                                                        hasBeenMaster: true, hasImportedAudit: true, currentReason: .warehouse)
        #expect(!reinstallation.updatesFiscalStatus && !reinstallation.isInconsistent)
        let audit = AdeDeviceLifecycleDecision(event: .auditImport, currentStatus: .outOfService,
                                               hasBeenMaster: true, hasImportedAudit: true, currentReason: .warehouse)
        #expect(audit.updatesFiscalStatus && !audit.isInconsistent)
        #expect(audit.resultingStatus == .inService && audit.resultingReason == nil)
    }

    @Test(arguments: [nil] + AdeDeviceFiscalStatus.allCases.map(Optional.some))
    func firstEventsOverrideEveryStatusAndReportInconsistencies(_ status: AdeDeviceFiscalStatus?) {
        let association = AdeDeviceLifecycleDecision(event: .masterAssociation, currentStatus: status,
                                                     hasBeenMaster: false, hasImportedAudit: false)
        #expect(association.isFirstEvent)
        #expect(association.resultingStatus == .activated)
        #expect(association.isInconsistent == (status != nil))
        let audit = AdeDeviceLifecycleDecision(event: .auditImport, currentStatus: status,
                                               hasBeenMaster: true, hasImportedAudit: false)
        #expect(audit.isFirstEvent)
        #expect(audit.resultingStatus == .inService)
        #expect(audit.isInconsistent == (status != .activated))
        #expect((audit.alertMessage(adeID: "TEST") != nil) == audit.isInconsistent)
    }

    @Test(arguments: [nil] + AdeDeviceFiscalStatus.allCases.map(Optional.some))
    func repeatedEventsPreserveManualStatusAndStillWarn(_ status: AdeDeviceFiscalStatus?) {
        for event in [AdeDeviceLifecycleEvent.masterAssociation, .auditImport] {
            let decision = AdeDeviceLifecycleDecision(event: event, currentStatus: status,
                                                      hasBeenMaster: true, hasImportedAudit: true)
            #expect(!decision.isFirstEvent)
            #expect(decision.resultingStatus == status)
            #expect(decision.isInconsistent == (status != .inService))
        }
        let association = AdeDeviceLifecycleDecision(event: .masterAssociation, currentStatus: status,
                                                     hasBeenMaster: true, hasImportedAudit: false)
        #expect(association.resultingStatus == status)
        #expect(association.isInconsistent == (status != .activated))
    }

    @Test func alertsRoundTripAndBoundTheHeaderForLargeImports() throws {
        let alerts = AdeDeviceLifecycleAlerts(messages: (0..<20).map { "Dispositivo \($0): stato non coerente." })
        #expect(alerts.messages.count == 4)
        #expect(alerts.additionalCount == 16)
        #expect(alerts.message.contains("Altri 16"))
        #expect(AdeDeviceLifecycleAlerts(headerValue: try alerts.headerValue()) == alerts)
        #expect(AdeDeviceLifecycleAlerts(headerValue: nil) == nil)
        #expect(AdeDeviceLifecycleAlerts(headerValue: "invalid") == nil)
        #expect(AdeDeviceLifecycleAlerts(headerValue: try AdeDeviceLifecycleAlerts(messages: []).headerValue()) == nil)
    }
}
