//
//  EvaValues.swift
//  Studio Caffe App
//
//  Created by Massimo Di Leonardo on 18/11/20.
//

import Foundation

public enum EvaValueType: String {
    case resettato
    case cumulato
    case info
}

public struct EvaValueRepresentation: Identifiable {
    
    public init(id: String, description: String, value: String, type: EvaValueType) {
        self.id = id
        self.description = description
        self.value = value
        self.type = type
    }
    
    public var id: String
    public var description: String
    public var value: String
    public var type: EvaValueType
}

public enum EvaValues: Equatable, Identifiable {
    
    case ID1_01(String) //ID dispositivo
    case ID1_02(String) //modello dispositivo
    
    case EA3_01(Int) //progressivo lettura
    case EA3_02_03(Date) //data lettura attuale
    case EA3_05_06(Date)//data lettura precedente
    
    case BA1_01(String) //numero seriale lettore banconote
    case BA1_02(String) //modello lettore banconote
    case BA1_03(String) //revisione software lettore banconote
    
    case CA1_01(String) //numero seriale validatore
    case CA1_02(String) //modello validatore
    case CA1_03(Int) //revisione software validatore
    
    case CA2_01(Double) //importo venduto cash cumulato
    case CA2_02 (Int) //numero vendite cash cumulato
    case CA2_03(Double) //importo venduto cash resettato
    case CA2_04 (Int) //numero vendite cash resettato
    
    case CA3_01(Double) //totale cash inserito resettato (monete + banconote)
    case CA3_02(Double) //monete in cassetta resettato
    case CA3_03(Double) //monete verso i tubi resettato
    case CA3_04(Double) //banconote in cassetta resettato
    case CA3_05(Double) //totale cash inserito cumulato (monete + banconote)
    case CA3_06(Double) //monete in cassetta cumulato
    case CA3_07(Double) //monete verso i tubi cumulato
    case CA3_08(Double) //banconote in cassetta cumulato
    case CA3_09(Double) //banconote in cassetta resettato
    
    case CA4_01(Double) //monete in uscita dai tubi (resto + manuale) resettato
    case CA4_02(Double) //monete in uscita dai tubi (solo manuale) resettato
    case CA4_03(Double) //monete in uscita dai tubi (resto + manuale) cumulato
    case CA4_04(Double) //monete in uscita dai tubi (solo manuale) cumulato
    
    case CA8_01(Double) //cash overpay resettato
    case CA8_02(Double) //cash overpay cumulato
    
    case CA10_01(Double) //riempimento manuale tubi resettato
    case CA10_02(Double) //riempimento manuale tubi cumulato
    
    case CA15_01(Double) //valore totale tubi
    
    
    case LA1_04 (Int) //numero totale vendite resettato calcolato sulla somma dei blocchi LA1
    case LA1_05 (Int) //numero totale vendite cumulato calcolato sulla somma dei blocchi LA1
    
    case DA2_01(Double) //importo venduto cashless 1 cumulato
    case DA2_02 (Int) //numero venditye cashless 1 cumulato
    case DA2_03(Double) //importo venduto cashless 1 resettato
    case DA2_04 (Int) //numero venditye cashless 1 resettato
    
    case DA3_01(Double) //importo prelevato da cashless 1 cumulato
    case DA3_02(Double) //importo prelevato da cashless 1 resettato
    
    case DA4_01(Double) //importo accreditato su cashless 1 cumulato
    case DA4_02(Double) //importo accreditato su cashless 1 resettato
    
    case DA5_01(Double) //importo sconti cashless 1 resettato
    case DA5_02 (Int) //numero vendite scontate cashless 1 resettato
    case DA5_03(Double) //importo sconti cashless 1 cumulato
    case DA5_04 (Int) //numero vendite scontate cashless 1 cumulato
    
    case DA6_01(Double) //bonus accreditato su cashless 1 cumulato
    case DA6_02(Double) //bonus accreditato su cashless 1 resettato
    
    case DB2_01(Double) //importo venduto cashless 2 cumulato
    case DB2_02 (Int) //numero venditye cashless 2 cumulato
    case DB2_03(Double) //importo venduto cashless 2 resettato
    case DB2_04 (Int) //numero venditye cashless 2 resettato
    
    case DB3_01(Double) //importo prelevato da cashless 2 cumulato
    case DB3_02(Double) //importo prelevato da cashless 2 resettato
    
    case DB4_01(Double) //importo accreditato su cashless 2 cumulato
    case DB4_02(Double) //importo accreditato su cashless 2 resettato
    
    case DB5_01(Double) //importo sconti cashless 2 resettato
    case DB5_02 (Int) //numero vendite scontate cashless 2 resettato
    case DB5_03(Double) //importo sconti cashless 2 cumulato
    case DB5_04 (Int) //numero vendite scontate cashless 2 cumulato
    
    case DB6_01(Double) //bonus accreditato su cashless 2 cumulato
    case DB6_02(Double) //bonus accreditato su cashless 2 resettato
    
    case VA1_01(Double) //totale venduto cumulato
    case VA1_02 (Int) //numero vendite cumulato
    case VA1_03(Double) //totale venduto resettato
    case VA1_04 (Int) //numero vendite resettato
    case VA1_05(Double) //totale scontato cumulato
    case VA1_06 (Int) //numero vendite scontate cumulato
    case VA1_07(Double) //totale scontato resettato
    case VA1_08 (Int) //numero vendite scontate resettato
    
