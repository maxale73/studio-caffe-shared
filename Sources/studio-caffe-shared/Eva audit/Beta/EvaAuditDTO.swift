import Foundation

public struct EvaAuditDTO: Identifiable, Hashable, Codable {
    public init(id: UUID, deviceId: String, machineId: Int, progressivoLettura: Int, dataLettura: Date, dataLetturaPrecedente: Date, sellingPoint: IDType) {
        
        self.id = id
        self.deviceId = deviceId
        self.machineId = machineId
        self.progressivoLettura = progressivoLettura
        self.dataLettura = dataLettura
        self.dataLetturaPrecedente = dataLetturaPrecedente
        
        self.sellingPoint = sellingPoint
    }
    
    public var id: UUID
    
    public var deviceId: String
    public var machineId: Int
    public var progressivoLettura: Int
    public var dataLettura: Date
    public var dataLetturaPrecedente: Date
    
    public var sellingPoint: IDType
    
    public func fileName() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyyMMdd@HHmmss"
        return "\(df.string(from: dataLettura))_\(progressivoLettura.textDescription)_\(deviceId)"
    }
}
