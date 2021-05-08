//
//  Date + Extensions.swift
//  Studio Caffe App
//
//  Created by Massimo Di Leonardo on 13/12/20.
//

import Foundation

extension Date {
    static func nowComponents(calendar: Calendar) -> DateComponents {
        calendar.dateComponents([.year, .month, .day, .minute, .second], from: Date())
    }
    
    static func annoPrecedente(calendar: Calendar) -> (from: Date, to: Date) {
        let beginOfLastYear = calendar.date(byAdding: .year, value: -1, to: .beginOfYear)
        let endOfLastYearDay = calendar.date(byAdding: .day, value: -1, to: .beginOfYear)
        return (beginOfLastYear!, .endOfDay(from: endOfLastYearDay!))
    }
    
    static func ultimoAnno(calendar: Calendar) -> (from: Date, to: Date) {
        let to = Date()
        let from = calendar.date(byAdding: .year, value: -1, to: to) ?? Date.defaultStartDate
        return (from, to)
    }
    
    static func annoCorrente(calendar: Calendar) -> (from: Date, to: Date) {
        let nowComponents = Self.nowComponents(calendar: calendar)
        let from = calendar.date(from: DateComponents(calendar: calendar, year: nowComponents.year, month: 1, day: 1))!
        let to = Date.endOfDay(from: Date())
        return (from, to)
    }
    
    static func meseCorrente(calendar: Calendar) -> (from: Date, to: Date) {
        let nowComponents = Self.nowComponents(calendar: calendar)
        let to = Date.endOfDay(from: Date())
        let from = calendar.date(from: DateComponents(calendar: calendar, year: nowComponents.year, month: nowComponents.month, day: 1))!
        return (from, to)
    }
    
    static func ultimoMese(calendar: Calendar) -> (from: Date, to: Date) {
        let to = Date()
        let from = calendar.date(byAdding: .month, value: -1, to: to) ?? Date.defaultStartDate
        return (from, to)
    }
    
    static func ultimi3Mesi(calendar: Calendar) -> (from: Date, to: Date) {
        let to = Date()
        let from = calendar.date(byAdding: .month, value: -3, to: to) ?? Date.defaultStartDate
        return (from, to)
    }
    
    static func ultimi6Mesi(calendar: Calendar) -> (from: Date, to: Date) {
        let to = Date()
        let from = calendar.date(byAdding: .month, value: -6, to: to) ?? Date.defaultStartDate
        return (from, to)
    }
    
    static func mesePrecedente(calendar: Calendar) -> (from: Date, to: Date) {
        let nowComponents = Self.nowComponents(calendar: calendar)
        let beginOfMonth = calendar.date(from: DateComponents(calendar: calendar, year: nowComponents.year, month: nowComponents.month, day: 1))!
        let endOfPreviousMonth = calendar.date(byAdding: .day, value: -1, to: beginOfMonth)!
        let beginOfPreviousMonth = calendar.date(byAdding: .month, value: -1, to: beginOfMonth)!
        return (beginOfPreviousMonth, endOfPreviousMonth)
    }
    
    static func settimanaCorrente(calendar: Calendar) -> (from: Date, to: Date) {
        let to = Date()
        let bowComp = DateComponents(hour: 0, minute: 1, weekday: calendar.firstWeekday)
        let beginOfWeeKDate = calendar.nextDate(after: to, matching: bowComp, matchingPolicy: .nextTime, repeatedTimePolicy: .first, direction: .backward)
        return (beginOfWeeKDate!, to)
//        if calendar.isDateInWeekend(to) {
//            let lastWeekend = calendar.date(byAdding: .day, value: -14, to: to)!
//            let lastWeekendInterval = calendar.nextWeekend(startingAfter: lastWeekend)!
//            return (lastWeekendInterval.end, to)
//        } else {
//            let lastWeekend = calendar.date(byAdding: .day, value: -7, to: to)!
//            let lastWeekendInterval = calendar.nextWeekend(startingAfter: lastWeekend)!
//            return (lastWeekendInterval.end, to)
//        }
    }
    
