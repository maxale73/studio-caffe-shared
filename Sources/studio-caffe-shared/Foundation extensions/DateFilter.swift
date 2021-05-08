//
//  DateFilter.swift
//  Studio Caffe App
//
//  Created by Massimo Di Leonardo on 23/12/20.
//

import Foundation

enum DateFilter: String, CaseIterable, Identifiable {
    var id: String {
        rawValue
    }
    
    case annoPrecedente = "anno precedente"
    case ultimoAnno = "ultimo anno"
    case annoCorrente = "anno corrente"
    case meseCorrente = "mese corrente"
    case ultimoMese = "ultimo mese"
    case ultimi3Mesi = "ultimi 3 mesi"
    case ultimi6Mesi = "ultimi 6 mesi"
    case mesePrecedente = "mese precedente"
    case settimanaCorrente = "settimana corrente"
    case ultimaSettimana = "ultima settimana"
    case settimanaPrecedente = "settimana precedente"
    case oggi = "oggi"
    case ieri = "ieri"
    case imposta = "imposta"
    case giorno = "giorno"
    
    var extretemes: (from: Date, to: Date) {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2
        calendar.timeZone = .autoupdatingCurrent
        switch self {
            case .annoPrecedente: return Date.annoPrecedente(calendar: calendar)
            case .ultimoAnno: return Date.ultimoAnno(calendar: calendar)
            case .annoCorrente: return Date.annoCorrente(calendar: calendar)
            case .meseCorrente: return Date.meseCorrente(calendar: calendar)
            case .ultimoMese: return Date.ultimoMese(calendar: calendar)
            case .ultimi3Mesi: return Date.ultimi3Mesi(calendar: calendar)
            case .ultimi6Mesi: return Date.ultimi6Mesi(calendar: calendar)
            case .mesePrecedente: return Date.mesePrecedente(calendar: calendar)
            case .settimanaCorrente: return Date.settimanaCorrente(calendar: calendar)
            case .ultimaSettimana: return Date.ultimaSettimana(calendar: calendar)
            case .settimanaPrecedente: return Date.settimanaPrecedente(calendar: calendar)
            case .oggi: return Date.oggi(calendar: calendar)
            case .ieri: return Date.ieri(calendar: calendar)
            case .imposta: return (.defaultStartDate, Date())
            case .giorno: return(.beginOfDay(from: Date()), .endOfDay(from: Date()))
        }
    }
}
