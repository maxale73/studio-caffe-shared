import Foundation
import Testing
import studio_caffe_shared

struct RistornoReportReadingTests {
    @Test func roundTripPreservesSellingPointAndLegacyFields() throws {
        let reading = RistornoReportReading(
            id: UUID(), erogazioni: 123, machineID: 42, machineModel: "Model",
            site: "Reception", readingDate: Date(timeIntervalSince1970: 0),
            sellingPointID: UUID(), sellingPointCode: 17, sellingPointAddress: "Via Roma, Roma"
        )
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(reading)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        #expect(try decoder.decode(RistornoReportReading.self, from: data) == reading)
        let legacy = try decoder.decode(ReportByRistorno.self, from: data)
        #expect(legacy.id == reading.id)
        #expect(legacy.erogazioni == reading.erogazioni)
        #expect(legacy.machineID == reading.machineID)
        #expect(legacy.machineModel == reading.machineModel)
        #expect(legacy.site == reading.site)
        #expect(legacy.readingDate == reading.readingDate)
    }
}