    static func ultimaSettimana(calendar: Calendar) -> (from: Date, to: Date) {
        let to = Date()
        return (calendar.date(byAdding: .day, value: -6, to: to)!, to)
    }
    
    static func settimanaPrecedente(calendar: Calendar) -> (from: Date, to: Date) {
        let to = Date()
        if calendar.isDateInWeekend(to) {
            let lastWeekend = calendar.date(byAdding: .day, value: -14, to: to)!
            let lastWeekendInterval = calendar.nextWeekend(startingAfter: lastWeekend)!
            let toDate = lastWeekendInterval.end.addingTimeInterval(-1)
            let fromDate = calendar.date(byAdding: .day, value: -6, to: toDate)!
            return (fromDate, toDate)
        } else {
            let lastWeekend = calendar.date(byAdding: .day, value: -7, to: to)!
            let lastWeekendInterval = calendar.nextWeekend(startingAfter: lastWeekend)!
            let toDate = lastWeekendInterval.end.addingTimeInterval(-1)
            let fromDate = calendar.date(byAdding: .day, value: -6, to: toDate)!
            return (fromDate, toDate)
        }
    }
    
    static func oggi(calendar: Calendar) -> (from: Date, to: Date) {
        let today = Date()
        return (Date.beginOfDay(from: today), Date.endOfDay(from: today))
    }
    
    static func ieri(calendar: Calendar) -> (from: Date, to: Date) {
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())!
        return (Date.beginOfDay(from: yesterday), Date.endOfDay(from: yesterday))
    }
}

extension Date {
    static var defaultStartDate: Date {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .autoupdatingCurrent
        let nowComponents = calendar.dateComponents([.year, .month, .day, .minute, .second], from: Date())
        return calendar.date(from: DateComponents(calendar: calendar, year: nowComponents.year, month: nowComponents.month, day: 1)) ?? Date.defaultStartDate
    }
    
    static var beginOfYear: Date {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .autoupdatingCurrent
        let nowComponents = calendar.dateComponents([.year, .month, .day, .minute, .second], from: Date())
        return calendar.date(from: DateComponents(calendar: calendar, year: nowComponents.year, month: 1, day: 1)) ?? Date.defaultStartDate
    }
    
    static var beginOfMonth: Date {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .autoupdatingCurrent
        let nowComponents = calendar.dateComponents([.year, .month, .day, .minute, .second], from: Date())
        return Date.beginOfDay(from: calendar.date(from: DateComponents(calendar: calendar, year: nowComponents.year, month: nowComponents.month, day: 1))!)
    }
    
    static func endOfDay(from _date: Date) -> Date {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .autoupdatingCurrent
        return calendar.date(bySettingHour: 23, minute: 59, second: 59, of: _date)!
    }
    
    static func beginOfDay(from _date: Date) -> Date {
        Calendar(identifier: .gregorian).date(bySettingHour: 0, minute: 0, second: 1, of: _date)!
    }
    
    static func beginOfNextDay(from _date: Date) -> Date {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .autoupdatingCurrent
        let next = calendar.date(byAdding: .day, value: 1, to: _date)!
        return beginOfDay(from: next)
    }
    
    static var legalDistantPast: Date {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: "2000-01-01T00:00:00Z")!
    }
    
    static func date(from _dateString: String?, _timeString: String?) -> Date? {
        guard let dateString = _dateString, let timeString = _timeString else { return nil }
        guard dateString != "000000" else { return nil }
        var ts = timeString
        if ts.count == 4 {
            ts.append("00")
        }
        let stringDate = dateString + ts
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "it")
        dateFormatter.dateFormat = "yyMMddHHmmss"
        return dateFormatter.date(from: stringDate)
    }
    
    var ISO8601Formatted: String {
        let formatter = ISO8601DateFormatter()
        return formatter.string(from: self)
    }
}
