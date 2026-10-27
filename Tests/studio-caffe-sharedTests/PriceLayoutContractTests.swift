import Foundation
import Testing
import studio_caffe_shared

struct PriceLayoutContractTests {
    @Test func roundTripsExactAmountsAndOptionalLayouts() throws {
        let deviceID = UUID()
        let channel = PriceChannelDTO(index: 7, type: .hot, price1: Decimal(string: "1.20")!,
                                      price2: Decimal(string: "0.35"), description: "Caffè", machineSectorCode: "x11")
        let response = PriceLayoutResponse(adeDeviceID: deviceID,
            layout: .init(id: UUID(), adeDeviceID: deviceID, channels: [channel], createdAt: Date(timeIntervalSince1970: 1000)))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        for value in [response, PriceLayoutResponse(adeDeviceID: deviceID)] {
            #expect(try decoder.decode(PriceLayoutResponse.self, from: JSONEncoder.scEncoder.encode(value)) == value)
        }
        #expect(channel.validationMessage == nil)
        #expect(PriceChannelDTO(index: 1, price1: 0).validationMessage == nil)
    }

    @Test(arguments: [Decimal(-1), Decimal(string: "0.001")!, Decimal(100_000_000), Decimal.nan])
    func rejectsPricesThatWouldBeRoundedOrCannotBeStored(_ price: Decimal) {
        #expect(PriceChannelDTO(index: 1, price1: price).validationMessage != nil)
        #expect(PriceChannelDTO(index: 1, price1: 1, price2: price).validationMessage != nil)
    }

    @Test func followsExistingDeviceEndpointConventions() {
        let id = UUID()
        let find = AdeDeviceEndpointsGroup.findPriceLayout(deviceID: id)
        let save = AdeDeviceEndpointsGroup.savePriceChannel(deviceID: id, channel: PriceChannelDTO(index: 1, price1: 1))
        #expect(find.clientRoute == "adeDevice/find_price_layout/\(id.uuidString)/")
        #expect(find.serverRoute == ["find_price_layout", ":device_id"])
        #expect(find.httpMethod == .get && find.requiresToken && !find.allowsCaching)
        #expect(save.clientRoute == "adeDevice/save_price_channel/\(id.uuidString)/")
        #expect(save.serverRoute == ["save_price_channel", ":device_id"])
        #expect(save.httpMethod == .post && save.requiresToken && save.body != nil)
        #expect(PriceChannelDTO(index: 0, price1: 1).validationMessage != nil)
    }
}
