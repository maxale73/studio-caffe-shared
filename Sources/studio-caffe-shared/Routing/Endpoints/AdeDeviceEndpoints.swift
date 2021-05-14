import Foundation

public struct AdeDeviceDTO: Codable, Equatable, Hashable, AdeDeviceType {

    public var id: UUID
    public var adeID: String
    public var qrCode: String
    public var model: AdeDeviceModel
    public var configuration: AdeDeviceConfigurationDTO

    public init(id: UUID,
         adeID: String,
         qrCode: String,
         model: AdeDeviceModel,
         configuration: AdeDeviceConfigurationDTO) {

        self.id = id
        self.adeID = adeID
        self.qrCode = qrCode
        self.model = model
        self.configuration = configuration
    }

    public static func == (lhs: AdeDeviceDTO, rhs: AdeDeviceDTO) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.adeID == rhs.adeID &&
            lhs.qrCode == rhs.qrCode &&
            lhs.model == rhs.model &&
            lhs.configuration == rhs.configuration
    }

    public static func newDevice(adeID: String, model: AdeDeviceModel ) -> AdeDeviceDTO {
        AdeDeviceDTO(id: UUID(),
                  adeID: adeID,
                  qrCode: adeID,
                  model: model,
                  configuration: AdeDeviceConfigurationDTO(id: UUID(),
                                                        coinnAcceptor: .none,
                                                        billAcceptor: .none,
                                                        appEnabled: false))
    }
}
