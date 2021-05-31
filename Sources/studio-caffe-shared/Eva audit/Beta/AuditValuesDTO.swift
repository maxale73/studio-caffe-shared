import Foundation

public struct AuditValuesDTO: ResettedAuditValuesType, Identifiable {
    
    public var id: UUID
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