    case VA2_01(Double) //valore prove cumulato
    case VA2_02 (Int) //numero prove cumulato
    case VA2_03(Double) //valore prove resettato
    case VA2_04(Int) //numero prove resettato
    
    case VA3_01(Double) //valore vendite libere cumulato
    case VA3_02 (Int) //numero vendite libere cumulato
    case VA3_03(Double) //valore vendite libere resettato
    case VA3_04 (Int) //numero vendite libere resettato
    
    public func valueDescription() -> (label: String, description: String, valueRepresentation: String, type: EvaValueType) {
        switch self {
            case .ID1_01(let value): return ("ID1_01", "ID dispositivo", value, .info)
            case .ID1_02(let value): return ("ID1_02", "modello dispositivo", value, .info)
            
            case .EA3_01(let value): return ("EA3_01", "progressivo lettura", String(value), .info)
            case .EA3_02_03(let value): return ("EA3_02_03", "data lettura attuale", DateFormatter.localizedString(from: value, dateStyle: .medium, timeStyle: .medium), .info)
            case .EA3_05_06(let value): return ("EA3_05_06", "data lettura precedente", DateFormatter.localizedString(from: value, dateStyle: .medium, timeStyle: .medium), .info)
                
            case .BA1_01(let value): return ("BA1_01", "numero seriale lettore banconote", value, .info)
            case .BA1_02(let value): return ("BA1_02", "modello lettore banconote", value, .info)
            case .BA1_03(let value): return ("BA1_03", "revisione software lettore banconote", value, .info)
            
            case .CA1_01(let value): return ("CA1_01", "numero seriale validatore", value, .info)
            case .CA1_02(let value): return ("CA1_02", "modello validatore", value, .info)
            case .CA1_03(let value): return ("CA1_03", "revisione software validatore", String(value), .info)
            
            case .CA2_01(let value): return ("CA2_01", "importo venduto cash", currencyFormattedValue(for: value), .cumulato)
            case .CA2_02(let value): return ("CA2_02", "numero vendite cash", String(value), .cumulato)
            case .CA2_03(let value): return ("CA2_03", "importo venduto cash", currencyFormattedValue(for: value), .resettato)
            case .CA2_04(let value): return ("CA2_04", "numero vendite cash", String(value), .resettato)
            
            case .CA3_01(let value): return ("CA3_01", "totale cash inserito (monete + banconote)", currencyFormattedValue(for: value), .resettato)
            case .CA3_02(let value): return ("CA3_02", "monete in cassetta", currencyFormattedValue(for: value), .resettato)
            case .CA3_03(let value): return ("CA3_03", "monete verso i tubi", currencyFormattedValue(for: value), .resettato)
            case .CA3_04(let value): return ("CA3_04", "banconote in cassetta", currencyFormattedValue(for: value), .resettato)
            case .CA3_05(let value): return ("CA3_05", "totale cash inserito (monete + banconote)", currencyFormattedValue(for: value), .cumulato)
            case .CA3_06(let value): return ("CA3_06", "monete in cassetta", currencyFormattedValue(for: value), .cumulato)
            case .CA3_07(let value): return ("CA3_07", "monete verso i tubi", currencyFormattedValue(for: value), .cumulato)
            case .CA3_08(let value): return ("CA3_08", "banconote in cassetta", currencyFormattedValue(for: value), .cumulato)
            case .CA3_09(let value): return ("CA3_09", "banconote in cassetta", currencyFormattedValue(for: value), .resettato)
            
            case .CA4_01(let value): return ("CA4_01", "totale scaricato dai tubi (resto + manuale)", currencyFormattedValue(for: value), .resettato)
            case .CA4_02(let value): return ("CA4_02", "scarico manuale tubi", currencyFormattedValue(for: value), .resettato)
            case .CA4_03(let value): return ("CA4_03", "totale scaricato dai tubi (resto + manuale)", currencyFormattedValue(for: value), .cumulato)
            case .CA4_04(let value): return ("CA4_04", "scarico manuale tubi", currencyFormattedValue(for: value), .cumulato)
            
            case .CA8_01(let value): return ("CA8_01", "cash overpay", currencyFormattedValue(for: value), .resettato)
            case .CA8_02(let value): return ("CA8_02", "cash overpay", currencyFormattedValue(for: value), .cumulato)
            
            case .CA10_01(let value): return ("CA10_01", "riempimento manuale tubi", currencyFormattedValue(for: value), .resettato)
            case .CA10_02(let value): return ("CA10_02", "riempimento manuale tubi", currencyFormattedValue(for: value), .cumulato)
            
            case .CA15_01(let value): return ("CA15_01", "totale valore tubi", currencyFormattedValue(for: value), .resettato)
            
            case .LA1_04(let value): return ("LA1_04", "numero totale vendite calcolato sulla somma dei blocchi LA1", String(value), .resettato)
            case .LA1_05(let value): return ("LA1_05", "numero totale vendite calcolato sulla somma dei blocchi LA1", String(value), .cumulato)
            
            case .DA2_01(let value): return ("DA2_01", "importo venduto cashless 1", currencyFormattedValue(for: value), .cumulato)
            case .DA2_02(let value): return ("DA2_02", "numero vendite cashless 1", String(value), .cumulato)
            case .DA2_03(let value): return ("DA2_03", "importo venduto cashless 1", currencyFormattedValue(for: value), .resettato)
            case .DA2_04(let value): return ("DA2_04", "numero vendite cashless 1", String(value), .resettato)
            
            case .DA3_01(let value): return ("DA3_01", "importo prelevato da cashless 1", currencyFormattedValue(for: value), .cumulato)
            case .DA3_02(let value): return ("DA3_02", "importo prelevato da cashless 1", currencyFormattedValue(for: value), .resettato)
            
            case .DA4_01(let value): return ("DA4_01", "importo accreditato su cashless 1", currencyFormattedValue(for: value), .cumulato)
            case .DA4_02(let value): return ("DA4_02", "importo accreditato su cashless 1", currencyFormattedValue(for: value), .resettato)
            
            case .DA5_01(let value): return ("DA5_01", "importo sconti cashless 1", currencyFormattedValue(for: value), .resettato)
            case .DA5_02(let value): return ("DA5_02", "numero vendite scontate cashless 1", String(value), .resettato)
            case .DA5_03(let value): return ("DA5_03", "importo sconti cashless 1", currencyFormattedValue(for: value), .cumulato)
            case .DA5_04(let value): return ("DA5_04", "numero vendite scontate cashless 1", String(value), .cumulato)
            
            case .DA6_01(let value): return ("DA6_01", "bonus accreditato su cashless 1", currencyFormattedValue(for: value), .cumulato)
            case .DA6_02(let value): return ("DA6_02", "bonus accreditato su cashless 1", currencyFormattedValue(for: value), .resettato)
            
            case .DB2_01(let value): return ("DB2_01", "importo venduto cashless 2", currencyFormattedValue(for: value), .cumulato)
            case .DB2_02(let value): return ("DB2_02", "numero venditye cashless 2", String(value), .cumulato)
            case .DB2_03(let value): return ("DB2_03", "importo venduto cashless 2", currencyFormattedValue(for: value), .resettato)
            case .DB2_04(let value): return ("DB2_04", "numero venditye cashless 2", String(value), .resettato)
            
            case .DB3_01(let value): return ("DB3_01", "importo prelevato da cashless 2", currencyFormattedValue(for: value), .cumulato)
            case .DB3_02(let value): return ("DB3_02", "importo prelevato da cashless 2", currencyFormattedValue(for: value), .resettato)
            
            case .DB4_01(let value): return ("DB4_01", "importo accreditato su cashless 2", currencyFormattedValue(for: value), .cumulato)
            case .DB4_02(let value): return ("DB4_02", "importo accreditato su cashless 2", currencyFormattedValue(for: value), .resettato)
            
            case .DB5_01(let value): return ("DB5_01", "importo sconti cashless 2", currencyFormattedValue(for: value), .resettato)
            case .DB5_02(let value): return ("DB5_02", "numero vendite scontate cashless 2", String(value), .resettato)
            case .DB5_03(let value): return ("DB5_03", "importo sconti cashless 2", currencyFormattedValue(for: value), .cumulato)
            case .DB5_04(let value): return ("DB5_04", "numero vendite scontate cashless 2", String(value), .cumulato)
            
            case .DB6_01(let value): return ("DB6_01", "bonus accreditato su cashless 2", currencyFormattedValue(for: value), .cumulato)
            case .DB6_02(let value): return ("DB6_02", "bonus accreditato su cashless 2", currencyFormattedValue(for: value), .resettato)
            
            case .VA1_01(let value): return ("VA1_01", "totale venduto", currencyFormattedValue(for: value), .cumulato)
            case .VA1_02(let value): return ("VA1_02", "numero vendite", String(value), .cumulato)
            case .VA1_03(let value): return ("VA1_03", "totale venduto", currencyFormattedValue(for: value), .resettato)
            case .VA1_04(let value): return ("VA1_04", "numero vendite", String(value), .resettato)
            case .VA1_05(let value): return ("VA1_05", "totale scontato", currencyFormattedValue(for: value), .cumulato)
            case .VA1_06(let value): return ("VA1_06", "numero vendite scontate", String(value), .cumulato)
            case .VA1_07(let value): return ("VA1_07", "totale scontato", currencyFormattedValue(for: value), .resettato)
            case .VA1_08(let value): return ("VA1_08", "numero vendite scontate", String(value), .resettato)
            
            case .VA2_01(let value): return ("VA2_01", "valore prove", currencyFormattedValue(for: value), .cumulato)
            case .VA2_02(let value): return ("VA2_02", "numero prove", String(value), .cumulato)
            case .VA2_03(let value): return ("VA2_03", "valore prove", currencyFormattedValue(for: value), .resettato)
            case .VA2_04(let value): return ("VA2_04", "numero prove", String(value), .resettato)
            
            case .VA3_01(let value): return ("VA3_01", "valore vendite libere", currencyFormattedValue(for: value), .cumulato)
            case .VA3_02(let value): return ("VA3_02", "numero vendite libere", String(value), .cumulato)
            case .VA3_03(let value): return ("VA3_03", "valore vendite libere", currencyFormattedValue(for: value), .resettato)
            case .VA3_04(let value): return ("VA3_04", "numero vendite libere", String(value), .resettato)
        }
    }
    
