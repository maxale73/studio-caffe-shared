//
//  String+Extensions.swift
//  macOS
//
//  Created by Massimo Di Leonardo on 17/04/21.
//

import Foundation

public extension String {
    
    func commaSeparated() -> [String] {
        self.split(separator: ";").map{String($0)}
    }
}

public extension Array where Element: StringProtocol {
    func toCommaSeparated() -> String {
        if self.isEmpty { return "" }
        var retString = ""
        for e in self {
            if !e.isEmpty {
                retString.append(contentsOf: e)
                retString.append(";")
            }
        }
        return !retString.isEmpty ? String(retString.dropLast()) : ""
    }
    
    func toNewLineSeparated() -> String {
        if self.isEmpty { return "" }
        var retString = ""
        for e in self {
            if !e.isEmpty {
                retString.append(contentsOf: e)
                retString.append("\n")
            }
        }
        return !retString.isEmpty ? String(retString.dropLast()) : ""
    }
    
    func toVerticalLineSeparated() -> String {
        guard !isEmpty else { return "" }
        let _n = reduce("") { partialResult, n in
            partialResult.appending(" | \(n)")
        }
        return String(_n.dropFirst(2))
    }
}

extension String: RequestBody {}
