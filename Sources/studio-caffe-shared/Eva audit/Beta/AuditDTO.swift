import Foundation

public struct AuditDTO: ResettedAuditValuesType, Identifiable {
    public init(id: UUID,
                
                deviceId: String,
                detectedDeviceModel: AdeDeviceModel,
                machineId: Int,
                progressivoLettura: Int,
                dataLettura: Date,
                dataLetturaPrecedente: Date,
                
                sellingPoint: IDType,
                
                erogazioni: Int,
                venduto: Double,
                cashBox: Double,
                tally: Double? = nil,
                
                importoVendutoCash_CA2_03: Double? = nil,
                numeroVenditeCash_CA2_04: Int? = nil,
                totaleCashInserito_CA3_01: Double? = nil,
                moneteInCassetta_CA3_02: Double? = nil,
                moneteVersoTubi_CA3_03: Double? = nil,
                banconoteInCassetta_CA3_04: Double? = nil,
                banconoteInCassetta_CA3_09: Double? = nil,
                totaleScaricoTubi_CA4_01: Double? = nil,
                scaricoTubiSoloManuale_CA4_02: Double? = nil,
                cashOverpay_CA8_01: Double? = nil,
                caricoManualeTubi_CA10_01: Double? = nil,
                valoreTotaleTubi_CA15_01: Double? = nil,
                numeroVendite_LA1_04: Int? = nil,
                importoVendutoCashless1_DA2_03: Double? = nil,
                erogazioniCashless1_DA2_04: Int? = nil,
                importoPrelevatoDaCashless1_DA3_02: Double? = nil,
                importoAccreditatoSuCashless1_DA4_02: Double? = nil,
                importoScontiCashless1_DA5_01: Double? = nil,
                erogazioniScontateCashless1_DA5_02: Int? = nil,
                bonusAccreditatoSuCashless1_DA6_02: Double? = nil,
                importoVendutoCashless2_DB2_03: Double? = nil,
                erogazioniCashless2_DB2_04: Int? = nil,
                importoPrelevatoDaCashless2_DB3_02: Double? = nil,
                importoAccreditatoSuCashless2_DB4_02: Double? = nil,
                importoScontiCashless2_DB5_01: Double? = nil,
                erogazioniScontateCashless2_DB5_02: Int? = nil,
                bonusAccreditatoSuCashless2_DB6_02: Double? = nil,
                venduto_VA1_03: Double? = nil,
                erogazioni_VA1_04: Int? = nil,
                valoreScontato_VA1_07: Double? = nil,
                erogazioniScontate_VA1_08: Int? = nil,
                valoreProve_VA2_03: Double? = nil,
                erogazioniProva_VA2_04: Int? = nil,
                valoreErogazioniGratuite_VA3_03: Double? = nil,
                erogazioniGratuite_VA3_04: Int? = nil) {
        
        self.id = id
        
        self.deviceId = deviceId
        self.detectedDeviceModel = detectedDeviceModel
        self.machineId = machineId
        self.progressivoLettura = progressivoLettura
        self.dataLettura = dataLettura
        self.dataLetturaPrecedente = dataLetturaPrecedente
        
        self.sellingPoint = sellingPoint
        
        self.erogazioni = erogazioni
        self.venduto = venduto
        self.cashBox = cashBox
        self.tally = tally
        
        self.importoVendutoCash_CA2_03 = importoVendutoCash_CA2_03
        self.numeroVenditeCash_CA2_04 = numeroVenditeCash_CA2_04
        self.totaleCashInserito_CA3_01 = totaleCashInserito_CA3_01
        self.moneteInCassetta_CA3_02 = moneteInCassetta_CA3_02
        self.moneteVersoTubi_CA3_03 = moneteVersoTubi_CA3_03
        self.banconoteInCassetta_CA3_04 = banconoteInCassetta_CA3_04
        self.banconoteInCassetta_CA3_09 = banconoteInCassetta_CA3_09
        self.totaleScaricoTubi_CA4_01 = totaleScaricoTubi_CA4_01
        self.scaricoTubiSoloManuale_CA4_02 = scaricoTubiSoloManuale_CA4_02
        self.cashOverpay_CA8_01 = cashOverpay_CA8_01
        self.caricoManualeTubi_CA10_01 = caricoManualeTubi_CA10_01
        self.valoreTotaleTubi_CA15_01 = valoreTotaleTubi_CA15_01
        self.numeroVendite_LA1_04 = numeroVendite_LA1_04
        self.importoVendutoCashless1_DA2_03 = importoVendutoCashless1_DA2_03
        self.erogazioniCashless1_DA2_04 = erogazioniCashless1_DA2_04
        self.importoPrelevatoDaCashless1_DA3_02 = importoPrelevatoDaCashless1_DA3_02
        self.importoAccreditatoSuCashless1_DA4_02 = importoAccreditatoSuCashless1_DA4_02
        self.importoScontiCashless1_DA5_01 = importoScontiCashless1_DA5_01
        self.erogazioniScontateCashless1_DA5_02 = erogazioniScontateCashless1_DA5_02
        self.bonusAccreditatoSuCashless1_DA6_02 = bonusAccreditatoSuCashless1_DA6_02
        self.importoVendutoCashless2_DB2_03 = importoVendutoCashless2_DB2_03
        self.erogazioniCashless2_DB2_04 = erogazioniCashless2_DB2_04
        self.importoPrelevatoDaCashless2_DB3_02 = importoPrelevatoDaCashless2_DB3_02
        self.importoAccreditatoSuCashless2_DB4_02 = importoAccreditatoSuCashless2_DB4_02
        self.importoScontiCashless2_DB5_01 = importoScontiCashless2_DB5_01
        self.erogazioniScontateCashless2_DB5_02 = erogazioniScontateCashless2_DB5_02
        self.bonusAccreditatoSuCashless2_DB6_02 = bonusAccreditatoSuCashless2_DB6_02
        self.venduto_VA1_03 = venduto_VA1_03
        self.erogazioni_VA1_04 = erogazioni_VA1_04
        self.valoreScontato_VA1_07 = valoreScontato_VA1_07
        self.erogazioniScontate_VA1_08 = erogazioniScontate_VA1_08
        self.valoreProve_VA2_03 = valoreProve_VA2_03
        self.erogazioniProva_VA2_04 = erogazioniProva_VA2_04
        self.valoreErogazioniGratuite_VA3_03 = valoreErogazioniGratuite_VA3_03
        self.erogazioniGratuite_VA3_04 = erogazioniGratuite_VA3_04
    }
    
    
    public var id: UUID
    
