import Foundation

public struct CustomerByMachine: Codable, Hashable, Identifiable, Equatable, Sendable {
    public var id: UUID
    public var businessName: String
    public var alias: String?
}

public struct AddressByMachine: Codable, Hashable, Identifiable, Equatable, Sendable {
    
    public init(id: UUID, address1: String, address2: String? = nil, city: String, province: String, postalCode: String, isLegalAddress: Bool, customer: CustomerName) {
        self.id = id
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.province = province
        self.postalCode = postalCode
        self.isLegalAddress = isLegalAddress
        self.customer = customer
    }
    
    public var id: UUID
    public var address1: String
    public var address2: String?
    public var city: String
    public var province: String
    public var postalCode: String
    public var isLegalAddress: Bool
    public var customer: CustomerName
    
    public static func == (lhs: AddressByMachine, rhs: AddressByMachine) -> Bool {
        return
            lhs.id == rhs.id
            && lhs.address1 == rhs.address1
            && lhs.address2 == rhs.address2
            && lhs.city == rhs.city
            && lhs.province == rhs.province
            && lhs.postalCode == rhs.postalCode
            && lhs.isLegalAddress == rhs.isLegalAddress
            && lhs.customer == rhs.customer
    }
    
    public var toCopyAddress: String {
        self.address1 + ", " + city + " (\(province))"
    }
    
    public var twoLinesAddress: String {
        var address: String {
            let address2String = address2 ?? ""
            return self.address1 + address2String
        }
        
        return "\(address) - \(city)"
    }
    
    public var addressTypeDescription: String {
        if isLegalAddress {
            return "sede legale"
        } else {
            return "sede operativa"
        }
    }
    
    public var capElementDescription: String {
        "\(city)(\(province))"
    }
}

public struct SellingPointBM: Codable, Hashable, Identifiable, Equatable, Sendable {
    
    public init(id: UUID, sellingPointID: Int, site: String, address: AddressByMachine) {
        self.id = id
        self.sellingPointID = sellingPointID
        self.site = site
        self.address = address
    }
    
    
    public var id: UUID
    public var sellingPointID: Int
    public var site: String
    public var address: AddressByMachine
}

public struct MachineCompleteDTO: Codable, Hashable, Identifiable, Equatable, Sendable {
    
    public var id: UUID
    public var internalID: Int
    public var factoryID: String
    public var notes: [String]?
    public var state: MachineState
    public var installationRole: InstallationRole?
    public var installation: InstallationType {
        get { InstallationType(state: state, installationRole: installationRole) }
        set { state = newValue.machineState; installationRole = newValue.installationRole }
    }
    
    public var model: MachineModelDTO
    public var sellingPoint: SellingPointBM?
    public var adeDevice: AdeDeviceDTO?

    public init(id: UUID,
         internalID: Int,
         factoryID: String,
         notes: [String]?,
         installation: InstallationType,
         
         sellingPoint: SellingPointBM?,
         model: MachineModelDTO,
         adeDevice: AdeDeviceDTO?)
    {
        
        self.id = id
        self.internalID = internalID
        self.factoryID = factoryID
        self.notes = notes
        self.state = installation.machineState
        self.installationRole = installation.installationRole
        
        self.sellingPoint = sellingPoint
        self.model = model
        self.adeDevice = adeDevice
    }
    
    public static func == (lhs: MachineCompleteDTO, rhs: MachineCompleteDTO) -> Bool {
        return
            lhs.id == rhs.id
            && lhs.internalID == rhs.internalID
            && lhs.state == rhs.state && lhs.installationRole == rhs.installationRole
            && lhs.sellingPoint == rhs.sellingPoint
        && lhs.factoryID == rhs.factoryID
        && lhs.model == rhs.model
        && lhs.adeDevice == rhs.adeDevice
    }
    
    public static var empty: MachineCompleteDTO {
        MachineCompleteDTO(id: UUID(), internalID: 0, factoryID: "", notes: nil, installation: .deposito, sellingPoint: nil, model: .emptyModel, adeDevice: nil)
    }

    public init(id: UUID, internalID: Int, factoryID: String, notes: [String]?, state: MachineState, installationRole: InstallationRole? = nil, model: MachineModelDTO, sellingPoint: SellingPointBM?, adeDevice: AdeDeviceDTO?) {
        self.id = id
        self.internalID = internalID
        self.factoryID = factoryID
        self.notes = notes
        self.state = state
        self.installationRole = installationRole
        self.model = model
        self.sellingPoint = sellingPoint
        self.adeDevice = adeDevice
    }