    public var representation: EvaValueRepresentation {
        switch self {
            case .ID1_01(let value): return EvaValueRepresentation(id: "ID1_01", description: "ID dispositivo", value: value, type: .info)
            case .ID1_02(let value): return EvaValueRepresentation(id: "ID1_02", description: "modello dispositivo", value: value, type: .info)
                    
            case .EA3_01(let value): return EvaValueRepresentation(id: "EA3_01", description: "progressivo lettura", value: String(value), type: .info)
            case .EA3_02_03(let value): return EvaValueRepresentation(id: "EA3_02_03", description: "data lettura attuale", value: DateFormatter.localizedString(from: value, dateStyle: .medium, timeStyle: .medium), type: .info)
            case .EA3_05_06(let value): return EvaValueRepresentation(id: "EA3_05_06", description: "data lettura precedente", value: DateFormatter.localizedString(from: value, dateStyle: .medium, timeStyle: .medium), type: .info)
                        
            case .BA1_01(let value): return EvaValueRepresentation(id: "BA1_01", description: "numero seriale lettore banconote", value: value, type: .info)
            case .BA1_02(let value): return EvaValueRepresentation(id: "BA1_02", description: "modello lettore banconote", value: value, type: .info)
            case .BA1_03(let value): return EvaValueRepresentation(id: "BA1_03", description: "revisione software lettore banconote", value: value, type: .info)
                    
            case .CA1_01(let value): return EvaValueRepresentation(id: "CA1_01", description: "numero seriale validatore", value: value, type: .info)
            case .CA1_02(let value): return EvaValueRepresentation(id: "CA1_02", description: "modello validatore", value: value, type: .info)
            case .CA1_03(let value): return EvaValueRepresentation(id: "CA1_03", description: "revisione software validatore", value: String(value), type: .info)
                    
            case .CA2_01(let value): return EvaValueRepresentation(id: "CA2_01", description: "importo venduto cash", value: currencyFormattedValue(for: value), type: .cumulato)
            case .CA2_02(let value): return EvaValueRepresentation(id: "CA2_02", description: "numero vendite cash", value: String(value), type: .cumulato)
            case .CA2_03(let value): return EvaValueRepresentation(id: "CA2_03", description: "importo venduto cash", value: currencyFormattedValue(for: value), type: .resettato)
            case .CA2_04(let value): return EvaValueRepresentation(id: "CA2_04", description: "numero vendite cash", value: String(value), type: .resettato)
                    
            case .CA3_01(let value): return EvaValueRepresentation(id: "CA3_01", description: "totale cash inserito (monete + banconote)", value: currencyFormattedValue(for: value), type: .resettato)
            case .CA3_02(let value): return EvaValueRepresentation(id: "CA3_02", description: "monete in cassetta", value: currencyFormattedValue(for: value), type: .resettato)
            case .CA3_03(let value): return EvaValueRepresentation(id: "CA3_03", description: "monete verso i tubi", value: currencyFormattedValue(for: value), type: .resettato)
            case .CA3_04(let value): return EvaValueRepresentation(id: "CA3_04", description: "banconote in cassetta", value: currencyFormattedValue(for: value), type: .resettato)
            case .CA3_05(let value): return EvaValueRepresentation(id: "CA3_05", description: "totale cash inserito (monete + banconote)", value: currencyFormattedValue(for: value), type: .cumulato)
            case .CA3_06(let value): return EvaValueRepresentation(id: "CA3_06", description: "monete in cassetta", value: currencyFormattedValue(for: value), type: .cumulato)
            case .CA3_07(let value): return EvaValueRepresentation(id: "CA3_07", description: "monete verso i tubi", value: currencyFormattedValue(for: value), type: .cumulato)
            case .CA3_08(let value): return EvaValueRepresentation(id: "CA3_08", description: "banconote in cassetta", value: currencyFormattedValue(for: value), type: .cumulato)
            case .CA3_09(let value): return EvaValueRepresentation(id: "CA3_09", description: "banconote in cassetta", value: currencyFormattedValue(for: value), type: .resettato)
                    
            case .CA4_01(let value): return EvaValueRepresentation(id: "CA4_01", description: "totale scaricato dai tubi (resto + manuale)", value: currencyFormattedValue(for: value), type: .resettato)
            case .CA4_02(let value): return EvaValueRepresentation(id: "CA4_02", description: "scarico manuale tubi", value: currencyFormattedValue(for: value), type: .resettato)
            case .CA4_03(let value): return EvaValueRepresentation(id: "CA4_03", description: "totale scaricato dai tubi (resto + manuale)", value: currencyFormattedValue(for: value), type: .cumulato)
            case .CA4_04(let value): return EvaValueRepresentation(id: "CA4_04", description: "scarico manuale tubi", value: currencyFormattedValue(for: value), type: .cumulato)
                    
            case .CA8_01(let value): return EvaValueRepresentation(id: "CA8_01", description: "cash overpay", value: currencyFormattedValue(for: value), type: .resettato)
            case .CA8_02(let value): return EvaValueRepresentation(id: "CA8_02", description: "cash overpay", value: currencyFormattedValue(for: value), type: .cumulato)
                    
            case .CA10_01(let value): return EvaValueRepresentation(id: "CA10_01", description: "riempimento manuale tubi", value: currencyFormattedValue(for: value), type: .resettato)
            case .CA10_02(let value): return EvaValueRepresentation(id: "CA10_02", description: "riempimento manuale tubi", value: currencyFormattedValue(for: value), type: .cumulato)
                    
            case .CA15_01(let value): return EvaValueRepresentation(id: "CA15_01", description: "totale valore tubi", value: currencyFormattedValue(for: value), type: .resettato)
                    
            case .LA1_04(let value): return EvaValueRepresentation(id: "LA1_04", description: "numero totale vendite calcolato sulla somma dei blocchi LA1", value: String(value), type: .resettato)
            case .LA1_05(let value): return EvaValueRepresentation(id: "LA1_05", description: "numero totale vendite calcolato sulla somma dei blocchi LA1", value: String(value), type: .cumulato)
                    
            case .DA2_01(let value): return EvaValueRepresentation(id: "DA2_01", description: "importo venduto cashless 1", value: currencyFormattedValue(for: value), type: .cumulato)
            case .DA2_02(let value): return EvaValueRepresentation(id: "DA2_02", description: "numero vendite cashless 1", value: String(value), type: .cumulato)
            case .DA2_03(let value): return EvaValueRepresentation(id: "DA2_03", description: "importo venduto cashless 1", value: currencyFormattedValue(for: value), type: .resettato)
            case .DA2_04(let value): return EvaValueRepresentation(id: "DA2_04", description: "numero vendite cashless 1", value: String(value), type: .resettato)
                    
            case .DA3_01(let value): return EvaValueRepresentation(id: "DA3_01", description: "importo prelevato da cashless 1", value: currencyFormattedValue(for: value), type: .cumulato)
            case .DA3_02(let value): return EvaValueRepresentation(id: "DA3_02", description: "importo prelevato da cashless 1", value: currencyFormattedValue(for: value), type: .resettato)
                    
            case .DA4_01(let value): return EvaValueRepresentation(id: "DA4_01", description: "importo accreditato su cashless 1", value: currencyFormattedValue(for: value), type: .cumulato)
            case .DA4_02(let value): return EvaValueRepresentation(id: "DA4_02", description: "importo accreditato su cashless 1", value: currencyFormattedValue(for: value), type: .resettato)
                    
            case .DA5_01(let value): return EvaValueRepresentation(id: "DA5_01", description: "importo sconti cashless 1", value: currencyFormattedValue(for: value), type: .resettato)
            case .DA5_02(let value): return EvaValueRepresentation(id: "DA5_02", description: "numero vendite scontate cashless 1", value: String(value), type: .resettato)
            case .DA5_03(let value): return EvaValueRepresentation(id: "DA5_03", description: "importo sconti cashless 1", value: currencyFormattedValue(for: value), type: .cumulato)
            case .DA5_04(let value): return EvaValueRepresentation(id: "DA5_04", description: "numero vendite scontate cashless 1", value: String(value), type: .cumulato)
                    
            case .DA6_01(let value): return EvaValueRepresentation(id: "DA6_01", description: "bonus accreditato su cashless 1", value: currencyFormattedValue(for: value), type: .cumulato)
            case .DA6_02(let value): return EvaValueRepresentation(id: "DA6_02", description: "bonus accreditato su cashless 1", value: currencyFormattedValue(for: value), type: .resettato)
                    
            case .DB2_01(let value): return EvaValueRepresentation(id: "DB2_01", description: "importo venduto cashless 2", value: currencyFormattedValue(for: value), type: .cumulato)
            case .DB2_02(let value): return EvaValueRepresentation(id: "DB2_02", description: "numero venditye cashless 2", value: String(value), type: .cumulato)
            case .DB2_03(let value): return EvaValueRepresentation(id: "DB2_03", description: "importo venduto cashless 2", value: currencyFormattedValue(for: value), type: .resettato)
            case .DB2_04(let value): return EvaValueRepresentation(id: "DB2_04", description: "numero venditye cashless 2", value: String(value), type: .resettato)
                    
            case .DB3_01(let value): return EvaValueRepresentation(id: "DB3_01", description: "importo prelevato da cashless 2", value: currencyFormattedValue(for: value), type: .cumulato)
            case .DB3_02(let value): return EvaValueRepresentation(id: "DB3_02", description: "importo prelevato da cashless 2", value: currencyFormattedValue(for: value), type: .resettato)
                    
            case .DB4_01(let value): return EvaValueRepresentation(id: "DB4_01", description: "importo accreditato su cashless 2", value: currencyFormattedValue(for: value), type: .cumulato)
            case .DB4_02(let value): return EvaValueRepresentation(id: "DB4_02", description: "importo accreditato su cashless 2", value: currencyFormattedValue(for: value), type: .resettato)
                    
            case .DB5_01(let value): return EvaValueRepresentation(id: "DB5_01", description: "importo sconti cashless 2", value: currencyFormattedValue(for: value), type: .resettato)
            case .DB5_02(let value): return EvaValueRepresentation(id: "DB5_02", description: "numero vendite scontate cashless 2", value: String(value), type: .resettato)
            case .DB5_03(let value): return EvaValueRepresentation(id: "DB5_03", description: "importo sconti cashless 2", value: currencyFormattedValue(for: value), type: .cumulato)
            case .DB5_04(let value): return EvaValueRepresentation(id: "DB5_04", description: "numero vendite scontate cashless 2", value: String(value), type: .cumulato)
                    
            case .DB6_01(let value): return EvaValueRepresentation(id: "DB6_01", description: "bonus accreditato su cashless 2", value: currencyFormattedValue(for: value), type: .cumulato)
            case .DB6_02(let value): return EvaValueRepresentation(id: "DB6_02", description: "bonus accreditato su cashless 2", value: currencyFormattedValue(for: value), type: .resettato)
                    
            case .VA1_01(let value): return EvaValueRepresentation(id: "VA1_01", description: "totale venduto", value: currencyFormattedValue(for: value), type: .cumulato)
            case .VA1_02(let value): return EvaValueRepresentation(id: "VA1_02", description: "numero vendite", value: String(value), type: .cumulato)
            case .VA1_03(let value): return EvaValueRepresentation(id: "VA1_03", description: "totale venduto", value: currencyFormattedValue(for: value), type: .resettato)
            case .VA1_04(let value): return EvaValueRepresentation(id: "VA1_04", description: "numero vendite", value: String(value), type: .resettato)
            case .VA1_05(let value): return EvaValueRepresentation(id: "VA1_05", description: "totale scontato", value: currencyFormattedValue(for: value), type: .cumulato)
            case .VA1_06(let value): return EvaValueRepresentation(id: "VA1_06", description: "numero vendite scontate", value: String(value), type: .cumulato)
            case .VA1_07(let value): return EvaValueRepresentation(id: "VA1_07", description: "totale scontato", value: currencyFormattedValue(for: value), type: .resettato)
            case .VA1_08(let value): return EvaValueRepresentation(id: "VA1_08", description: "numero vendite scontate", value: String(value), type: .resettato)
                    
            case .VA2_01(let value): return EvaValueRepresentation(id: "VA2_01", description: "valore prove", value: currencyFormattedValue(for: value), type: .cumulato)
            case .VA2_02(let value): return EvaValueRepresentation(id: "VA2_02", description: "numero prove", value: String(value), type: .cumulato)
            case .VA2_03(let value): return EvaValueRepresentation(id: "VA2_03", description: "valore prove", value: currencyFormattedValue(for: value), type: .resettato)
            case .VA2_04(let value): return EvaValueRepresentation(id: "VA2_04", description: "numero prove", value: String(value), type: .resettato)
                    
            case .VA3_01(let value): return EvaValueRepresentation(id: "VA3_01", description: "valore vendite libere", value: currencyFormattedValue(for: value), type: .cumulato)
            case .VA3_02(let value): return EvaValueRepresentation(id: "VA3_02", description: "numero vendite libere", value: String(value), type: .cumulato)
            case .VA3_03(let value): return EvaValueRepresentation(id: "VA3_03", description: "valore vendite libere", value: currencyFormattedValue(for: value), type: .resettato)
            case .VA3_04(let value): return EvaValueRepresentation(id: "VA3_04", description: "numero vendite libere", value: String(value), type: .resettato)
        }
    }
    
