//
//  File.swift
//  
//
//  Created by Massimo Di Leonardo on 30/05/21.
//

import Foundation

public struct ImportError: Hashable, Identifiable {
    public var id: EvaValueIdentifier { identifier }
    public let identifier: EvaValueIdentifier
    public let actualValue: String
    public let expectedValue: String
}

public struct ParsedAuditBeta: Identifiable, Hashable, ResettedAuditValuesType {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public var id: String
    
    public var rawReport: String
    var parsedReport: String = ""
    
    public var detectedDeviceModel = AdeDeviceModel.none
    
    public var dispositivo: String {
        dispositivoID_ID1_01
    }
    
    public var dataLettura: Date {
        dataLettura_EA3_02_03
    }
    
    public var dataLetturaPrecedente: Date {
        dataLetturaPrecedente_EA3_05_06
    }
    
    public var progressivoLettura: Int {
        letturaID_EA3_01
    }
    
    public var cashOverpay: Double {
        cashOverpay_CA8_01.fbValue
    }
    
    public var totaleTubi: Double {
        valoreTotaleTubi_CA15_01.fbValue
    }
    
    let contato = 0.0
    
    public var missingValues: [EvaValueIdentifier] = []
    
    mutating private func validate_letturaID_EA3_01(old: ParsedAuditBeta, errors: inout [ImportError]) {
        if letturaID_EA3_01 != old.letturaID_EA3_01 + 1 {
            errors.append(ImportError(identifier: .EA3_01, actualValue: letturaID_EA3_01.textDescription, expectedValue: (old.letturaID_EA3_01 + 1).textDescription))
        }
    }
    
    mutating private func validate_ldataLetturaPrecedente_EA3_05_06(old: ParsedAuditBeta, errors: inout [ImportError]) {
        if detectedDeviceModel == .ELKEY_ATTO_COIN &&  missingValues.contains(.EA3_05_06) {
            fixMissingPreviousDate(previousDate: old.dataLettura)
        }
        let calendar = Calendar(identifier: .gregorian)
        let comparison = calendar.compare(dataLetturaPrecedente_EA3_05_06, to: old.dataLettura_EA3_02_03, toGranularity: .minute)
        if comparison != .orderedSame {
            errors.append(ImportError(identifier: .EA3_05_06, actualValue: dataLetturaPrecedente_EA3_05_06.textDescription, expectedValue: old.dataLettura_EA3_02_03.textDescription))
        }
    }
    
    mutating private func validate_importoVendutoCash_CA2_01(old: ParsedAuditBeta, errors: inout [ImportError]) {
        guard old.importoVendutoCash_CA2_01.isValid && importoVendutoCash_CA2_01.isValid && importoVendutoCash_CA2_03.isValid else { return }
        let importoVendutoCash = (importoVendutoCash_CA2_01 - old.importoVendutoCash_CA2_01).round(to: 2)
        if importoVendutoCash != importoVendutoCash_CA2_03.fbValue.round(to: 2) {
            errors.append(ImportError(identifier: .CA2_03, actualValue: importoVendutoCash_CA2_03.textDescription, expectedValue: importoVendutoCash.textDescription))
        }
    }
    
    mutating private func validate_numeroVenditeCash_CA2_02(old: ParsedAuditBeta, errors: inout [ImportError]) {
        guard old.numeroVenditeCash_CA2_02.isValid && numeroVenditeCash_CA2_02.isValid && numeroVenditeCash_CA2_04.isValid else { return }
        let numeroVenditeCash = numeroVenditeCash_CA2_02 - old.numeroVenditeCash_CA2_02
        if numeroVenditeCash != numeroVenditeCash_CA2_04 {
            errors.append(ImportError(identifier: .CA2_04, actualValue: numeroVenditeCash_CA2_04.textDescription, expectedValue: numeroVenditeCash.textDescription))
        }
    }
    
    mutating private func validate_totaleCashInserito_CA3_01(old: ParsedAuditBeta, errors: inout [ImportError]) {
        guard old.totaleCashInserito_CA3_05.isValid && totaleCashInserito_CA3_05.isValid && totaleCashInserito_CA3_01.isValid else { return }
        let totaleCashInserito = (totaleCashInserito_CA3_05 - old.totaleCashInserito_CA3_05).round(to: 2)
        if totaleCashInserito != totaleCashInserito_CA3_01.fbValue.round(to: 2) {
            errors.append(ImportError(identifier: .CA3_01, actualValue: totaleCashInserito_CA3_01.textDescription, expectedValue: totaleCashInserito.textDescription))
        }
    }
    
    mutating private func validate_moneteInCassetta_CA3_02(old: ParsedAuditBeta, errors: inout [ImportError]) {
        guard old.moneteInCassetta_CA3_06.isValid && moneteInCassetta_CA3_06.isValid && moneteInCassetta_CA3_02.isValid else { return }
        let moneteInCassetta = (moneteInCassetta_CA3_06 - old.moneteInCassetta_CA3_06).round(to: 2)
        if moneteInCassetta != moneteInCassetta_CA3_02.fbValue.round(to: 2) {
            errors.append(ImportError(identifier: .CA3_02, actualValue: moneteInCassetta_CA3_02.textDescription, expectedValue: moneteInCassetta.textDescription))
        }
    }
    
    mutating private func validate_banconoteInCassetta(old: ParsedAuditBeta, errors: inout [ImportError]) {
        let bic = banconoteInCassetta_CA3_04.fbValue >= 0 ? banconoteInCassetta_CA3_04 : banconoteInCassetta_CA3_09
        
        guard old.banconoteInCassetta_CA3_08.isValid && banconoteInCassetta_CA3_08.isValid && bic.isValid else { return }
        let banconoteInCassetta04 = (banconoteInCassetta_CA3_08 - old.banconoteInCassetta_CA3_08).round(to: 2)
        if banconoteInCassetta04 != bic.fbValue.round(to: 2) {
            errors.append(ImportError(identifier: .CA3_04, actualValue: bic.textDescription, expectedValue: banconoteInCassetta04.textDescription))
        }
    }
    
    mutating private func validate_cashOverpay_CA8_01(old: ParsedAuditBeta, errors: inout [ImportError]) {
        guard old.cashOverpay_CA8_02.isValid && cashOverpay_CA8_02.isValid && cashOverpay_CA8_01.isValid else { return }
        let cashOverpay = (cashOverpay_CA8_02 - old.cashOverpay_CA8_02).round(to: 2)
        if cashOverpay != cashOverpay_CA8_01.fbValue.round(to: 2) {
            errors.append(ImportError(identifier: .CA8_01, actualValue: cashOverpay_CA8_01.textDescription, expectedValue: cashOverpay.textDescription))
        }
    }
    
    mutating private func validate_caricoManualeTubi_CA10_01(old: ParsedAuditBeta, errors: inout [ImportError]) {
        guard old.caricoManualeTubi_CA10_02.isValid && caricoManualeTubi_CA10_02.isValid && caricoManualeTubi_CA10_01.isValid else { return }
        let caricoManualeTubi = (caricoManualeTubi_CA10_02 - old.caricoManualeTubi_CA10_02).round(to: 2)
        if caricoManualeTubi != caricoManualeTubi_CA10_01.fbValue.round(to: 2) {
            errors.append(ImportError(identifier: .CA10_01, actualValue: caricoManualeTubi_CA10_01.textDescription, expectedValue: caricoManualeTubi.textDescription))
        }
    }
    