    private enum CodingKeys: String, CodingKey {
        case id, internalID, factoryID, notes, state, installationRole, model, sellingPoint, adeDevice, installation
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        (state, installationRole) = try container.machineState(stateKey: .state, roleKey: .installationRole, legacyKey: .installation)
        id = try container.decode(UUID.self, forKey: .id)
        internalID = try container.decode(Int.self, forKey: .internalID)
        factoryID = try container.decode(String.self, forKey: .factoryID)
        notes = try container.decodeIfPresent([String].self, forKey: .notes)
        model = try container.decode(MachineModelDTO.self, forKey: .model)
        sellingPoint = try container.decodeIfPresent(SellingPointBM.self, forKey: .sellingPoint)
        adeDevice = try container.decodeIfPresent(AdeDeviceDTO.self, forKey: .adeDevice)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(internalID, forKey: .internalID)
        try container.encode(factoryID, forKey: .factoryID)
        try container.encodeIfPresent(notes, forKey: .notes)
        try container.encode(state, forKey: .state)
        try container.encodeIfPresent(installationRole, forKey: .installationRole)
        try container.encode(model, forKey: .model)
        try container.encodeIfPresent(sellingPoint, forKey: .sellingPoint)
        try container.encodeIfPresent(adeDevice, forKey: .adeDevice)
        try container.encode(InstallationType(state: state, installationRole: installationRole), forKey: .installation)
    }
}


public struct MachineByDeviceDTO: Codable, Hashable, Identifiable, Equatable, Sendable {

    public var id: UUID
    public var internalID: Int
    public var factoryID: String
    public var notes: [String]?
    public var state: MachineState
    public var installationRole: InstallationRole?
    public var installation: InstallationType {
        get { InstallationType(state: state, installationRole: installationRole) }
        set { state = newValue.machineState; installationRole = newValue.installationRole }
    }

    public var model: MachineModelDTO
    public var sellingPoint: SellingPointBM?

    public init(id: UUID, internalID: Int, factoryID: String, notes: [String]?, installation: InstallationType,
                model: MachineModelDTO, sellingPoint: SellingPointBM?) {
        self.init(id: id, internalID: internalID, factoryID: factoryID, notes: notes,
                  state: installation.machineState, installationRole: installation.installationRole,
                  model: model, sellingPoint: sellingPoint)
    }

    public init(id: UUID, internalID: Int, factoryID: String, notes: [String]?, state: MachineState, installationRole: InstallationRole? = nil, model: MachineModelDTO, sellingPoint: SellingPointBM?) {
        self.id = id
        self.internalID = internalID
        self.factoryID = factoryID
        self.notes = notes
        self.state = state
        self.installationRole = installationRole
        self.model = model
        self.sellingPoint = sellingPoint
    }

    private enum CodingKeys: String, CodingKey {
        case id, internalID, factoryID, notes, state, installationRole, model, sellingPoint, installation
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        (state, installationRole) = try container.machineState(stateKey: .state, roleKey: .installationRole, legacyKey: .installation)
        id = try container.decode(UUID.self, forKey: .id)
        internalID = try container.decode(Int.self, forKey: .internalID)
        factoryID = try container.decode(String.self, forKey: .factoryID)
        notes = try container.decodeIfPresent([String].self, forKey: .notes)
        model = try container.decode(MachineModelDTO.self, forKey: .model)
        sellingPoint = try container.decodeIfPresent(SellingPointBM.self, forKey: .sellingPoint)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(internalID, forKey: .internalID)
        try container.encode(factoryID, forKey: .factoryID)
        try container.encodeIfPresent(notes, forKey: .notes)
        try container.encode(state, forKey: .state)
        try container.encodeIfPresent(installationRole, forKey: .installationRole)
        try container.encode(model, forKey: .model)
        try container.encodeIfPresent(sellingPoint, forKey: .sellingPoint)
        try container.encode(InstallationType(state: state, installationRole: installationRole), forKey: .installation)
    }
}


public struct MachineDTO: Identifiable, Equatable, Hashable, Codable, RequestBody, Sendable {
    
    public var id: UUID
    public var internalID: Int = 1001
    public var factoryID: String
    public var model: MachineModelDTO
    public var notes: [String]?
    public var state: MachineState
    public var installationRole: InstallationRole?
    public var installation: InstallationType {
        get { InstallationType(state: state, installationRole: installationRole) }
        set { state = newValue.machineState; installationRole = newValue.installationRole }
    }
    public var sellingPoint: UUID?
    public var adeDevice: UUID?
    