    private func currencyFormattedValue(for number: Double) -> String {
        let num = NSNumber(value: number)
        return NumberFormatter.localizedString(from: num, number: .currencyAccounting)
    }
}

public enum EvaValueIdentifier: String {
    
    case ID1_01 = "ID dispositivo"
    case ID1_02 = "modello dispositivo"
    
    case EA3_01 = "EA3_01 progressivo lettura"
    case EA3_02_03 = "EA3_02_03 data lettura attuale"
    case EA3_05_06 = "EA3_05_06 data lettura precedente"
    
    case BA1_01 = "BA1_01 numero seriale lettore banconote"
    case BA1_02 = "BA1_02 modello lettore banconote"
    case BA1_03 = "BA1_03 revisione software lettore banconote"
    
    case CA1_01 = "CA1_01 numero seriale validatore"
    case CA1_02 = "CA1_02 modello validatore"
    case CA1_03 = "CA1_03 revisione software validatore"
    
    case CA2_01 = "CA2_01 importo venduto cash cumulato"
    case CA2_02 = "CA2_02 numero vendite cash cumulato"
    case CA2_03 = "CA2_03 importo venduto cash resettato"
    case CA2_04 = "CA2_04 numero vendite cash resettato"
    
    case CA3_01 = "CA3_01 totale cash inserito resettato (monete + banconote)"
    case CA3_02 = "CA3_02 monete in cassetta resettato"
    case CA3_03 = "CA3_03 monete verso i tubi resettato"
    case CA3_04 = "CA3_04 banconote in cassetta resettato"
    case CA3_05 = "CA3_05 totale cash inserito cumulato (monete + banconote)"
    case CA3_06 = "CA3_06 monete in cassetta cumulato"
    case CA3_07 = "CA3_07 monete verso i tubi cumulato"
    case CA3_08 = "CA3_08 banconote in cassetta cumulato"
    case CA3_09 = "CA3_09 banconote in cassetta resettato CA3 09"
    