    mutating private func validate_totaleScaricoTubi_CA4_01(old: ParsedAuditBeta, errors: inout [ImportError]) {
        guard old.totaleScaricoTubi_CA4_03.isValid && totaleScaricoTubi_CA4_03.isValid && totaleScaricoTubi_CA4_01.isValid else { return }
        let totaleScaricoTubi = (totaleScaricoTubi_CA4_03 - old.totaleScaricoTubi_CA4_03).round(to: 2)
        if totaleScaricoTubi != totaleScaricoTubi_CA4_01.fbValue.round(to: 2) {
            errors.append(ImportError(identifier: .CA4_01, actualValue: totaleScaricoTubi_CA4_01.fbValue.textDescription, expectedValue: totaleScaricoTubi.textDescription))
        }
    }
    
    mutating private func validate_scaricoTubiSoloManuale_CA4_02(old: ParsedAuditBeta, errors: inout [ImportError]) {
        guard old.scaricoTubiSoloManuale_CA4_04.isValid && scaricoTubiSoloManuale_CA4_04.isValid && scaricoTubiSoloManuale_CA4_02.isValid else { return }
        let scaricoTubiManuale = (scaricoTubiSoloManuale_CA4_04 - old.scaricoTubiSoloManuale_CA4_04).round(to: 2)
        if scaricoTubiManuale != scaricoTubiSoloManuale_CA4_02.fbValue.round(to: 2) {
            errors.append(ImportError(identifier: .CA4_02, actualValue: scaricoTubiSoloManuale_CA4_02.textDescription, expectedValue: scaricoTubiManuale.textDescription))
        }
    }
    
    mutating private func validate_moneteVersoTubi_CA3_03(old: ParsedAuditBeta, errors: inout [ImportError]) {
        guard old.moneteVersoTubi_CA3_07.isValid && moneteVersoTubi_CA3_07.isValid && moneteVersoTubi_CA3_03.isValid else { return }
        let moneteVersoTubi = (moneteVersoTubi_CA3_07 - old.moneteVersoTubi_CA3_07).round(to: 2)
        if moneteVersoTubi != moneteVersoTubi_CA3_03.fbValue.round(to: 2) {
            errors.append(ImportError(identifier: .CA3_03, actualValue: moneteVersoTubi_CA3_03.textDescription, expectedValue: moneteVersoTubi.textDescription))
        }
    }
    
    mutating private func validate_numeroVendite_LA1_04(old: ParsedAuditBeta, errors: inout [ImportError]) {
        guard old.numeroVendite_LA1_05.isValid && numeroVendite_LA1_05.isValid && numeroVendite_LA1_04.isValid else { return }
        let diff = numeroVendite_LA1_05 - old.numeroVendite_LA1_05
        if diff != numeroVendite_LA1_04 {
            errors.append(ImportError(identifier: .LA1_04, actualValue: numeroVendite_LA1_04.fbValue.textDescription, expectedValue: diff.textDescription))
        }
    }
    
    mutating private func validate_importoVendutoCashless1_DA2_03(old: ParsedAuditBeta, errors: inout [ImportError]) {
        guard old.importoVendutoCashless1_DA2_01.isValid && importoVendutoCashless1_DA2_01.isValid && importoVendutoCashless1_DA2_03.isValid else { return }
        let diff = (importoVendutoCashless1_DA2_01 - old.importoVendutoCashless1_DA2_01).round(to: 2)
        if diff != importoVendutoCashless1_DA2_03.fbValue.round(to: 2) {
            errors.append(ImportError(identifier: .DA2_01, actualValue: importoVendutoCashless1_DA2_03.fbValue.textDescription, expectedValue: diff.textDescription))
        }
    }
    
    mutating private func validate_erogazioniCashless1_DA2_04(old: ParsedAuditBeta, errors: inout [ImportError]) {
        guard old.erogazioniCashless1_DA2_02.isValid && erogazioniCashless1_DA2_02.isValid && erogazioniCashless1_DA2_04.isValid else { return }
        let diff = erogazioniCashless1_DA2_02 - old.erogazioniCashless1_DA2_02
        if diff != erogazioniCashless1_DA2_04 {
            errors.append(ImportError(identifier: .DA2_04, actualValue: erogazioniCashless1_DA2_04.fbValue.textDescription, expectedValue: diff.textDescription))
        }
    }
    
    mutating private func validate_importoPrelevatoDaCashless1_DA3_02(old: ParsedAuditBeta, errors: inout [ImportError]) {
        guard old.importoPrelevatoDaCashless1_DA3_01.isValid && importoPrelevatoDaCashless1_DA3_01.isValid && importoPrelevatoDaCashless1_DA3_02.isValid else { return }
        let diff = (importoPrelevatoDaCashless1_DA3_01 - old.importoPrelevatoDaCashless1_DA3_01).round(to: 2)
        if diff != importoPrelevatoDaCashless1_DA3_02.fbValue.round(to: 2) {
            errors.append(ImportError(identifier: .DA3_02, actualValue: importoPrelevatoDaCashless1_DA3_02.fbValue.textDescription, expectedValue: diff.textDescription))
        }
    }
    
    mutating private func validate_importoAccreditatoSuCashless1_DA4_02(old: ParsedAuditBeta, errors: inout [ImportError]) {
        guard old.importoAccreditatoSuCashless1_DA4_01.isValid && importoAccreditatoSuCashless1_DA4_01.isValid && importoAccreditatoSuCashless1_DA4_02.isValid else { return }
        let diff = (importoAccreditatoSuCashless1_DA4_01 - old.importoAccreditatoSuCashless1_DA4_01).round(to: 2)
        if diff != importoAccreditatoSuCashless1_DA4_02.fbValue.round(to: 2) {
            errors.append(ImportError(identifier: .DA4_02, actualValue: importoAccreditatoSuCashless1_DA4_02.fbValue.textDescription, expectedValue: diff.textDescription))
        }
    }
    
    mutating private func fixMissingPreviousDate(previousDate: Date) {
        let rawBlocks = rawReport.components(separatedBy: "\n")
        guard let oldEA3 = rawBlocks.first(where: { $0.hasPrefix("EA3") }) else { return }
        let customFormatter = DateFormatter()
        customFormatter.dateFormat = "yyMMdd*HHmmss"
        let newEA3 = "EA3*\(letturaID_EA3_01.textDescription)*\(customFormatter.string(from: dataLettura))*0*\(customFormatter.string(from: previousDate))"
        rawReport = rawReport.replacingOccurrences(of: oldEA3, with: newEA3)
        dataLetturaPrecedente_EA3_05_06 = previousDate
    }
    