    public init(
        id: UUID,
        internalID: Int,
        factoryID: String,
        model: MachineModelDTO,
        notes: [String]?,
        installation: InstallationType,
        sellingPoint: UUID?,
        adeDevice: UUID?
    ) {
        self.id = id
        self.internalID = internalID
        self.factoryID = factoryID
        self.notes = notes
        self.model = model
        self.state = installation.machineState
        self.installationRole = installation.installationRole
        self.sellingPoint = sellingPoint
        self.adeDevice = adeDevice
    }
    
    public static func new() -> MachineDTO {
        MachineDTO(id: UUID(), internalID: 0, factoryID: "", model: .emptyModel, notes: nil, installation: .deposito, sellingPoint: nil, adeDevice: nil)
    }
    
    public static func == (lhs: MachineDTO, rhs: MachineDTO) -> Bool {
        return
            lhs.id == rhs.id
            && lhs.internalID == rhs.internalID
            && lhs.state == rhs.state && lhs.installationRole == rhs.installationRole
            && lhs.sellingPoint == rhs.sellingPoint
        && lhs.factoryID == rhs.factoryID
        && lhs.model == rhs.model
        && lhs.adeDevice == rhs.adeDevice
    }

    public init(id: UUID, internalID: Int, factoryID: String, model: MachineModelDTO, notes: [String]?, state: MachineState, installationRole: InstallationRole? = nil, sellingPoint: UUID?, adeDevice: UUID?) {
        self.id = id
        self.internalID = internalID
        self.factoryID = factoryID
        self.model = model
        self.notes = notes
        self.state = state
        self.installationRole = installationRole
        self.sellingPoint = sellingPoint
        self.adeDevice = adeDevice
    }

    private enum CodingKeys: String, CodingKey {
        case id, internalID, factoryID, model, notes, state, installationRole, sellingPoint, adeDevice, installation
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        (state, installationRole) = try container.machineState(stateKey: .state, roleKey: .installationRole, legacyKey: .installation)
        id = try container.decode(UUID.self, forKey: .id)
        internalID = try container.decode(Int.self, forKey: .internalID)
        factoryID = try container.decode(String.self, forKey: .factoryID)
        model = try container.decode(MachineModelDTO.self, forKey: .model)
        notes = try container.decodeIfPresent([String].self, forKey: .notes)
        sellingPoint = try container.decodeIfPresent(UUID.self, forKey: .sellingPoint)
        adeDevice = try container.decodeIfPresent(UUID.self, forKey: .adeDevice)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(internalID, forKey: .internalID)
        try container.encode(factoryID, forKey: .factoryID)
        try container.encode(model, forKey: .model)
        try container.encodeIfPresent(notes, forKey: .notes)
        try container.encode(state, forKey: .state)
        try container.encodeIfPresent(installationRole, forKey: .installationRole)
        try container.encodeIfPresent(sellingPoint, forKey: .sellingPoint)
        try container.encodeIfPresent(adeDevice, forKey: .adeDevice)
        try container.encode(InstallationType(state: state, installationRole: installationRole), forKey: .installation)
    }
}

public struct FilteredMachineDTO: Equatable, Identifiable, Hashable, Codable, Sendable {
    
    public var id: UUID
    public var internalID: Int
    public var factoryID: String
    public var model: MachineModelDTO
    
    public init(machine: MachineDTO) {
        self.id = machine.id
        self.internalID = machine.internalID
        self.factoryID = machine.factoryID
        self.model = machine.model
    }
    
    public init(id: UUID, internalID: Int, factoryID: String, model: MachineModelDTO) {
        self.id = id
        self.internalID = internalID
        self.factoryID = factoryID
        self.model = model
    }
}

public struct MachineBySP: Codable, Hashable, Identifiable, Sendable {
    public init(id: UUID, internalID: Int, factoryID: String, notes: [String]? = nil, installation: InstallationType, model: MachineModelDTO, adeDevice: AdeDeviceDTO? = nil) {
        self.id = id
        self.internalID = internalID
        self.factoryID = factoryID
        self.notes = notes
        self.state = installation.machineState
        self.installationRole = installation.installationRole
        self.model = model
        self.adeDevice = adeDevice
    }
    
    
    public var id: UUID
    public var internalID: Int
    public var factoryID: String
    public var notes: [String]?
    public var state: MachineState
    public var installationRole: InstallationRole?
    public var installation: InstallationType {
        get { InstallationType(state: state, installationRole: installationRole) }
        set { state = newValue.machineState; installationRole = newValue.installationRole }
    }
    
