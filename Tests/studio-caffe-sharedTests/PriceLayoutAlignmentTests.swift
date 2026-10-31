import Foundation
import Testing
@testable import studio_caffe_shared

struct PriceLayoutAlignmentTests {
    @Test(arguments: PriceLayoutAlignmentMode.allCases)
    func roundTripsAlignmentRequests(_ mode: PriceLayoutAlignmentMode) throws {
        let request = PriceLayoutAlignmentRequest(
            rawAudit: "LA1*0*1*100*1",
            expectedLayoutID: UUID(),
            expectedUpdatedAt: Date(timeIntervalSince1970: 1_800_000_000),
            mode: mode
        )

        let data = try JSONEncoder.scEncoder.encode(request)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        #expect(try decoder.decode(PriceLayoutAlignmentRequest.self, from: data) == request)
    }

    @Test func buildsAlignmentEndpoint() {
        let deviceID = UUID()
        let request = AdeDeviceEndpointsGroup.alignPriceLayout(
            deviceID: deviceID,
            alignment: PriceLayoutAlignmentRequest(
                rawAudit: "LA1*0*1*100*1",
                expectedLayoutID: nil,
                expectedUpdatedAt: nil,
                mode: .updateAndAdd
            )
        )

        #expect(request.clientRoute == "adeDevice/align_price_layout/\(deviceID.uuidString)/")
        #expect(request.serverRoute == ["align_price_layout", ":device_id"])
        #expect(request.httpMethod == .post && request.requiresToken && request.body != nil)
    }
}