    case CA4_01 = "CA4_01 monete in uscita dai tubi (resto + manuale) resettato"
    case CA4_02 = "CA4_02 monete in uscita dai tubi (solo manuale) resettato"
    case CA4_03 = "CA4_03 monete in uscita dai tubi (resto + manuale) cumulato"
    case CA4_04 = "CA4_04 monete in uscita dai tubi (solo manuale) cumulato"
    
    case CA8_01 = "CA8_01 cash overpay resettato"
    case CA8_02 = "CA8_02 cash overpay cumulato"
    
    case CA10_01 = "CA10_01 riempimento manuale tubi resettato"
    case CA10_02 = "CA10_02 riempimento manuale tubi cumulato"
    
    case CA15_01 = "CA15_01 valore totale tubi"
    
    
    case LA1_04 = "LA1_04 numero totale vendite resettato calcolato sulla somma dei blocchi LA1"
    case LA1_05 = "LA1_05 numero totale vendite cumulato calcolato sulla somma dei blocchi LA1"
    
    case DA2_01 = "DA2_01 importo venduto cashless 1 cumulato"
    case DA2_02 = "DA2_02 numero venditye cashless 1 cumulato"
    case DA2_03 = "DA2_03 importo venduto cashless 1 resettato"
    case DA2_04 = "DA2_04 numero venditye cashless 1 resettato"
    
