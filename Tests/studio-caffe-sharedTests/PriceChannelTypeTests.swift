import Foundation
import Testing
import studio_caffe_shared

struct PriceChannelTypeTests {
    @Test(arguments: PriceChannelType.allCases)
    func preservesThePersistenceContract(_ type: PriceChannelType) throws {
        let data = try JSONEncoder().encode(type)
        #expect(String(decoding: data, as: UTF8.self) == "\"\(type.rawValue)\"")
        #expect(try JSONDecoder().decode(PriceChannelType.self, from: data) == type)
    }

    @Test func rejectsUndefinedRawValues() {
        #expect(PriceChannelType(rawValue: "caldo") == nil)
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(PriceChannelType.self, from: Data("\"unknown\"".utf8))
        }
    }
}