    public var deviceId: String
    public var detectedDeviceModel: AdeDeviceModel
    public var machineId: Int
    public var progressivoLettura: Int
    public var dataLettura: Date
    public var dataLetturaPrecedente: Date
    
    public var sellingPoint: IDType
    
    public var erogazioni: Int
    public var venduto: Double
    public var cashBox: Double
    public var tally: Double?
    
    public var importoVendutoCash_CA2_03: Double?
    public var numeroVenditeCash_CA2_04: Int?

    public var totaleCashInserito_CA3_01: Double?
    public var moneteInCassetta_CA3_02: Double?
    public var moneteVersoTubi_CA3_03: Double?
    public var banconoteInCassetta_CA3_04: Double?
    public var banconoteInCassetta_CA3_09: Double?

    public var totaleScaricoTubi_CA4_01: Double?
    public var scaricoTubiSoloManuale_CA4_02: Double?
    public var cashOverpay_CA8_01: Double?
    public var caricoManualeTubi_CA10_01: Double?

    public var valoreTotaleTubi_CA15_01: Double?

    public var numeroVendite_LA1_04: Int?

    public var importoVendutoCashless1_DA2_03: Double?
    public var erogazioniCashless1_DA2_04: Int?

    public var importoPrelevatoDaCashless1_DA3_02: Double?
    public var importoAccreditatoSuCashless1_DA4_02: Double?

    public var importoScontiCashless1_DA5_01: Double?
    public var erogazioniScontateCashless1_DA5_02: Int?

    public var bonusAccreditatoSuCashless1_DA6_02: Double?

    public var importoVendutoCashless2_DB2_03: Double?
    public var erogazioniCashless2_DB2_04: Int?

    public var importoPrelevatoDaCashless2_DB3_02: Double?
    public var importoAccreditatoSuCashless2_DB4_02: Double?

    public var importoScontiCashless2_DB5_01: Double?
    public var erogazioniScontateCashless2_DB5_02: Int?

    public var bonusAccreditatoSuCashless2_DB6_02: Double?

    public var venduto_VA1_03: Double?
    public var erogazioni_VA1_04: Int?

    public var valoreScontato_VA1_07: Double?
    public var erogazioniScontate_VA1_08: Int?

    public var valoreProve_VA2_03: Double?
    public var erogazioniProva_VA2_04: Int?

    public var valoreErogazioniGratuite_VA3_03: Double?
    public var erogazioniGratuite_VA3_04: Int?
}