    case DA3_01 = "DA3_01 importo prelevato da cashless 1 cumulato"
    case DA3_02 = "DA3_02 importo prelevato da cashless 1 resettato"
    
    case DA4_01 = "DA4_01 importo accreditato su cashless 1 cumulato"
    case DA4_02 = "DA4_02 importo accreditato su cashless 1 resettato"
    
    case DA5_01 = "DA5_01 importo sconti cashless 1 resettato"
    case DA5_02 = "DA5_02 numero vendite scontate cashless 1 resettato"
    case DA5_03 = "DA5_03 importo sconti cashless 1 cumulato"
    case DA5_04 = "DA5_04 numero vendite scontate cashless 1 cumulato"
    
    case DA6_01 = "DA6_01 bonus accreditato su cashless 1 cumulato"
    case DA6_02 = "DA6_02 bonus accreditato su cashless 1 resettato"
    
    case DB2_01 = "DB2_01 importo venduto cashless 2 cumulato"
    case DB2_02 = "DB2_02 numero venditye cashless 2 cumulato"
    case DB2_03 = "DB2_03 importo venduto cashless 2 resettato"
    case DB2_04 = "DB2_04 numero venditye cashless 2 resettato"
    
    case DB3_01 = "DB3_01 importo prelevato da cashless 2 cumulato"
    case DB3_02 = "DB3_02 importo prelevato da cashless 2 resettato"
    
