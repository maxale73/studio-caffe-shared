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
    public var installation: InstallationType
    
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
        self.installation = installation
        
        self.sellingPoint = sellingPoint
        self.model = model
        self.adeDevice = adeDevice
    }
    
    public static func == (lhs: MachineCompleteDTO, rhs: MachineCompleteDTO) -> Bool {
        return
            lhs.id == rhs.id
            && lhs.internalID == rhs.internalID
            && lhs.installation == rhs.installation
            && lhs.sellingPoint == rhs.sellingPoint
        && lhs.factoryID == rhs.factoryID
        && lhs.model == rhs.model
        && lhs.adeDevice == rhs.adeDevice
    }
    
    public static var empty: MachineCompleteDTO {
        MachineCompleteDTO(id: UUID(), internalID: 0, factoryID: "", notes: nil, installation: .deposito, sellingPoint: nil, model: .emptyModel, adeDevice: nil)
    }
}


public struct MachineDTO: Identifiable, Equatable, Hashable, Codable, RequestBody, Sendable {
    
    public var id: UUID
    public var internalID: Int = 1001
    public var factoryID: String
    public var model: MachineModelDTO
    public var notes: [String]?
    public var installation: InstallationType
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
        self.model = model
        self.installation = installation
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
            && lhs.installation == rhs.installation
            && lhs.sellingPoint == rhs.sellingPoint
        && lhs.factoryID == rhs.factoryID
        && lhs.model == rhs.model
        && lhs.adeDevice == rhs.adeDevice
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
        self.installation = installation
        self.model = model
        self.adeDevice = adeDevice
    }
    
    
    public var id: UUID
    public var internalID: Int
    public var factoryID: String
    public var notes: [String]?
    public var installation: InstallationType
    
    public var model: MachineModelDTO
    public var adeDevice: AdeDeviceDTO?
    
    public static func == (lhs: MachineBySP, rhs: MachineBySP) -> Bool {
        lhs.id == rhs.id
            && lhs.internalID == rhs.internalID
            && lhs.factoryID == rhs.factoryID
            && lhs.notes == rhs.notes
            && lhs.installation == rhs.installation
            && lhs.model == rhs.model
            && lhs.adeDevice == rhs.adeDevice
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
