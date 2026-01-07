//
//  Date + Extensions.swift
//  Studio Caffe App
//
//  Created by Massimo Di Leonardo on 13/12/20.
//

import Foundation

public let calendar: Calendar = .init(identifier: .gregorian)

public extension Date {
    
    static func nowComponents(calendar: Calendar) -> DateComponents {
        calendar.dateComponents([.year, .month, .day, .minute, .second], from: Date())
    }
    
    static func annoPrecedente(calendar: Calendar) -> (from: Date, to: Date) {
        let beginOfLastYear = calendar.date(byAdding: .year, value: -1, to: .beginOfYear)
        let endOfLastYearDay = calendar.date(byAdding: .day, value: -1, to: .beginOfYear)
        return (beginOfLastYear!, .endOfDay(from: endOfLastYearDay!))
    }
    
    static func pastYears(_calendar: Calendar, offset: Int) -> CustomTimeInterval {
        let nowComponents = _calendar.dateComponents([.year, .month, .day, .minute, .second], from: Date())
        let year = nowComponents.year! - offset
        let beginOfYear = _calendar.date(from: DateComponents(calendar: _calendar, year: year, month: 1, day: 1, hour: 0, minute: 1))
        let endOfYear = _calendar.date(from: DateComponents(calendar: _calendar, year: year, month: 12, day: 31, hour: 11, minute: 59))
        return .init(from: beginOfYear!, to: endOfYear!, intervalDescription: year.textDescription)
    }
    
    static func pastYearsIntervals(_calendar: Calendar, count: Int, includeCurrent: Bool = false) -> [CustomTimeInterval] {
        
        var intervals: [CustomTimeInterval] = []
        let range: CountableClosedRange<Int> = includeCurrent ? 0...count - 1 : 1...count
        
        for i in range {
            let interval = Date.pastYears(_calendar: _calendar, offset: i)
            intervals.append(interval)
        }
        return intervals
    }
    
    static func pastMonth(_calendar: Calendar, offset: Int) -> CustomTimeInterval {
        let nowComponents = _calendar.dateComponents([.year, .month, .day, .minute, .second], from: Date())
        let month = nowComponents.month! - offset
        let year = nowComponents.year
        let beginOfMonth = _calendar.date(from: DateComponents(calendar: _calendar, year: year, month: month, day: 1, hour: 0, minute: 1))
        let beginOfNextMonth = _calendar.date(from: DateComponents(calendar: _calendar, year: year, month: month + 1, day: 1, hour: 0, minute: 1))
        let _endOfMonth = _calendar.date(byAdding: .day, value: -1, to: beginOfNextMonth!)
        let endOfMonth = endOfDay(from: _endOfMonth!)
        
        let _month = _calendar.dateComponents([.month], from: endOfMonth)
        let sym = _calendar.monthSymbols[_month.month! - 1]
        
        return .init(from: beginOfMonth!, to: endOfMonth, intervalDescription: "\(sym) \(_calendar.component(.year, from: endOfMonth))")
    }
    
    static func pastMonthsIntervals(_calendar: Calendar, count: Int) -> [CustomTimeInterval] {
        
        var intervals: [CustomTimeInterval] = []
        
        for i in 1...count {
            let interval = Date.pastMonth(_calendar: _calendar, offset: i)
            intervals.append(interval)
        }
        return intervals
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
        return (.beginOfDay(from: from), .endOfDay(from: to))
    }
    
    static func ultimi3Mesi(calendar: Calendar) -> (from: Date, to: Date) {
        let to = Date()
        let from = calendar.date(byAdding: .month, value: -3, to: to) ?? Date.defaultStartDate
        return (.beginOfDay(from: from), .endOfDay(from: to))
    }
    
    static func ultimi6Mesi(calendar: Calendar) -> (from: Date, to: Date) {
        let to = Date()
        let from = calendar.date(byAdding: .month, value: -6, to: to) ?? Date.defaultStartDate
        return (.beginOfDay(from: from), endOfDay(from: to))
    }
    
    static func mesePrecedente(calendar: Calendar) -> (from: Date, to: Date) {
        let nowComponents = Self.nowComponents(calendar: calendar)
        let beginOfMonth = calendar.date(from: DateComponents(calendar: calendar, year: nowComponents.year, month: nowComponents.month, day: 1))!
        let endOfPreviousMonth = calendar.date(byAdding: .day, value: -1, to: beginOfMonth)!
        let beginOfPreviousMonth = calendar.date(byAdding: .month, value: -1, to: beginOfMonth)!
        return (.beginOfDay(from: beginOfPreviousMonth), .endOfDay(from: endOfPreviousMonth))
    }
    
    static func settimanaCorrente(calendar: Calendar) -> (from: Date, to: Date) {
        let to = Date()
        let bowComp = DateComponents(hour: 0, minute: 1, weekday: calendar.firstWeekday)
        let beginOfWeeKDate = calendar.nextDate(after: to, matching: bowComp, matchingPolicy: .nextTime, repeatedTimePolicy: .first, direction: .backward)
        return (beginOfWeeKDate!, endOfDay(from: to))
    }
    
    static func ultimaSettimana(calendar: Calendar) -> (from: Date, to: Date) {
        let to = Date()
        let from = calendar.date(byAdding: .day, value: -6, to: to)!
        return (.beginOfDay(from: from), to)
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
            let fromDate = calendar.date(byAdding: .day, value: -7, to: toDate)!
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

public extension Date {
    static var defaultStartDate: Date {
        var calendar = calendar
        calendar.timeZone = .autoupdatingCurrent
        let nowComponents = calendar.dateComponents([.year, .month, .day, .minute, .second], from: Date())
        return calendar.date(from: DateComponents(calendar: calendar, year: nowComponents.year, month: nowComponents.month, day: 1)) ?? .distantPast
    }
    
    static var beginOfYear: Date {
        var calendar = calendar
        calendar.timeZone = .autoupdatingCurrent
        let nowComponents = calendar.dateComponents([.year, .month, .day, .minute, .second], from: Date())
        return calendar.date(from: DateComponents(calendar: calendar, year: nowComponents.year, month: 1, day: 1)) ?? Date.defaultStartDate
    }
    
    static var beginOfMonth: Date {
        var calendar = calendar
        calendar.timeZone = .autoupdatingCurrent
        let nowComponents = calendar.dateComponents([.year, .month, .day, .minute, .second], from: Date())
        return Date.beginOfDay(from: calendar.date(from: DateComponents(calendar: calendar, year: nowComponents.year, month: nowComponents.month, day: 1))!)
    }
    
    static func endOfDay(from _date: Date) -> Date {
        var calendar = calendar
        calendar.timeZone = .autoupdatingCurrent
        return calendar.date(bySettingHour: 23, minute: 59, second: 59, of: _date)!
    }
    
    static func beginOfDay(from _date: Date) -> Date {
        calendar.date(bySettingHour: 0, minute: 0, second: 1, of: _date)!
    }
    
    static func beginOfNextDay(from _date: Date) -> Date {
        var calendar = calendar
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
    
    static func dateFromDashSplitted(_ dashSplitted: String) -> Date? {
        let stringComponents = dashSplitted.split(separator: "-")
        guard stringComponents.count == 3 else { return nil }
        let comp = DateComponents(calendar: calendar, timeZone: .autoupdatingCurrent, year: Int(stringComponents[0]), month: Int(stringComponents[1]), day: Int(stringComponents[2]), hour: 12, minute: 0)

        return calendar.date(from: comp)
    }
}