    public var model: MachineModelDTO
    public var adeDevice: AdeDeviceDTO?
    
    public static func == (lhs: MachineBySP, rhs: MachineBySP) -> Bool {
        lhs.id == rhs.id
            && lhs.internalID == rhs.internalID
            && lhs.factoryID == rhs.factoryID
            && lhs.notes == rhs.notes
            && lhs.state == rhs.state && lhs.installationRole == rhs.installationRole
            && lhs.model == rhs.model
            && lhs.adeDevice == rhs.adeDevice
    }

    public init(id: UUID, internalID: Int, factoryID: String, notes: [String]?, state: MachineState, installationRole: InstallationRole? = nil, model: MachineModelDTO, adeDevice: AdeDeviceDTO?) {
        self.id = id
        self.internalID = internalID
        self.factoryID = factoryID
        self.notes = notes
        self.state = state
        self.installationRole = installationRole
        self.model = model
        self.adeDevice = adeDevice
    }

    private enum CodingKeys: String, CodingKey {
        case id, internalID, factoryID, notes, state, installationRole, model, adeDevice, installation
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        (state, installationRole) = try container.machineState(stateKey: .state, roleKey: .installationRole, legacyKey: .installation)
        id = try container.decode(UUID.self, forKey: .id)
        internalID = try container.decode(Int.self, forKey: .internalID)
        factoryID = try container.decode(String.self, forKey: .factoryID)
        notes = try container.decodeIfPresent([String].self, forKey: .notes)
        model = try container.decode(MachineModelDTO.self, forKey: .model)
        adeDevice = try container.decodeIfPresent(AdeDeviceDTO.self, forKey: .adeDevice)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(internalID, forKey: .internalID)
        try container.encode(factoryID, forKey: .factoryID)
        try container.encodeIfPresent(notes, forKey: .notes)
        try container.encode(state, forKey: .state)
        try container.encodeIfPresent(installationRole, forKey: .installationRole)
        try container.encode(model, forKey: .model)
        try container.encodeIfPresent(adeDevice, forKey: .adeDevice)
        try container.encode(InstallationType(state: state, installationRole: installationRole), forKey: .installation)
    }
}

public struct MachineAsset: Codable, Hashable, Sendable {
    
    public init(buyDocument: AssetsDocumentDTO? = nil, sellDocument: AssetsDocumentDTO? = nil, buyPrice: Double? = nil, sellPrice: Double? = nil, note: String? = nil) {
        self.buyDocument = buyDocument
        self.sellDocument = sellDocument
        self.buyPrice = buyPrice
        self.sellPrice = sellPrice
        self.note = note
    }
    
    public var buyDocument: AssetsDocumentDTO?
    public var sellDocument: AssetsDocumentDTO?
    public var buyPrice: Double?
    public var sellPrice: Double?
    public var note: String?
}

public struct MachineWithAsset: Identifiable, Codable, Equatable, Hashable, Sendable {
    
    public init(machine: FilteredMachineDTO, asset: MachineAsset? = nil) {
        self.machine = machine
        self.asset = asset
    }
    
    public var id: UUID { machine.id }
    public var machine: FilteredMachineDTO
    public var asset: MachineAsset?
}

public struct MachineEndpointsGroup: EndpointGroupType {
    
    public static var group: String { "machine" }
    
    public static func save(machine: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: machine)
    }
    
    public static func indexWithFilter(filter: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index_with_filter", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
    
    public static func indexUninstalled() -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index_uninstalled", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func saveBySP(machineBySP: RequestBody? = nil, sellingPointID: UUID? = nil, updateHistory: Bool? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save_by_sp", value: nil),
            PathParameter(name: "selling_point_id", value: .uuid(sellingPointID)),
            PathParameter(name: "update_history", value: .bool(updateHistory))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: machineBySP)
    }
    
    public static func finfComplete(id: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "find_complete", value: nil),
            PathParameter(name: "id", value: .uuid(id))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func findIn(ids: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "find_in", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: ids)
    }
    
    public static func uninstall(sellingPointID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "uninstall", value: nil),
            PathParameter(name: "selling_point_id", value: .uuid(sellingPointID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post)
    }
    
    public static func fetchAsset(machineID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "fetch_asset", value: nil),
            PathParameter(name: "machine_id", value: .uuid(machineID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
    
    public static func indexWithAssets(filter: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index_with_assets", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
}
