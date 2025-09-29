//
//  MultipleReportsParser.swift
//  Studio Caffe App
//
//  Created by Massimo Di Leonardo on 29/11/20.
//

import Foundation

public struct AuditReadableValues: Identifiable {
    public init(id: UUID = UUID(), valueDescription: String, readableValue: String) {
        self.id = id
        self.valueDescription = valueDescription
        self.readableValue = readableValue
    }
    
    public var id: UUID
    public var valueDescription: String
    public var readableValue: String
}

extension EvaResumeValues {
    public func readableValues() -> [AuditReadableValues] {
        [
            AuditReadableValues(valueDescription: "erogazioni", readableValue: erogazioni.textDescription),
            AuditReadableValues(valueDescription: "bilancio tubi", readableValue: bilancioTubi.currencyFormatted()),
            AuditReadableValues(valueDescription: "bilancio chiavi", readableValue: bilancioChiavi.currencyFormatted()),
            
            AuditReadableValues(valueDescription: "numero prove", readableValue: numeroProve.textDescription),
            AuditReadableValues(valueDescription: "valore prove", readableValue: valoreProve.currencyFormatted()),
            AuditReadableValues(valueDescription: "numero free vends", readableValue: numeroVenditeLibere.textDescription),
            AuditReadableValues(valueDescription: "valore free vends", readableValue: valoreVenditeLibere.currencyFormatted())
        ]
    }
}

extension EvaAdeValues {
    public func readableValues() -> [AuditReadableValues] {
        [
            AuditReadableValues(valueDescription: "cash box", readableValue: cashBox.currencyFormatted()),
            AuditReadableValues(valueDescription: "contato", readableValue: contato.currencyFormatted()),
            AuditReadableValues(valueDescription: "differenza", readableValue: differenza.currencyFormatted()),
            AuditReadableValues(valueDescription: "incassato", readableValue: incassato.currencyFormatted()),
            AuditReadableValues(valueDescription: "incassato vendita", readableValue: incassatoVendita.currencyFormatted()),
            AuditReadableValues(valueDescription: "incassato ricarica", readableValue: incassatoRicarica.currencyFormatted()),
            
            AuditReadableValues(valueDescription: "venduto", readableValue: venduto.currencyFormatted()),
            AuditReadableValues(valueDescription: "venduto contante", readableValue: vendutoContante.currencyFormatted()),
            AuditReadableValues(valueDescription: "venduto no contante", readableValue: vendutoNoContante.currencyFormatted()),
            
            AuditReadableValues(valueDescription: "caricato tubi resto", readableValue: caricatoTubiResto.currencyFormatted()),
            AuditReadableValues(valueDescription: "reso tubi resto", readableValue: resoTubiResto.currencyFormatted()),
            AuditReadableValues(valueDescription: "caricato manuale tubi resto", readableValue: caricatoManualeTubiResto.currencyFormatted()),
            AuditReadableValues(valueDescription: "reso manuale tubi resto", readableValue: resoManualeTubiResto.currencyFormatted()),
            
            AuditReadableValues(valueDescription: "residuo chiavi", readableValue: residuoChiavi.currencyFormatted()),
            AuditReadableValues(valueDescription: "cash overpay", readableValue: cashOverpay.currencyFormatted())
        ]
    }
}
