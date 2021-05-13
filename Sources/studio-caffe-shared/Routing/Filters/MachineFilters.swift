import Foundation

extension MachineModelType: CustomRawRepresentable {}
extension InstallationType: CustomRawRepresentable {}

public struct MachineFilters: Equatable, Codable, Body {
    
    public var typeFilters: [MachineModelType]
    public var installationFilters: [InstallationType]
    public var textFilter: String
    public var modelFilters: [UUID]
    
    public var empty: Bool {
        typeFilters.isEmpty && installationFilters.isEmpty && textFilter.isEmpty
    }
    
    public static var emptyFilter: MachineFilters {
        MachineFilters(typeFilters: [], installationFilters: [], textFilter: "", modelFilters: [])
    }
    
    public func filter(m: MachineDTO) -> Bool {
        var typeTest = typeFilters.isEmpty
        for f in typeFilters {
            if m.model.type == f {
                typeTest = true
            }
        }
        var installationTest = installationFilters.isEmpty
        for f in installationFilters {
            if m.installation == f {
                installationTest = true
            }
        }
        let textTest = textFilter.isEmpty || m.factoryID.lowercased().contains(textFilter.lowercased()) || String(m.internalID).lowercased().contains(textFilter.lowercased())
        
        return typeTest && installationTest && textTest
    }
}