    public mutating func validateImport(old: ParsedAuditBeta) -> [ImportError] {
        var errors: [ImportError] = []
        
        if detectedDeviceModel == .none {
            errors.append(ImportError(identifier: .ID1_02, actualValue: "sconosiuto", expectedValue: "___________"))
        }
        
        validate_letturaID_EA3_01(old: old, errors: &errors)
        validate_ldataLetturaPrecedente_EA3_05_06(old: old, errors: &errors)
        
        validate_importoVendutoCash_CA2_01(old: old, errors: &errors)
        validate_numeroVenditeCash_CA2_02(old: old, errors: &errors)
        validate_totaleCashInserito_CA3_01(old: old, errors: &errors)
        validate_moneteInCassetta_CA3_02(old: old, errors: &errors)
        validate_banconoteInCassetta(old: old, errors: &errors)
        validate_cashOverpay_CA8_01(old: old, errors: &errors)
        
        if rilevataRendiresto() {
            validate_caricoManualeTubi_CA10_01(old: old, errors: &errors)
            validate_totaleScaricoTubi_CA4_01(old: old, errors: &errors)
            validate_scaricoTubiSoloManuale_CA4_02(old: old, errors: &errors)
            validate_moneteVersoTubi_CA3_03(old: old, errors: &errors)
        }
        
        validate_numeroVendite_LA1_04(old: old, errors: &errors)
        
        validate_importoVendutoCashless1_DA2_03(old: old, errors: &errors)
        validate_erogazioniCashless1_DA2_04(old: old, errors: &errors)
        validate_importoPrelevatoDaCashless1_DA3_02(old: old, errors: &errors)
        validate_importoAccreditatoSuCashless1_DA4_02(old: old, errors: &errors)
        
        return errors
    }
    
    // *********** INFO ****************
    private var communicationID_DXS_01 = String.invalidValue
    private var dispositivoID_ID1_01 = String.invalidValue
    private var dispositivoModello_ID1_02 = String.invalidValue
    private var letturaID_EA3_01 = Int.invalidValue
    private var dataLettura_EA3_02_03 = Date.distantFuture
    private var dataLetturaPrecedente_EA3_05_06 = Date.invalidValue
    
    private var numeroSerialeLettoreBanconote_BA1_01: String?
    private var modelloLettoreBanconote_BA1_02: String?
    private var versioneSoftwareLettoreBanconote_BA1_03: String?
    
    private var numeroSerialeValidatore_CA1_01: String?
    private var modelloValidatore_CA1_02: String?
    private var versioneSoftwareValidatore_CA1_03: Int?
    
    // *********** RESETTATI ****************
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
    
    
    // ************ CUMULATI *******************
    private var importoVendutoCash_CA2_01 = Double.invalidValue
    private var numeroVenditeCash_CA2_02 = Int.invalidValue
    
    private var totaleCashInserito_CA3_05 = Double.invalidValue
    private var moneteInCassetta_CA3_06 = Double.invalidValue
    private var moneteVersoTubi_CA3_07 = Double.invalidValue
    private var banconoteInCassetta_CA3_08 = Double.invalidValue
    
    private var totaleScaricoTubi_CA4_03 = Double.invalidValue
    private var scaricoTubiSoloManuale_CA4_04 = Double.invalidValue
    private var cashOverpay_CA8_02 = Double.invalidValue
    private var caricoManualeTubi_CA10_02 = Double.invalidValue
    
    private var numeroVendite_LA1_05 = Int.invalidValue
    
    private var importoVendutoCashless1_DA2_01 = Double.invalidValue
    private var erogazioniCashless1_DA2_02 = Int.invalidValue
    
    private var importoPrelevatoDaCashless1_DA3_01 = Double.invalidValue
    private var importoAccreditatoSuCashless1_DA4_01 = Double.invalidValue
    
    private var importoScontiCashless1_DA5_03 = Double.invalidValue
    private var erogazioniScontateCashless1_DA5_04 = Int.invalidValue
    
    private var bonusAccreditatoSuCashless1_DA6_01 = Double.invalidValue
    
    private var importoVendutoCashless2_DB2_01 = Double.invalidValue
    private var erogazioniCashless2_DB2_02 = Int.invalidValue
    
    private var importoPrelevatoDaCashless2_DB3_01 = Double.invalidValue
    private var importoAccreditatoSuCashless2_DB4_01 = Double.invalidValue
    
    private var importoScontiCashless2_DB5_03 = Double.invalidValue
    private var erogazioniScontateCashless2_DB5_04 = Int.invalidValue
    
    private var bonusAccreditatoSuCashless2_DB6_01 = Double.invalidValue
    
    private var venduto_VA1_01 = Double.invalidValue
    private var erogazioni_VA1_02 = Int.invalidValue
    
    private var valoreScontato_VA1_05 = Double.invalidValue
    private var erogazioniScontate_VA1_06 = Int.invalidValue
    
    private var valoreProve_VA2_01 = Double.invalidValue
    private var erogazioniProva_VA2_02 = Int.invalidValue
    
    private var valoreErogazioniGratuite_VA3_01 = Double.invalidValue
    private var erogazioniGratuite_VA3_02 = Int.invalidValue
    
    public init?(rawReport: String) {
        guard !rawReport.isEmpty else { return nil }
        self.id = UUID().uuidString
        self.rawReport = rawReport
    }
    
    private init() {
        self.id = UUID().uuidString
        self.rawReport = ""
    }
    
    public static var emptyReport: ParsedAuditBeta {
        ParsedAuditBeta()
    }
    
    public var importerLabel: String {
        "\(dispositivoID_ID1_01)_\(letturaID_EA3_01)"
    }
    
    mutating private func setPaymentSystem(ps: AdeDeviceModel) {
        if detectedDeviceModel == .none {
            detectedDeviceModel = ps
        }
    }
    
    mutating private func modifyRawReport(id: String, newValue: String) {
        let rawBlocks = rawReport.components(separatedBy: "\n")
        let indexes = id.components(separatedBy: "_")
        guard let blockName = indexes.first,
                let indexString = indexes.last,
                let index = Int(indexString),
                let oldBlock = rawBlocks.first(where: { $0.hasPrefix(blockName) }) else { return }
        var values = oldBlock.components(separatedBy: "*")
        if index < values.count {
            values.remove(at: index)
            values.insert(newValue, at: index)
            var newBlock = ""
            for v in values {
                newBlock.append(v + "*")
            }
            newBlock.removeLast()
            rawReport = rawReport.replacingOccurrences(of: oldBlock, with: newBlock)
        }
    }
    
    mutating public func updateValue(id: String, newValue: String) {
        modifyRawReport(id: id, newValue: newValue)
        parsed = false
        parseReport()
    }
    
    mutating public func updateDate(id: String, newValue: Date) {
        guard id == "EA3_02_03" || id == "EA3_05_06" else { return }
        let dateEvaFormatter = DateFormatter()
        dateEvaFormatter.dateFormat = "yyMMdd"
        let timeEvaFormatter = DateFormatter()
        timeEvaFormatter.dateFormat = "HHmmss"
        if id == "EA3_02_03" {
            modifyRawReport(id: "EA3_02", newValue: dateEvaFormatter.string(from: newValue))
            modifyRawReport(id: "EA3_03", newValue: timeEvaFormatter.string(from: newValue))
        } else if id == "EA3_05_06" {
            modifyRawReport(id: "EA3_05", newValue: dateEvaFormatter.string(from: newValue))
            modifyRawReport(id: "EA3_06", newValue: timeEvaFormatter.string(from: newValue))
        }
        parsed = false
        parseReport()
    }
    