    case DB4_01 = "DB4_01 importo accreditato su cashless 2 cumulato"
    case DB4_02 = "DB4_02 importo accreditato su cashless 2 resettato"
    
    case DB5_01 = "DB5_01 importo sconti cashless 2 resettato"
    case DB5_02 = "DB5_02 numero vendite scontate cashless 2 resettato"
    case DB5_03 = "DB5_03 importo sconti cashless 2 cumulato"
    case DB5_04 = "DB5_04 numero vendite scontate cashless 2 cumulato"
    
    case DB6_01 = "DB6_01 bonus accreditato su cashless 2 cumulato"
    case DB6_02 = "DB6_02 bonus accreditato su cashless 2 resettato"
    
    case VA1_01 = "VA1_01 totale venduto cumulato"
    case VA1_02 = "VA1_02 numero vendite cumulato"
    case VA1_03 = "VA1_03 totale venduto resettato"
    case VA1_04 = "VA1_04 numero vendite resettato"
    case VA1_05 = "VA1_05 totale scontato cumulato"
    case VA1_06 = "VA1_06 numero vendite scontate cumulato"
    case VA1_07 = "VA1_07 totale scontato resettato"
    case VA1_08 = "VA1_08 numero vendite scontate resettato"
    
    case VA2_01 = "VA2_01 valore prove cumulato"
    case VA2_02 = "VA2_02 numero prove cumulato"
    case VA2_03 = "VA2_03 valore prove resettato"
    case VA2_04 = "VA2_04 numero prove resettato"
    
    case VA3_01 = "VA3_01 valore vendite libere cumulato"
    case VA3_02 = "VA3_02 numero vendite libere cumulato"
    case VA3_03 = "VA3_03 valore vendite libere resettato"
    case VA3_04 = "VA3_04 numero vendite libere resettato"
}

public protocol ParsedValueType {
    static var invalidValue: Self { get }
    static var nullValue: Self { get }
    var isValid: Bool { get }
    var fallBackValue: Self { get }
    var textDescription: String { get }
}

extension Double: ParsedValueType {
    public static var invalidValue: Double { -1.0 }
    public static var nullValue: Double { 0.0 }
    public var textDescription: String {
        self.currencyFormatted()
    }
    public var fallBackValue: Double {
        self == Double.invalidValue ? 0.0 : self
    }
    public var isValid: Bool { self != Self.invalidValue}
}

