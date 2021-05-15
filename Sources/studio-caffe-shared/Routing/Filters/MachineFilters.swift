import Foundation

extension MachineModelType: CustomRawRepresentable {}
extension InstallationType: CustomRawRepresentable {}

public struct MachineFilters: Equatable, Codable, Body {
    
    public var typeFilters: [MachineModelType]
    public var installationFilters: [InstallationType]
    public var textFilter: String
    public var modelFilters: [UUID]
    public var customerFilter: UUID?
    
    public var empty: Bool {
        typeFilters.isEmpty && installationFilters.isEmpty && textFilter.isEmpty
    }
    
    public static var emptyFilter: MachineFilters {
        MachineFilters(typeFilters: [], installationFilters: [], textFilter: "", modelFilters: [], customerFilter: nil)
    }
    
    public static func customerFilter(customerID: UUID?) -> MachineFilters {
        MachineFilters(typeFilters: [], installationFilters: [], textFilter: "", modelFilters: [], customerFilter: customerID)
    }
}