    public func priceList() -> [AuditProduct] {
        var blocks: [EvaBlock] = []
        
        let rawBlocks = rawReport.components(separatedBy: "\n")

        for b in rawBlocks {
            var elements = b.components(separatedBy: "*")
            if let name = elements.first {
                elements.removeFirst()
                let newBlock = EvaBlock(name: name, values: elements)
                blocks.append(newBlock)
            }
        }
        let LA1Blocks = blocks.filter({ $0.name == "LA1" })
        return LA1Blocks.reduce([AuditProduct]()) { (_products, block) -> [AuditProduct] in
            guard let vends = block.intValue(for: 4), let price = block.doubleValue(for: 3) else { return _products }
            let code = block.values[1]
            if var prod = _products.first(where: { $0.code == code }) {
                prod.increaseVends(v: vends, for: price)
                var newProducts = _products
                newProducts.remove(at: _products.firstIndex(where: { $0.code == prod.code })!)
                newProducts.append(prod)
                return newProducts
            } else {
                let newProd = AuditProduct(code: code, prices: [AuditPrice(value: price, vends: vends)])
                var newProducts = _products
                newProducts.append(newProd)
                return newProducts
            }
        }
    }
    
    
    public mutating func parseReport() {
        guard !parsed else { return }
        var blocks: [EvaBlock] = []
        let rawBlocks = rawReport.components(separatedBy: "\n")

        for b in rawBlocks {
            var elements = b.components(separatedBy: "*")
            if let name = elements.first {
                elements.removeFirst()
                let newBlock = EvaBlock(name: name, values: elements)
                blocks.append(newBlock)
            }
        }
        
        // DXS
        if let DXSBlock = blocks.first(where: { $0.name == "DXS" }) {
            if let value = DXSBlock.stringValue(for: 1) {
                communicationID_DXS_01 = value
                setPaymentSystem(ps: .type(from: value))
            }
        }
        
        // ID1
        if let ID1Block = blocks.first(where: { $0.name == "ID1" }) {
            if let value = ID1Block.stringValue(for: 1) {
                dispositivoID_ID1_01 = value
            } else {
                missingValues.append(.ID1_01)
            }
            if let value = ID1Block.stringValue(for: 2) {
                dispositivoModello_ID1_02 = value
                setPaymentSystem(ps: .type(from: value))
            } else {
                missingValues.append(.ID1_02)
            }
        }
        
        // ID7
        if let ID7Block = blocks.first(where: { $0.name == "ID7" }) {
            if let value = ID7Block.stringValue(for: 5) {
                setPaymentSystem(ps: .type(from: value))
            }
        }
        
        // AM1
        if let AM1Block = blocks.first(where: { $0.name == "AM1" }) {
            if let value = AM1Block.stringValue(for: 2) {
                if detectedDeviceModel == .none {
                    setPaymentSystem(ps: .type(from: value))
                }
            }
        }
        
        //EA3
        if let EA3Block = blocks.first(where: { $0.name == "EA3" }) {
            if let value = EA3Block.intValue(for: 1) {
                letturaID_EA3_01 = value
            } else {
                missingValues.append(.EA3_01)
            }
            
            if let dataLettura = Date.date(from: EA3Block.stringValue(for: 2), _timeString: EA3Block.stringValue(for: 3)) {
                dataLettura_EA3_02_03 = dataLettura
            } else {
                missingValues.append(.EA3_02_03)
            }
            
            if let dataLetturaPrecedente = Date.date(from: EA3Block.stringValue(for: 5), _timeString: EA3Block.stringValue(for: 6)) {
                dataLetturaPrecedente_EA3_05_06 = dataLetturaPrecedente
            } else {
                missingValues.append(.EA3_05_06)
            }
        }
        
        //@$9 - Vendinguard parsed format date
        if let $9Block = blocks.first(where: { $0.name == "@$9" }) {
            if let value = $9Block.stringValue(for: 2) {
                let vgFormatter = DateFormatter()
                vgFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss"
                if let vgDate = vgFormatter.date(from: value) {
                    dataLettura_EA3_02_03 = vgDate
                    let dateEvaFormatter = DateFormatter()
                    dateEvaFormatter.dateFormat = "yyMMdd"
                    let timeEvaFormatter = DateFormatter()
                    timeEvaFormatter.dateFormat = "HHmmss"
                    modifyRawReport(id: "EA3_02", newValue: dateEvaFormatter.string(from: dataLettura))
                    modifyRawReport(id: "EA3_03", newValue: timeEvaFormatter.string(from: dataLettura))
                }
            }
        }
        
        if letturaID_EA3_01 >= 0 && dispositivoID_ID1_01 != String.invalidValue && dataLettura_EA3_02_03 != Date.distantFuture {
            id = "\(dispositivoID_ID1_01)_\(letturaID_EA3_01)_\(ISO8601DateFormatter().string(from: dataLettura_EA3_02_03))"
        }
        
        //LA1
        var _vr: Int = 0
        var _vc: Int = 0
        let LA1Blocks = blocks.filter({ $0.name == "LA1" })
        for bl in LA1Blocks {
            if let vendsResetted = bl.intValue(for: 4) {
                _vr += vendsResetted
            }
            if let vendsCumulated = bl.intValue(for: 5) {
                _vc += vendsCumulated
            }
        }
        numeroVendite_LA1_04 = _vr
        numeroVendite_LA1_05 = _vc
        
        // BA1
        if let BA1Block = blocks.first(where: { $0.name == "BA1" }) {
            if let value = BA1Block.stringValue(for: 1) {
                numeroSerialeLettoreBanconote_BA1_01 = value
            } else {
                missingValues.append(.BA1_01)
            }
            
            if let value = BA1Block.stringValue(for: 2) {
                modelloLettoreBanconote_BA1_02 = value
            } else {
                missingValues.append(.BA1_02)
            }
            
            if let value = BA1Block.stringValue(for: 3) {
                versioneSoftwareLettoreBanconote_BA1_03 = value
            } else {
                missingValues.append(.BA1_03)
            }
        }
        
        // CA1
        if let CA1Block = blocks.first(where: { $0.name == "CA1" }) {
            if let value = CA1Block.stringValue(for: 1) {
                numeroSerialeValidatore_CA1_01 = value
            } else {
                missingValues.append(.CA1_01)
            }
            
            if let value = CA1Block.stringValue(for: 2) {
                modelloValidatore_CA1_02 = value
                setPaymentSystem(ps: .type(from: value))
            } else {
                missingValues.append(.CA1_02)
            }
            
            if let value = CA1Block.intValue(for: 3) {
                versioneSoftwareValidatore_CA1_03 = value
            } else {
                missingValues.append(.CA1_03)
            }
        }
        
        // CA2
        if let CA2Block = blocks.first(where: { $0.name == "CA2" }) {
            
            if let value = CA2Block.doubleValue(for: 1) {
                importoVendutoCash_CA2_01 = value
            } else {
                missingValues.append(.CA2_01)
            }
            
            if let value = CA2Block.intValue(for: 2) {
                numeroVenditeCash_CA2_02 = value
            } else {
                missingValues.append(.CA2_02)
            }
            
            if let value = CA2Block.doubleValue(for: 3) {
                importoVendutoCash_CA2_03 = value
            } else {
                missingValues.append(.CA1_03)
            }
            
            if let value = CA2Block.intValue(for: 4) {
                numeroVenditeCash_CA2_04 = value
            } else {
                missingValues.append(.CA2_04)
            }
        }
        
        // CA3
        if let CA3Block = blocks.first(where: { $0.name == "CA3" }) {
            
            if let value = CA3Block.doubleValue(for: 1) {
                totaleCashInserito_CA3_01 = value
            } else {
                missingValues.append(.CA3_01)
            }
            
            if let value = CA3Block.doubleValue(for: 2) {
                moneteInCassetta_CA3_02 = value
            } else {
                missingValues.append(.CA3_02)
            }
            
            if let value = CA3Block.doubleValue(for: 3) {
                moneteVersoTubi_CA3_03 = value
            } else {
                missingValues.append(.CA3_03)
            }
            
            if let value = CA3Block.doubleValue(for: 9) {
                banconoteInCassetta_CA3_09 = value
            } else {
                missingValues.append(.CA3_09)
            }
            if let value = CA3Block.doubleValue(for: 4) {
                banconoteInCassetta_CA3_04 = value
            } else {
                missingValues.append(.CA3_04)
            }
            
            if let value = CA3Block.doubleValue(for: 5) {
                totaleCashInserito_CA3_05 = value
            } else {
                missingValues.append(.CA3_05)
            }
            
            if let value = CA3Block.doubleValue(for: 6) {
                moneteInCassetta_CA3_06 = value
            } else {
                missingValues.append(.CA3_06)
            }
            
            if let value = CA3Block.doubleValue(for: 7) {
                moneteVersoTubi_CA3_07 = value
            } else {
                missingValues.append(.CA3_07)
            }
            
            if let value = CA3Block.doubleValue(for: 8) {
                banconoteInCassetta_CA3_08 = value
            } else {
                missingValues.append(.CA3_08)
            }
        }
        
        // CA4
        if let CA4Block = blocks.first(where: { $0.name == "CA4" }) {
            
            if let value = CA4Block.doubleValue(for: 1) {
                totaleScaricoTubi_CA4_01 = value
            } else {
                missingValues.append(.CA4_01)
            }
            
            if let value = CA4Block.doubleValue(for: 2) {
                scaricoTubiSoloManuale_CA4_02 = value
            } else {
                missingValues.append(.CA4_02)
            }
            
            if let value = CA4Block.doubleValue(for: 3) {
                totaleScaricoTubi_CA4_03 = value
            } else {
                missingValues.append(.CA4_03)
            }
            
            if let value = CA4Block.doubleValue(for: 4) {
                scaricoTubiSoloManuale_CA4_04 = value
            } else {
                missingValues.append(.CA4_04)
            }
        }
        
        // CA8
        if let CA8Block = blocks.first(where: { $0.name == "CA8" }) {
            
            if let value = CA8Block.doubleValue(for: 1) {
                cashOverpay_CA8_01 = value
            } else {
                missingValues.append(.CA8_01)
            }
            
            if let value = CA8Block.doubleValue(for: 2) {
                cashOverpay_CA8_02 = value
            } else {
                missingValues.append(.CA8_02)
            }
        }
        
        // CA10
        if let CA10Block = blocks.first(where: { $0.name == "CA10" }) {
            
            if let value = CA10Block.doubleValue(for: 1) {
                caricoManualeTubi_CA10_01 = value
            } else {
                missingValues.append(.CA10_01)
            }
            
            if let value = CA10Block.doubleValue(for: 2) {
                caricoManualeTubi_CA10_02 = value
            } else {
                missingValues.append(.CA10_02)
            }
        }
        
        // CA15
        if let CA15Block = blocks.first(where: { $0.name == "CA15" }) {
            
            if let value = CA15Block.doubleValue(for: 1) {
                valoreTotaleTubi_CA15_01 = value
            } else {
                missingValues.append(.CA15_01)
            }
        }
        
        // DA2
        if let DA2Block = blocks.first(where: { $0.name == "DA2" }) {
            
            if let value = DA2Block.doubleValue(for: 1) {
                importoVendutoCashless1_DA2_01 = value
            } else {
                missingValues.append(.DA2_01)
            }
            
            if let value = DA2Block.intValue(for: 2) {
                erogazioniCashless1_DA2_02 = value
            } else {
                missingValues.append(.DA2_02)
            }
            
            if let value = DA2Block.doubleValue(for: 3) {
                importoVendutoCashless1_DA2_03 = value
            } else {
                missingValues.append(.DA2_03)
            }
            
            if let value = DA2Block.intValue(for: 4) {
                erogazioniCashless1_DA2_04 = value
            } else {
                missingValues.append(.DA2_04)
            }
        }
        
        // DA3
        if let DA3Block = blocks.first(where: { $0.name == "DA3" }) {
            
            if let value = DA3Block.doubleValue(for: 1) {
                importoPrelevatoDaCashless1_DA3_01 = value
            } else {
                missingValues.append(.DA3_01)
            }
            
            if let value = DA3Block.doubleValue(for: 2) {
                importoPrelevatoDaCashless1_DA3_02 = value
            } else {
                missingValues.append(.DA3_02)
            }
        }
        //DA4
        if let DA4Block = blocks.first(where: { $0.name == "DA4" }) {
            
            if let value = DA4Block.doubleValue(for: 1) {
                importoAccreditatoSuCashless1_DA4_01 = value
            } else {
                missingValues.append(.DA4_01)
            }
            
            if let value = DA4Block.doubleValue(for: 2) {
                importoAccreditatoSuCashless1_DA4_02 = value
            } else {
                missingValues.append(.DA4_02)
            }
        }
        
        // DA5
        if let DA5Block = blocks.first(where: { $0.name == "DA5" }) {
            
            if let value = DA5Block.doubleValue(for: 1) {
                importoScontiCashless1_DA5_01 = value
            } else {
                missingValues.append(.DA5_01)
            }
            
            if let value = DA5Block.intValue(for: 2) {
                erogazioniScontateCashless1_DA5_02 = value
            } else {
                missingValues.append(.DA5_02)
            }
            
            if let value = DA5Block.doubleValue(for: 3) {
                importoScontiCashless1_DA5_03 = value
            } else {
                missingValues.append(.DA5_03)
            }
            
            if let value = DA5Block.intValue(for: 4) {
                erogazioniScontateCashless1_DA5_04 = value
            } else {
                missingValues.append(.DA5_04)
            }
        }
        
        // DA6
        if let DA6Block = blocks.first(where: { $0.name == "DA6" }) {
            
            if let value = DA6Block.doubleValue(for: 1) {
                bonusAccreditatoSuCashless1_DA6_01 = value
            } else {
                missingValues.append(.DA6_01)
            }
            
            if let value = DA6Block.doubleValue(for: 2) {
                bonusAccreditatoSuCashless1_DA6_02 = value
            } else {
                missingValues.append(.DA6_02)
            }
        }
        
        // DB2
        if let DB2Block = blocks.first(where: { $0.name == "DB2" }) {
            
            if let value = DB2Block.doubleValue(for: 1) {
                importoVendutoCashless2_DB2_01 = value
            } else {
                missingValues.append(.DB2_01)
            }
            
            if let value = DB2Block.intValue(for: 2) {
               erogazioniCashless2_DB2_02 = value
            } else {
                missingValues.append(.DB2_02)
            }
            
            if let value = DB2Block.doubleValue(for: 3) {
                importoVendutoCashless2_DB2_03 = value
            } else {
                missingValues.append(.DB2_03)
            }
            
            if let value = DB2Block.intValue(for: 4) {
                erogazioniCashless2_DB2_04 = value
            } else {
                missingValues.append(.DB2_04)
            }
        }
        
        if let DB3Block = blocks.first(where: { $0.name == "DB3" }) {
        
            if let value = DB3Block.doubleValue(for: 1) {
                importoPrelevatoDaCashless2_DB3_01 = value
            } else {
                missingValues.append(.DB3_01)
            }
            
            if let value = DB3Block.doubleValue(for: 2) {
                importoPrelevatoDaCashless2_DB3_02 = value
            } else {
                missingValues.append(.DB3_02)
            }
        }
        
        // DB4
        if let DB4Block = blocks.first(where: { $0.name == "DB4" }) {
            
            if let value = DB4Block.doubleValue(for: 1) {
                importoAccreditatoSuCashless2_DB4_01 = value
            } else {
                missingValues.append(.DB4_01)
            }
            
            if let value = DB4Block.doubleValue(for: 2) {
                importoAccreditatoSuCashless2_DB4_02 = value
            } else {
                missingValues.append(.DB4_02)
            }
        }
        
        //DB5
        if let DB5Block = blocks.first(where: { $0.name == "DB5" }) {
            
            if let value = DB5Block.doubleValue(for: 1) {
                importoScontiCashless2_DB5_01 = value
            } else {
                missingValues.append(.DB5_01)
            }
            
            if let value = DB5Block.intValue(for: 2) {
                erogazioniScontateCashless2_DB5_02 = value
            } else {
                missingValues.append(.DB5_02)
            }
            
            if let value = DB5Block.doubleValue(for: 3) {
                importoScontiCashless2_DB5_03 = value
            } else {
                missingValues.append(.DB5_03)
            }
            
            if let value = DB5Block.intValue(for: 4) {
                erogazioniScontateCashless2_DB5_04 = value
            } else {
                missingValues.append(.DB5_04)
            }
        }
        
        // DB6
        if let DB6Block = blocks.first(where: { $0.name == "DB6" }) {
            
            if let value = DB6Block.doubleValue(for: 1) {
                bonusAccreditatoSuCashless2_DB6_01 = value
            } else {
                missingValues.append(.DB6_01)
            }
            
            if let value = DB6Block.doubleValue(for: 2) {
                bonusAccreditatoSuCashless2_DB6_02 = value
            } else {
                missingValues.append(.DB6_02)
            }
        }
        
        if let VA1Block = blocks.first(where: { $0.name == "VA1" }) {
            
            if let value = VA1Block.doubleValue(for: 1) {
                venduto_VA1_01 = value
            } else {
                missingValues.append(.VA1_01)
            }
            
            if let value = VA1Block.intValue(for: 2) {
                erogazioni_VA1_02 = value
            } else {
                missingValues.append(.VA1_02)
            }
            
            if let value = VA1Block.doubleValue(for: 3) {
                venduto_VA1_03 = value
            } else {
                missingValues.append(.VA1_03)
            }
            
            if let value = VA1Block.intValue(for: 4) {
                erogazioni_VA1_04 = value
            } else {
                missingValues.append(.VA1_04)
            }
            
            if let value = VA1Block.doubleValue(for: 5) {
                valoreScontato_VA1_05 = value
            } else {
                missingValues.append(.VA1_05)
            }
            
            if let value = VA1Block.intValue(for: 6) {
                erogazioniScontate_VA1_06 = value
            } else {
                missingValues.append(.VA1_06)
            }
            
            if let value = VA1Block.doubleValue(for: 7) {
                valoreScontato_VA1_07 = value
            } else {
                missingValues.append(.VA1_07)
            }
            
            if let value = VA1Block.intValue(for: 8) {
                erogazioniScontate_VA1_08 = value
            } else {
                missingValues.append(.VA1_08)
            }
        }
        
        if let VA2Block = blocks.first(where: { $0.name == "VA2" }) {
            
            if let value = VA2Block.doubleValue(for: 1) {
                valoreProve_VA2_01 = value
            } else {
                missingValues.append(.VA2_01)
            }
            
            if let value = VA2Block.intValue(for: 2) {
                erogazioniProva_VA2_02 = value
            } else {
                missingValues.append(.VA2_02)
            }
            
            if let value = VA2Block.doubleValue(for: 3) {
                valoreProve_VA2_03 = value
            } else {
                missingValues.append(.VA2_03)
            }
            
            if let value = VA2Block.intValue(for: 4) {
                erogazioniProva_VA2_04 = value
            } else {
                missingValues.append(.VA2_04)
            }
        }
        
        if let VA3Block = blocks.first(where: { $0.name == "VA3" }) {
            
            if let value = VA3Block.doubleValue(for: 1) {
                valoreErogazioniGratuite_VA3_01 = value
            } else {
                missingValues.append(.VA3_01)
            }
            
            if let value = VA3Block.intValue(for: 2) {
                erogazioniGratuite_VA3_02 = value
            } else {
                missingValues.append(.VA3_02)
            }
            
            if let value = VA3Block.doubleValue(for: 3) {
                valoreErogazioniGratuite_VA3_03 = value
            } else {
                missingValues.append(.VA3_03)
            }
            
            if let value = VA3Block.intValue(for: 4) {
               erogazioniGratuite_VA3_04 = value
            } else {
                missingValues.append(.VA3_04)
            }
        }

        for b in blocks {
            parsedReport.append(b.description)
        }
        parsed = true
    }
    
