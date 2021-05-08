//
//  File.swift
//  
//
//  Created by Massimo Di Leonardo on 08/05/21.
//

import Foundation

struct EvaBlock {
    var name: String
    var values: [String]
    
    var description: String {
        guard !values.isEmpty else { return "" }
        var retString = ""
        retString.append(name + "  ")
        for i in 1...values.count {
            retString.append("\(String(i)):\(values[i - 1]); ")
        }
        retString.removeLast(2)
        retString.append("\n")
        return retString
    }
    
    func stringValue(for blockNumber: Int) -> String? {
        guard blockNumber <= values.count else { return nil }
        return values[blockNumber - 1]
    }
    
    func intValue(for blockNumber: Int) -> Int? {
        guard blockNumber <= values.count else { return nil }
        if let num = Int(values[blockNumber - 1]) {
            return num
        } else {
            return nil
        }
    }
    
    func doubleValue(for blockNumber: Int) -> Double? {
        guard blockNumber <= values.count else { return nil }
        if let num = Double(values[blockNumber - 1]) {
            return num/100
        } else {
            return nil
        }
    }
}

struct Price: Identifiable, Hashable {
    let id: UUID = UUID()
    var value: Double
    var vends: Int
    
    mutating func increaseVends(v: Int) {
        vends += v
    }
}

struct Product: Equatable, Hashable {
    
    var code: String
    var prices: [Price]
    
    mutating func increaseVends(v: Int, for price: Double) {
        if var _price = prices.first(where: { $0.value == price }) {
            _price.increaseVends(v: v)
            var newPrices = prices
            newPrices.remove(at: prices.firstIndex(where: { $0.value == price })!)
            newPrices.append(_price)
            prices = newPrices
        } else {
            prices.append(Price(value: price, vends: v))
        }
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.code == rhs.code
    }
}
