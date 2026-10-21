import Foundation

extension MachineModelType: CustomRawRepresentable {}
extension InstallationType: CustomRawRepresentable {}

public struct MachineFilters: Equatable, Codable, RequestBody, Sendable {
    
    public var typeFilters: [MachineModelType]
    public var installationFilters: [InstallationType]
    public var stateFilters: [MachineState]
    public var roleFilters: [InstallationRole]
    public var textFilter: String
    public var modelFilters: [UUID]
    public var customerFilter: UUID?
    
    public var empty: Bool {
        typeFilters.isEmpty && installationFilters.isEmpty && stateFilters.isEmpty && roleFilters.isEmpty && textFilter.isEmpty
    }

    public init(typeFilters: [MachineModelType] = [], installationFilters: [InstallationType] = [],
                textFilter: String = "", modelFilters: [UUID] = [], customerFilter: UUID? = nil,
                stateFilters: [MachineState] = [], roleFilters: [InstallationRole] = []) {
        self.typeFilters = typeFilters
        self.installationFilters = installationFilters
        self.stateFilters = stateFilters
        self.roleFilters = roleFilters
        self.textFilter = textFilter
        self.modelFilters = modelFilters
        self.customerFilter = customerFilter
    }

    private enum CodingKeys: String, CodingKey {
        case typeFilters, installationFilters, stateFilters, roleFilters, textFilter, modelFilters, customerFilter
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(typeFilters: try container.decodeIfPresent([MachineModelType].self, forKey: .typeFilters) ?? [],
                  installationFilters: try container.decodeIfPresent([InstallationType].self, forKey: .installationFilters) ?? [],
                  textFilter: try container.decodeIfPresent(String.self, forKey: .textFilter) ?? "",
                  modelFilters: try container.decodeIfPresent([UUID].self, forKey: .modelFilters) ?? [],
                  customerFilter: try container.decodeIfPresent(UUID.self, forKey: .customerFilter),
                  stateFilters: try container.decodeIfPresent([MachineState].self, forKey: .stateFilters) ?? [],
                  roleFilters: try container.decodeIfPresent([InstallationRole].self, forKey: .roleFilters) ?? [])
    }
    
    public static var emptyFilter: MachineFilters {
        MachineFilters(typeFilters: [], installationFilters: [], textFilter: "", modelFilters: [], customerFilter: nil)
    }
    
    public static func customerFilter(customerID: UUID?) -> MachineFilters {
        MachineFilters(typeFilters: [], installationFilters: [], textFilter: "", modelFilters: [], customerFilter: customerID)
    }
}