extension Int: ParsedValueType {
    public static var invalidValue: Int { -1 }
    public static var nullValue: Int { 0 }
    public var textDescription: String {
        String(self)
    }
    public var fallBackValue: Int {
        self == Int.invalidValue ? 0 : self
    }
    public var isValid: Bool { self != Self.invalidValue}
}

extension String: ParsedValueType {
    public static var invalidValue: String { "nd" }
    public static var nullValue: String { "" }
    public var textDescription: String { self }
    public var fallBackValue: String { "nd" }
    public var isValid: Bool { self != Self.invalidValue}
}

extension Date: ParsedValueType {
    public static var invalidValue: Date { .legalDistantPast }
    public static var nullValue: Date { .legalDistantPast }
    public var textDescription: String {
        DateFormatter.localizedString(from: self, dateStyle: .short, timeStyle: .short)
    }
    public var fallBackValue: Date { .legalDistantPast }
    public var isValid: Bool { self != Self.invalidValue}
}

public struct ParsedValue<T: ParsedValueType> {
    public var value: T
    public var id: EvaValueIdentifier
    
    public static var defaultValue: T { T.invalidValue }
    public static func defaultParsedValue(with id: EvaValueIdentifier) -> ParsedValue<T> {
        ParsedValue<T>(value: defaultValue, id: id)
    }
}

public struct EvaModelValues {
    public var deviceId: String
    public var progressivoLettura: Int
    public var dataLettura: Date
    public var dataLetturaPrecedente: Date
    public var rawReport: String
    
    public var erogazioni: Int
    public var venduto: Double
}

public struct EvaResumeValues {
    public init(erogazioni: Int,
                bilancioTubi: Double,
                bilancioChiavi: Double,
                
                numeroProve: Int,
                valoreProve: Double,
                numeroVenditeLibere: Int,
                valoreVenditeLibere: Double) {
        
        self.erogazioni = erogazioni
        self.bilancioTubi = bilancioTubi
        self.bilancioChiavi = bilancioChiavi
        
        self.numeroProve = numeroProve
        self.valoreProve = valoreProve
        self.numeroVenditeLibere = numeroVenditeLibere
        self.valoreVenditeLibere = valoreVenditeLibere
    }
    
    public var erogazioni: Int
    public var bilancioTubi: Double
    public var bilancioChiavi: Double
    
    public var numeroProve: Int
    public var valoreProve: Double
    public var numeroVenditeLibere: Int
    public var valoreVenditeLibere: Double
}

public struct EvaAdeValues: Codable, Equatable {
    public init(cashBox: Double, contato: Double, differenza: Double, incassato: Double, incassatoVendita: Double, incassatoRicarica: Double, venduto: Double, vendutoContante: Double, vendutoNoContante: Double, caricatoTubiResto: Double, resoTubiResto: Double, caricatoManualeTubiResto: Double, resoManualeTubiResto: Double, residuoChiavi: Double, cashOverpay: Double) {
        self.cashBox = cashBox
        self.contato = contato
        self.differenza = differenza
        self.incassato = incassato
        self.incassatoVendita = incassatoVendita
        self.incassatoRicarica = incassatoRicarica
        self.venduto = venduto
        self.vendutoContante = vendutoContante
        self.vendutoNoContante = vendutoNoContante
        self.caricatoTubiResto = caricatoTubiResto
        self.resoTubiResto = resoTubiResto
        self.caricatoManualeTubiResto = caricatoManualeTubiResto
        self.resoManualeTubiResto = resoManualeTubiResto
        self.residuoChiavi = residuoChiavi
        self.cashOverpay = cashOverpay
    }
    
    public var cashBox: Double
    public var contato: Double
    public var differenza: Double
    
    public var incassato: Double
    public var incassatoVendita: Double
    public var incassatoRicarica: Double
    
    public var venduto: Double
    public var vendutoContante: Double
    public var vendutoNoContante: Double
    
    public var caricatoTubiResto: Double
    public var resoTubiResto: Double
    public var caricatoManualeTubiResto: Double
    public var resoManualeTubiResto: Double
    
    public var residuoChiavi: Double
    public var cashOverpay: Double
    
    public mutating func updateTally(tally: Double) {
        self.contato = tally
        self.differenza = tally - cashBox
    }
    
    public static func == (lhs: EvaAdeValues, rhs: EvaAdeValues) -> Bool {
        return lhs.cashBox == rhs.cashBox &&
            lhs.contato == rhs.contato &&
            lhs.differenza == rhs.differenza &&
            lhs.incassato == rhs.incassato &&
            lhs.incassatoVendita == rhs.incassatoVendita &&
            lhs.incassatoRicarica == rhs.incassatoRicarica &&
            lhs.venduto == rhs.venduto &&
            lhs.vendutoContante == rhs.vendutoContante &&
            lhs.vendutoNoContante == rhs.vendutoNoContante &&
            lhs.caricatoTubiResto == rhs.caricatoTubiResto &&
            lhs.resoTubiResto == rhs.resoTubiResto &&
            lhs.caricatoManualeTubiResto == rhs.caricatoManualeTubiResto &&
            lhs.resoManualeTubiResto == rhs.resoManualeTubiResto &&
            lhs.residuoChiavi == rhs.residuoChiavi &&
            lhs.cashOverpay == rhs.cashOverpay
    }
}
