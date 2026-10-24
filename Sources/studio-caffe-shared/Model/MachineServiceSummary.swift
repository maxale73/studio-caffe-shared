import Foundation

public struct MachineServiceSummary: Equatable, Sendable {
    public let machineID: UUID
    public let referenceDate: Date
    public let lastReadingDate: Date?
    public let lastCounter: Int?
    public let components: [ServiceComponentSummary]

    public init(machineID: UUID, catalog: [ServiceCatalogDTO], services: [ServiceDTO], referenceDate: Date = Date()) {
        self.machineID = machineID
        self.referenceDate = referenceDate

        let history = services.filter {
            $0.machineID == machineID && $0.serviceDate <= referenceDate && $0.serviceDate.timeIntervalSince1970.isFinite
        }
        let readings = Dictionary(grouping: history.filter { $0.counter.map { $0 >= 0 } == true }, by: \.serviceDate)
            .map { date, services in (date: date, counters: Set(services.compactMap(\.counter))) }
            .sorted { $0.date < $1.date }
        lastReadingDate = readings.last?.date
        lastCounter = readings.last.flatMap { $0.counters.count == 1 ? $0.counters.first : nil }

        components = catalog.sorted {
            let comparison = $0.serviceDescription.localizedStandardCompare($1.serviceDescription)
            return comparison == .orderedSame ? $0.id.uuidString < $1.id.uuidString : comparison == .orderedAscending
        }.map { component in
            let interventions = history.filter { $0.items.contains { $0.catalog.id == component.id } }
            let lastDate = interventions.map(\.serviceDate).max()
            let latest = interventions.filter { $0.serviceDate == lastDate }
            let types = Set(latest.flatMap { $0.items.filter { $0.catalog.id == component.id }.map(\.operationType) })
            let counters = Set(latest.compactMap(\.counter).filter { $0 >= 0 })
            let counter = counters.count == 1 ? counters.first : nil
            var elapsed: Int? = counter == nil ? nil : 0
            var discontinuity = false
            var conflicting = counters.count > 1
            var previous: Int?

            for reading in readings where lastDate.map({ reading.date >= $0 }) == true {
                guard reading.counters.count == 1, let value = reading.counters.first else {
                    conflicting = true
                    elapsed = nil
                    previous = nil
                    continue
                }
                if let previous {
                    if value < previous {
                        discontinuity = true
                    } else if let total = elapsed {
                        let (sum, overflow) = total.addingReportingOverflow(value - previous)
                        elapsed = overflow ? nil : sum
                    }
                }
                previous = value
            }

            return ServiceComponentSummary(catalog: component, lastServiceDate: lastDate,
                                           operationTypes: ServiceOperationType.allCases.filter { types.contains($0) },
                                           counter: counter, elapsedCounter: conflicting ? nil : elapsed,
                                           hasCounterDiscontinuity: discontinuity, hasConflictingReadings: conflicting)
        }
    }
}
