import Foundation

public protocol ResettedAuditValuesType {
    var importoVendutoCash_CA2_03: Double? { get set }
    var numeroVenditeCash_CA2_04: Int? { get set }

    var totaleCashInserito_CA3_01: Double? { get set }
    var moneteInCassetta_CA3_02: Double? { get set }
    var moneteVersoTubi_CA3_03: Double? { get set }
    var banconoteInCassetta_CA3_04: Double? { get set }
    var banconoteInCassetta_CA3_09: Double? { get set }

    var totaleScaricoTubi_CA4_01: Double? { get set }
    var scaricoTubiSoloManuale_CA4_02: Double? { get set }
    var cashOverpay_CA8_01: Double? { get set }
    var caricoManualeTubi_CA10_01: Double? { get set }

    var valoreTotaleTubi_CA15_01: Double? { get set }

    var numeroVendite_LA1_04: Int? { get set }

    var importoVendutoCashless1_DA2_03: Double? { get set }
    var erogazioniCashless1_DA2_04: Int? { get set }

    var importoPrelevatoDaCashless1_DA3_02: Double? { get set }
    var importoAccreditatoSuCashless1_DA4_02: Double? { get set }

    var importoScontiCashless1_DA5_01: Double? { get set }
    var erogazioniScontateCashless1_DA5_02: Int? { get set }

    var bonusAccreditatoSuCashless1_DA6_02: Double? { get set }

    var importoVendutoCashless2_DB2_03: Double? { get set }
    var erogazioniCashless2_DB2_04: Int? { get set }

    var importoPrelevatoDaCashless2_DB3_02: Double? { get set }
    var importoAccreditatoSuCashless2_DB4_02: Double? { get set }

    var importoScontiCashless2_DB5_01: Double? { get set }
    var erogazioniScontateCashless2_DB5_02: Int? { get set }

    var bonusAccreditatoSuCashless2_DB6_02: Double? { get set }

    var venduto_VA1_03: Double? { get set }
    var erogazioni_VA1_04: Int? { get set }

    var valoreScontato_VA1_07: Double? { get set }
    var erogazioniScontate_VA1_08: Int? { get set }

    var valoreProve_VA2_03: Double? { get set }
    var erogazioniProva_VA2_04: Int? { get set }

    var valoreErogazioniGratuite_VA3_03: Double? { get set }
    var erogazioniGratuite_VA3_04: Int? { get set }
    
    var erogazioni: Int { get }
    var venduto: Double { get }
    var cashBox: Double { get }
    var bilancioTubi: Double { get }
    var bilancioChiaviCashless1: Double { get }
    var incassatoVendita: Double { get }
    var vendutoNoContante: Double { get }
    var incassatoRicarica: Double { get }
    var residuoChiavi: Double { get }
    
    func rilevataRendiresto() -> Bool
}

public extension ResettedAuditValuesType {
    
    var erogazioni: Int {
        erogazioni_VA1_04.fbValue >= 0 ? erogazioni_VA1_04.fbValue : numeroVendite_LA1_04.fbValue
    }
    
    var venduto: Double {
        let _venduto = venduto_VA1_03.fbValue!
        let _ivCash = importoVendutoCash_CA2_03.fbValue!
        let _ivCashless1 = importoVendutoCashless1_DA2_03.fbValue!
        let _ivCashless2 = importoVendutoCashless2_DB2_03.fbValue!
        
        if _venduto > 0 {
            return _venduto.round(to: 2)
        } else {
            let vt = _ivCash + _ivCashless1 + _ivCashless2
            return vt.round(to: 2)
        }
    }
    
    var cashBox: Double {
        
        let banconote9 = banconoteInCassetta_CA3_09.fbValue!
        let banconote4 = banconoteInCassetta_CA3_04.fbValue!
        let monete = moneteInCassetta_CA3_02.fbValue!
        
        if banconote9 > 0 {
            return monete + banconote9
        } else if banconote4 > 0 {
            return monete + banconote4
        } else {
            return monete
        }
    }
    
    var bilancioTubi: Double {
        moneteVersoTubi_CA3_03.fbValue - totaleScaricoTubi_CA4_01.fbValue
    }
    
    var bilancioChiaviCashless1: Double {
        importoAccreditatoSuCashless1_DA4_02.fbValue - importoPrelevatoDaCashless1_DA3_02.fbValue
    }
    
    var incassatoVendita: Double {
        importoVendutoCash_CA2_03.fbValue +
            cashOverpay_CA8_01.fbValue +
            totaleScaricoTubi_CA4_01.fbValue -
            scaricoTubiSoloManuale_CA4_02.fbValue
    }
    
    var vendutoNoContante: Double {
        importoVendutoCashless1_DA2_03.fbValue + importoVendutoCashless2_DB2_03.fbValue
    }
    
    var incassatoRicarica: Double {
        totaleCashInserito_CA3_01.fbValue - incassatoVendita - caricoManualeTubi_CA10_01.fbValue
    }
    
    var residuoChiavi: Double {
        incassatoRicarica - vendutoNoContante
    }
    
    func rilevataRendiresto() -> Bool {
        moneteVersoTubi_CA3_03.fbValue > 0.0
            || totaleScaricoTubi_CA4_01.fbValue > 0.0
            || scaricoTubiSoloManuale_CA4_02.fbValue > 0
            || caricoManualeTubi_CA10_01.fbValue > 0
    }
}