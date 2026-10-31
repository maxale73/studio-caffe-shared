import Foundation
import Testing
@testable import studio_caffe_shared

struct PriceLayoutAlignmentTests {
    @Test(arguments: PriceLayoutAlignmentMode.allCases)
    func roundTripsAlignmentRequests(_ mode: PriceLayoutAlignmentMode) throws {
        let request = PriceLayoutAlignmentRequest(
            rawAudit: "LA1*0*1*100*1",
            expectedLayoutID: UUID(),
            expectedChannels: [.init(index: 1, price1: 1)],
            mode: mode
        )

        let data = try JSONEncoder.scEncoder.encode(request)

        #expect(try JSONDecoder().decode(PriceLayoutAlignmentRequest.self, from: data) == request)
    }

    @Test func buildsAlignmentEndpoint() {
        let deviceID = UUID()
        let request = AdeDeviceEndpointsGroup.alignPriceLayout(
            deviceID: deviceID,
            alignment: PriceLayoutAlignmentRequest(
                rawAudit: "LA1*0*1*100*1",
                expectedLayoutID: nil,
                expectedChannels: nil,
                mode: .updateAndAdd
            )
        )

        #expect(request.clientRoute == "adeDevice/align_price_layout/\(deviceID.uuidString)/")
        #expect(request.serverRoute == ["align_price_layout", ":device_id"])
        #expect(request.httpMethod == .post && request.requiresToken && request.body != nil)
    }
}
