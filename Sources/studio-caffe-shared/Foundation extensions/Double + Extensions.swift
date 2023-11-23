//
//  Double + Extensions.swift
//  Studio Caffe App
//
//  Created by Massimo Di Leonardo on 25/03/21.
//

import Foundation

public let IVA: Double = 22.0

public extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func currencyFormatted() -> String {
        NumberFormatter.localizedString(from: NSNumber(value: self), number: .currencyAccounting)
    }
    
    func fourDigitsCurrencyFormatted() -> String {
        NumberFormatter.fourDigitsCurrencyFormatter().string(from: NSNumber(value: self))!
    }
    
    func decimalFormatted() -> String {
        NumberFormatter.localizedString(from: NSNumber(value: self), number: .decimal)
    }
    
    func percentFormatted() -> String {
        NumberFormatter.localizedString(from: NSNumber(value: self), number: .percent)
    }
    
    func iva() -> Double {
        self * (IVA / 100)
    }
    
    func piuIVA() -> Double {
        self * ((100 + IVA) / 100)
    }
    
    func scorporoIVA() -> Double {
        (100 * self) / (100 + IVA)
    }
    
    func round(granularity: Double) -> Double {
        ((self / granularity) * granularity).rounded()
    }
}

public extension NumberFormatter {
    
    static func decimalFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
    
    static func integerFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }
    
    static func fourDigitsCurrencyFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.minimumFractionDigits = 4
        return formatter
    }
}
