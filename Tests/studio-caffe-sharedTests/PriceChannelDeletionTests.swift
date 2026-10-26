import Foundation
import Testing
import studio_caffe_shared

struct PriceChannelDeletionTests {
    @Test func deletionEncodesOnlyTheSelectedIDsAndRejectsAmbiguousSelections() throws {
        let first = UUID()
        let second = UUID()
        let deletion = PriceChannelDeletion(channelIDs: [first, second])
        let data = try #require(deletion.toJSONData())
        let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
        #expect(Set(json.keys) == ["channelIDs"])
        #expect(try JSONDecoder().decode(PriceChannelDeletion.self, from: data) == deletion)
        #expect(deletion.isValidSelection)
        #expect(PriceChannelDeletion(channelIDs: [first]).isValidSelection)
        #expect(!PriceChannelDeletion(channelIDs: []).isValidSelection)
        #expect(!PriceChannelDeletion(channelIDs: [first, first]).isValidSelection)
    }

    @Test func deletionEndpointUsesAuthenticatedPostAndDeviceConventions() {
        let id = UUID()
        let request = AdeDeviceEndpointsGroup.deletePriceChannels(deviceID: id,
            deletion: PriceChannelDeletion(channelIDs: [UUID()]))
        #expect(request.clientRoute == "adeDevice/delete_price_channels/\(id.uuidString)/")
        #expect(request.serverRoute == ["delete_price_channels", ":device_id"])
        #expect(request.httpMethod == .post && request.requiresToken && request.body != nil)
    }
}
