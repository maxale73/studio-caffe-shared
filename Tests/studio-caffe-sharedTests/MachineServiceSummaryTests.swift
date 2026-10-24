import Foundation
import Testing
import studio_caffe_shared

struct MachineServiceSummaryTests {
    private let machineID = UUID()
    private let group = ServiceCatalogDTO(id: UUID(), serviceDescription: "gruppo espresso")
    private let boiler = ServiceCatalogDTO(id: UUID(), serviceDescription: "caldaia", isActive: false)
    private let now = Date(timeIntervalSince1970: 10_000)

    private func service(_ date: TimeInterval, _ counter: Int?, component: ServiceCatalogDTO? = nil,
                         types: [ServiceOperationType] = [.lavaggio], machine: UUID? = nil) -> ServiceDTO {
        ServiceDTO(id: UUID(), machineID: machine ?? machineID,
                   items: types.map { ServiceItemDTO(id: UUID(), catalog: component ?? group, operationType: $0) },
                   serviceDate: Date(timeIntervalSince1970: date), counter: counter,
                   userID: UUID(), recordedAt: nil, note: nil, parts: [])
    }

    @Test func includesUnusedAndInactiveComponentsAndEveryLatestOperation() throws {
        let services = [service(100, 100), service(200, 250, types: [.riparazione, .lavaggio]),
                        service(300, 400, component: boiler)]
        let summary = MachineServiceSummary(machineID: machineID, catalog: [group, boiler], services: services.reversed(), referenceDate: now)
        #expect(summary.lastCounter == 400)
        #expect(summary.lastReadingDate == Date(timeIntervalSince1970: 300))
        let row = try #require(summary.components.first { $0.id == group.id })
        #expect(row.lastServiceDate == Date(timeIntervalSince1970: 200))
        #expect(row.operationTypes == [.lavaggio, .riparazione])
        #expect(row.counter == 250)
        #expect(row.elapsedCounter == 150)
        #expect(!row.hasCounterDiscontinuity)
        #expect(summary.components.first?.id == boiler.id)

        let unused = ServiceCatalogDTO(id: UUID(), serviceDescription: "compressore")
        let empty = MachineServiceSummary(machineID: machineID, catalog: [unused], services: [], referenceDate: now)
        #expect(empty.lastCounter == nil)
        #expect(empty.components.first?.lastServiceDate == nil)
        #expect(empty.components.first?.elapsedCounter == nil)
    }

    @Test func doesNotUseAnOlderCounterForAnInterventionWithoutReading() throws {
        let summary = MachineServiceSummary(machineID: machineID, catalog: [group],
                                            services: [service(100, 100), service(200, nil), service(300, 400, component: boiler)],
                                            referenceDate: now)
        let row = try #require(summary.components.first)
        #expect(row.lastServiceDate == Date(timeIntervalSince1970: 200))
        #expect(row.counter == nil)
        #expect(row.elapsedCounter == nil)
    }

    @Test func ignoresOtherMachinesFutureEventsAndNegativeReadings() throws {
        let summary = MachineServiceSummary(machineID: machineID, catalog: [group],
                                            services: [service(100, 100), service(200, -1, component: boiler),
                                                       service(300, 500, component: boiler), service(400, 900, machine: UUID()),
                                                       service(20_000, 2_000)], referenceDate: now)
        #expect(summary.lastCounter == 500)
        #expect(summary.components.first?.elapsedCounter == 400)
        #expect(summary.components.first?.lastServiceDate == Date(timeIntervalSince1970: 100))
    }

    @Test func simultaneousMatchingReadingsDoNotDuplicateProgress() throws {
        let summary = MachineServiceSummary(machineID: machineID, catalog: [group],
                                            services: [service(100, 100), service(200, 300, component: boiler),
                                                       service(200, 300, component: boiler)], referenceDate: now)
        #expect(summary.components.first?.elapsedCounter == 200)
    }

    @Test func conflictingReadingsAtTheSameInstantDoNotInventChronology() throws {
        let summary = MachineServiceSummary(machineID: machineID, catalog: [group],
                                            services: [service(100, 100), service(200, 300, component: boiler),
                                                       service(200, 500, component: boiler)], referenceDate: now)
        #expect(summary.lastReadingDate == Date(timeIntervalSince1970: 200))
        #expect(summary.lastCounter == nil)
        #expect(summary.components.first?.elapsedCounter == nil)
        #expect(summary.components.first?.hasConflictingReadings == true)
    }

    @Test(arguments: [
        ([10_000, 12_000, 500, 800], 2_300),
        ([10_000, 12_000, 500, 800, 0, 90], 2_390),
        ([10_000, 10_000, 10_000], 0)
    ])
    func sumsObservedIntervalsAcrossCounterReplacements(_ counters: [Int], _ expected: Int) throws {
        let services = counters.enumerated().map { index, counter in
            service(Double(index + 1) * 100, counter, component: index == 0 ? group : boiler)
        }
        let summary = MachineServiceSummary(machineID: machineID, catalog: [group], services: services.reversed(), referenceDate: now)
        let row = try #require(summary.components.first)
        #expect(row.elapsedCounter == expected)
        #expect(row.hasCounterDiscontinuity == counters.contains { $0 < counters[0] })
        #expect(!row.hasConflictingReadings)
        #expect(summary.lastCounter == counters.last)
    }

    @Test func olderResetsDoNotAffectTheLatestComponentIntervention() throws {
        let summary = MachineServiceSummary(machineID: machineID, catalog: [group],
                                            services: [service(100, 10_000), service(200, 500, component: boiler),
                                                       service(300, 1_000), service(400, 1_500, component: boiler)], referenceDate: now)
        #expect(summary.components.first?.elapsedCounter == 500)
        #expect(summary.components.first?.hasCounterDiscontinuity == false)
    }

    @Test func reportsUnavailableCountsInsteadOfOverflowing() throws {
        let summary = MachineServiceSummary(machineID: machineID, catalog: [group],
                                            services: [service(100, 0), service(200, Int.max, component: boiler),
                                                       service(300, 0, component: boiler), service(400, 1, component: boiler)], referenceDate: now)
        #expect(summary.components.first?.elapsedCounter == nil)
        #expect(summary.components.first?.hasCounterDiscontinuity == true)
    }

}
