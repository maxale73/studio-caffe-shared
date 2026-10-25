import Foundation
import Testing
import studio_caffe_shared

struct PriceChannelTypeUpdateTests {
    @Test func payloadContainsOnlyTheSelectedIDsAndType() throws {
        let id = UUID()
        let update = PriceChannelTypeUpdate(channelIDs: [id], type: .hot)
        let data = try #require(update.toJSONData())
        let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
        #expect(Set(json.keys) == ["channelIDs", "type"])
        #expect(try JSONDecoder().decode(PriceChannelTypeUpdate.self, from: data) == update)
        #expect(update.isValidSelection)
        #expect(!PriceChannelTypeUpdate(channelIDs: [], type: .snack).isValidSelection)
        #expect(!PriceChannelTypeUpdate(channelIDs: [id, id], type: .undefined).isValidSelection)
    }

    @Test func endpointUsesExistingDeviceConventions() {
        let id = UUID()
        let request = AdeDeviceEndpointsGroup.savePriceChannelTypes(deviceID: id,
            update: PriceChannelTypeUpdate(channelIDs: [UUID()], type: .snack))
        #expect(request.clientRoute == "adeDevice/save_price_channel_types/\(id.uuidString)/")
        #expect(request.serverRoute == ["save_price_channel_types", ":device_id"])
        #expect(request.httpMethod == .post && request.requiresToken && request.body != nil)
    }
}