    private var parsed: Bool = false
    
    public var erogazioni: Int {
        get {
            if let VA104 = erogazioni_VA1_04 {
                return VA104
            } else {
                return numeroVendite_LA1_04 ?? 0
            }
//            erogazioni_VA1_04.fbValue >= 0 ? erogazioni_VA1_04.fbValue : numeroVendite_LA1_04.fbValue
        }
    }
    
    public var venduto: Double {
        get {
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
    }
    
    public var cashBox: Double {
        get {
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
    }
    
    public func audit(id: UUID? = nil, machineID: Int, sellingPointID: IDType) -> AuditDTO {
        
        AuditDTO(
            
            id: id ?? UUID(),
            
            deviceId: dispositivoID_ID1_01,
            detectedDeviceModel: detectedDeviceModel,
            machineId: machineID,
            progressivoLettura: letturaID_EA3_01,
            dataLettura: dataLettura_EA3_02_03,
            dataLetturaPrecedente: dataLetturaPrecedente_EA3_05_06,
            
            sellingPoint: sellingPointID,
            
            erogazioni: erogazioni,
            venduto: venduto,
            cashBox: cashBox,
            tally: nil,
            
            importoVendutoCash_CA2_03: importoVendutoCash_CA2_03,
            numeroVenditeCash_CA2_04: numeroVenditeCash_CA2_04,

            totaleCashInserito_CA3_01: totaleCashInserito_CA3_01,
            moneteInCassetta_CA3_02: moneteInCassetta_CA3_02,
            moneteVersoTubi_CA3_03: moneteVersoTubi_CA3_03,
            banconoteInCassetta_CA3_04: banconoteInCassetta_CA3_04,
            banconoteInCassetta_CA3_09: banconoteInCassetta_CA3_09,

            totaleScaricoTubi_CA4_01: totaleScaricoTubi_CA4_01,
            scaricoTubiSoloManuale_CA4_02: scaricoTubiSoloManuale_CA4_02,
            cashOverpay_CA8_01: cashOverpay_CA8_01,
            caricoManualeTubi_CA10_01: caricoManualeTubi_CA10_01,

            valoreTotaleTubi_CA15_01: valoreTotaleTubi_CA15_01,

            numeroVendite_LA1_04: numeroVendite_LA1_04,

            importoVendutoCashless1_DA2_03: importoVendutoCashless1_DA2_03,
            erogazioniCashless1_DA2_04: erogazioniCashless1_DA2_04,

            importoPrelevatoDaCashless1_DA3_02: importoPrelevatoDaCashless1_DA3_02,
            importoAccreditatoSuCashless1_DA4_02: importoAccreditatoSuCashless1_DA4_02,

            importoScontiCashless1_DA5_01: importoScontiCashless1_DA5_01,
            erogazioniScontateCashless1_DA5_02: erogazioniScontateCashless1_DA5_02,

            bonusAccreditatoSuCashless1_DA6_02: bonusAccreditatoSuCashless1_DA6_02,

            importoVendutoCashless2_DB2_03: importoVendutoCashless2_DB2_03,
            erogazioniCashless2_DB2_04: erogazioniCashless2_DB2_04,

            importoPrelevatoDaCashless2_DB3_02: importoPrelevatoDaCashless2_DB3_02,
            importoAccreditatoSuCashless2_DB4_02: importoAccreditatoSuCashless2_DB4_02,

            importoScontiCashless2_DB5_01: importoScontiCashless2_DB5_01,
            erogazioniScontateCashless2_DB5_02: erogazioniScontateCashless2_DB5_02,

            bonusAccreditatoSuCashless2_DB6_02: bonusAccreditatoSuCashless2_DB6_02,

            venduto_VA1_03: venduto_VA1_03,
            erogazioni_VA1_04: erogazioni_VA1_04,

            valoreScontato_VA1_07: valoreScontato_VA1_07,
            erogazioniScontate_VA1_08: erogazioniScontate_VA1_08,

            valoreProve_VA2_03: valoreProve_VA2_03,
            erogazioniProva_VA2_04: erogazioniProva_VA2_04,

            valoreErogazioniGratuite_VA3_03: valoreErogazioniGratuite_VA3_03,
            erogazioniGratuite_VA3_04: erogazioniGratuite_VA3_04)
    }
}

extension ParsedAuditBeta: Equatable {
//    public static func == (lhs: ParsedAuditBeta, rhs: ParsedAuditBeta) -> Bool {
//        return lhs.dispositivoID_ID1_01 == rhs.dispositivoID_ID1_01 && lhs.letturaID_EA3_01 == rhs.letturaID_EA3_01
//    }
}

extension ParsedAuditBeta {
    public func infoValues() -> [EvaValues] {
        var values: [EvaValues] = []
        if dispositivoID_ID1_01.isValid {
            values.append(.ID1_01(dispositivoID_ID1_01))
        }
        if dispositivoModello_ID1_02.isValid {
            values.append(.ID1_02(dispositivoModello_ID1_02))
        }
        if letturaID_EA3_01.isValid {
            values.append(.EA3_01(letturaID_EA3_01))
        }
        if dataLettura_EA3_02_03.isValid {
            values.append(.EA3_02_03(dataLettura_EA3_02_03))
        }
        if dataLetturaPrecedente_EA3_05_06.isValid {
            values.append(.EA3_05_06(dataLetturaPrecedente_EA3_05_06))
        }
        
        if numeroSerialeLettoreBanconote_BA1_01.isValid {
            values.append(.BA1_01(numeroSerialeLettoreBanconote_BA1_01!))
        }
        if modelloLettoreBanconote_BA1_02.isValid {
            values.append(.BA1_02(modelloLettoreBanconote_BA1_02!))
        }
        if versioneSoftwareLettoreBanconote_BA1_03.isValid {
            values.append(.BA1_03(versioneSoftwareLettoreBanconote_BA1_03!))
        }
        
        if numeroSerialeValidatore_CA1_01.isValid {
            values.append(.CA1_01(numeroSerialeValidatore_CA1_01!))
        }
        if modelloValidatore_CA1_02.isValid {
            values.append(.CA1_02(modelloValidatore_CA1_02!))
        }
        if versioneSoftwareValidatore_CA1_03.isValid {
            values.append(.CA1_03(versioneSoftwareValidatore_CA1_03.fbValue))
        }
        return values
    }
    
    public func resettableValues() -> [EvaValues] {
        var values: [EvaValues] = []
        if importoVendutoCash_CA2_03.isValid {
            values.append(.CA2_03(importoVendutoCash_CA2_03.fbValue))
        }
        if numeroVenditeCash_CA2_04.isValid {
            values.append(.CA2_04(numeroVenditeCash_CA2_04.fbValue))
        }
        if totaleCashInserito_CA3_01.isValid {
            values.append(.CA3_01(totaleCashInserito_CA3_01.fbValue))
        }
        if moneteInCassetta_CA3_02.isValid {
            values.append(.CA3_02(moneteInCassetta_CA3_02.fbValue))
        }
        if moneteVersoTubi_CA3_03.isValid {
            values.append(.CA3_03(moneteVersoTubi_CA3_03.fbValue))
        }
        if banconoteInCassetta_CA3_04.isValid {
            values.append(.CA3_04(banconoteInCassetta_CA3_04.fbValue))
        }
        if banconoteInCassetta_CA3_09.isValid {
            values.append(.CA3_09(banconoteInCassetta_CA3_09.fbValue))
        }
        if totaleScaricoTubi_CA4_01.isValid {
            values.append(.CA4_01(totaleScaricoTubi_CA4_01.fbValue))
        }
        if scaricoTubiSoloManuale_CA4_02.isValid {
            values.append(.CA4_02(scaricoTubiSoloManuale_CA4_02.fbValue))
        }
        if cashOverpay_CA8_01.isValid {
            values.append(.CA8_01(cashOverpay_CA8_01.fbValue))
        }
        if caricoManualeTubi_CA10_01.isValid {
            values.append(.CA10_01(caricoManualeTubi_CA10_01.fbValue))
        }
        if valoreTotaleTubi_CA15_01.isValid {
            values.append(.CA15_01(valoreTotaleTubi_CA15_01.fbValue))
        }
        if numeroVendite_LA1_04.isValid {
            values.append(.LA1_04(numeroVendite_LA1_04.fbValue))
        }
        if importoVendutoCashless1_DA2_03.isValid {
            values.append(.DA2_03(importoVendutoCashless1_DA2_03.fbValue))
        }
        if erogazioniCashless1_DA2_04.isValid {
            values.append(.DA2_04(erogazioniCashless1_DA2_04.fbValue))
        }
        if importoPrelevatoDaCashless1_DA3_02.isValid {
            values.append(.DA3_02(importoPrelevatoDaCashless1_DA3_02.fbValue))
        }
        if importoAccreditatoSuCashless1_DA4_02.isValid {
            values.append(.DA4_02(importoAccreditatoSuCashless1_DA4_02.fbValue))
        }
        if importoScontiCashless1_DA5_01.isValid {
            values.append(.DA5_01(importoScontiCashless1_DA5_01.fbValue))
        }
        if erogazioniScontateCashless1_DA5_02.isValid {
            values.append(.DA5_02(erogazioniScontateCashless1_DA5_02.fbValue))
        }
        if bonusAccreditatoSuCashless1_DA6_02.isValid {
            values.append(.DA6_02(bonusAccreditatoSuCashless1_DA6_02.fbValue))
        }
        if importoVendutoCashless2_DB2_03.isValid {
            values.append(.DB2_03(importoVendutoCashless2_DB2_03.fbValue))
        }
        if erogazioniCashless2_DB2_04.isValid {
            values.append(.DB2_04(erogazioniCashless2_DB2_04.fbValue))
        }
        if importoPrelevatoDaCashless2_DB3_02.isValid {
            values.append(.DB3_02(importoPrelevatoDaCashless2_DB3_02.fbValue))
        }
        if importoAccreditatoSuCashless2_DB4_02.isValid {
            values.append(.DB4_02(importoAccreditatoSuCashless2_DB4_02.fbValue))
        }
        if importoScontiCashless2_DB5_01.isValid {
            values.append(.DB5_01(importoScontiCashless2_DB5_01.fbValue))
        }
        if erogazioniScontateCashless2_DB5_02.isValid {
            values.append(.DB5_02(erogazioniScontateCashless2_DB5_02.fbValue))
        }
        if bonusAccreditatoSuCashless2_DB6_02.isValid {
            values.append(.DB6_02(bonusAccreditatoSuCashless2_DB6_02.fbValue))
        }
        if venduto_VA1_03.isValid {
            values.append(.VA1_03(venduto_VA1_03.fbValue))
        }
        if erogazioni_VA1_04.isValid {
            values.append(.VA1_04(erogazioni_VA1_04.fbValue))
        }
        if valoreScontato_VA1_07.isValid {
            values.append(.VA1_07(valoreScontato_VA1_07.fbValue))
        }
        if erogazioniScontate_VA1_08.isValid {
            values.append(.VA1_08(erogazioniScontate_VA1_08.fbValue))
        }
        if valoreProve_VA2_03.isValid {
            values.append(.VA2_03(valoreProve_VA2_03.fbValue))
        }
        if erogazioniProva_VA2_04.isValid {
            values.append(.VA2_04(erogazioniProva_VA2_04.fbValue))
        }
        if valoreErogazioniGratuite_VA3_03.isValid {
            values.append(.VA3_03(valoreErogazioniGratuite_VA3_03.fbValue))
        }
        if erogazioniGratuite_VA3_04.isValid {
            values.append(.VA3_04(erogazioniGratuite_VA3_04.fbValue))
        }
        return values
    }
    
    public func cumulatedValues() -> [EvaValues] {
        var values: [EvaValues] = []
        if importoVendutoCash_CA2_01.isValid {
            values.append(.CA2_01(importoVendutoCash_CA2_01))
        }
        if numeroVenditeCash_CA2_02.isValid {
            values.append(.CA2_02(numeroVenditeCash_CA2_02))
        }
        if totaleCashInserito_CA3_05.isValid {
            values.append(.CA3_05(totaleCashInserito_CA3_05))
        }
        if moneteInCassetta_CA3_06.isValid {
            values.append(.CA3_06(moneteInCassetta_CA3_06))
        }
        if moneteVersoTubi_CA3_07.isValid {
            values.append(.CA3_07(moneteVersoTubi_CA3_07))
        }
        if banconoteInCassetta_CA3_08.isValid {
            values.append(.CA3_08(banconoteInCassetta_CA3_08))
        }
        
        if totaleScaricoTubi_CA4_03.isValid {
            values.append(.CA4_03(totaleScaricoTubi_CA4_03))
        }
        if scaricoTubiSoloManuale_CA4_04.isValid {
            values.append(.CA4_04(scaricoTubiSoloManuale_CA4_04))
        }
        if cashOverpay_CA8_02.isValid {
            values.append(.CA8_02(cashOverpay_CA8_02))
        }
        if caricoManualeTubi_CA10_02.isValid {
            values.append(.CA10_02(caricoManualeTubi_CA10_02))
        }
        
        if numeroVendite_LA1_05.isValid {
            values.append(.LA1_05(numeroVendite_LA1_05))
        }
        
        if importoVendutoCashless1_DA2_01.isValid {
            values.append(.DA2_01(importoVendutoCashless1_DA2_01))
        }
        if erogazioniCashless1_DA2_02.isValid {
            values.append(.DA2_02(erogazioniCashless1_DA2_02))
        }
        
        if importoPrelevatoDaCashless1_DA3_01.isValid {
            values.append(.DA3_01(importoPrelevatoDaCashless1_DA3_01))
        }
        if importoAccreditatoSuCashless1_DA4_01.isValid {
            values.append(.DA4_01(importoAccreditatoSuCashless1_DA4_01))
        }
        
        if importoScontiCashless1_DA5_03.isValid {
            values.append(.DA5_03(importoScontiCashless1_DA5_03))
        }
        if erogazioniScontateCashless1_DA5_04.isValid {
            values.append(.DA5_04(erogazioniScontateCashless1_DA5_04))
        }
        
        if bonusAccreditatoSuCashless1_DA6_01.isValid {
            values.append(.DA6_01(bonusAccreditatoSuCashless1_DA6_01))
        }
        
        if importoVendutoCashless2_DB2_01.isValid {
            values.append(.DB2_01(importoVendutoCashless2_DB2_01))
        }
        if erogazioniCashless2_DB2_02.isValid {
            values.append(.DB2_02(erogazioniCashless2_DB2_02))
        }
        
        if importoPrelevatoDaCashless2_DB3_01.isValid {
            values.append(.DB3_01(importoPrelevatoDaCashless2_DB3_01))
        }
        if importoAccreditatoSuCashless2_DB4_01.isValid {
            values.append(.DB4_01(importoAccreditatoSuCashless2_DB4_01))
        }
        
        if importoScontiCashless2_DB5_03.isValid {
            values.append(.DB5_03(importoScontiCashless2_DB5_03))
        }
        if erogazioniScontateCashless2_DB5_04.isValid {
            values.append(.DB5_04(erogazioniScontateCashless2_DB5_04))
        }
        
        if bonusAccreditatoSuCashless2_DB6_01.isValid {
            values.append(.DB6_01(bonusAccreditatoSuCashless2_DB6_01))
        }
        if venduto_VA1_01.isValid {
            values.append(.VA1_01(venduto_VA1_01))
        }
        if erogazioni_VA1_02.isValid {
            values.append(.VA1_02(erogazioni_VA1_02))
        }
        
        if valoreScontato_VA1_05.isValid {
            values.append(.VA1_05(valoreScontato_VA1_05))
        }
        if erogazioniScontate_VA1_06.isValid {
            values.append(.VA1_06(erogazioniScontate_VA1_06))
        }
        
        if valoreProve_VA2_01.isValid {
            values.append(.VA2_01(valoreProve_VA2_01))
        }
        if erogazioniProva_VA2_02.isValid {
            values.append(.VA2_02(erogazioniProva_VA2_02))
        }
        if valoreErogazioniGratuite_VA3_01.isValid {
            values.append(.VA3_01(valoreErogazioniGratuite_VA3_01))
        }
        if erogazioniGratuite_VA3_02.isValid {
            values.append(.VA3_02(erogazioniGratuite_VA3_02))
        }
        return values
    }
}
