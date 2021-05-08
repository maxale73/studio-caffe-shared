//
//  String+Extensions.swift
//  macOS
//
//  Created by Massimo Di Leonardo on 17/04/21.
//

import Foundation

extension String {
    
    func commaSeparated() -> [String] {
        self.split(separator: ";").map{String($0)}
    }
}

extension Array where Element: StringProtocol {
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
}
