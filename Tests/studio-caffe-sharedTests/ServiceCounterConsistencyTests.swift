import Foundation
import Testing
import studio_caffe_shared

struct ServiceCounterConsistencyTests {
    @Test func acceptsFirstReadingAndReadingBetweenBounds() {
        #expect(ServiceCounterConsistency.isConsistent(counter: 0, previousMaximum: nil, nextMinimum: nil,
                                                       sameDateMinimum: nil, sameDateMaximum: nil))
        #expect(ServiceCounterConsistency.isConsistent(counter: 150, previousMaximum: 100, nextMinimum: 200,
                                                       sameDateMinimum: nil, sameDateMaximum: nil))
    }

    @Test(arguments: [99, 100, 200, 201])
    func rejectsOutOfOrderAndEqualCountersOnDifferentDates(_ counter: Int) {
        #expect(!ServiceCounterConsistency.isConsistent(counter: counter, previousMaximum: 100, nextMinimum: 200,
                                                        sameDateMinimum: nil, sameDateMaximum: nil))
    }

    @Test func sameDateRequiresMatchingEveryRecordedCounter() {
        #expect(ServiceCounterConsistency.isConsistent(counter: 150, previousMaximum: 100, nextMinimum: 200,
                                                       sameDateMinimum: 150, sameDateMaximum: 150))
        #expect(!ServiceCounterConsistency.isConsistent(counter: 150, previousMaximum: nil, nextMinimum: nil,
                                                        sameDateMinimum: 150, sameDateMaximum: 160))
        #expect(!ServiceCounterConsistency.isConsistent(counter: 150, previousMaximum: nil, nextMinimum: nil,
                                                        sameDateMinimum: 140, sameDateMaximum: 150))
    }

    @Test func confirmationFlagIsOptionalForExistingClients() throws {
        let original = ServiceToSave(id: UUID(), machineID: UUID(), catalogID: UUID(), operationType: .lavaggio,
                                     serviceDate: Date(timeIntervalSince1970: 0), counter: 100)
        let data = try JSONEncoder.scEncoder.encode(original)
        let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
        #expect(json["allowInconsistentCounter"] == nil)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        #expect(try decoder.decode(ServiceToSave.self, from: data).allowInconsistentCounter == nil)
        var confirmed = original
        confirmed.allowInconsistentCounter = true
        #expect(try decoder.decode(ServiceToSave.self, from: JSONEncoder.scEncoder.encode(confirmed)).allowInconsistentCounter == true)
    }
}
