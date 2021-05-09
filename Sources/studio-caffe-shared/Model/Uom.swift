//
//  File.swift
//  
//
//  Created by Massimo Di Leonardo on 14/04/21.
//

import Foundation

enum Uom: String, Codable, CaseIterable, Identifiable {
    var id: String { rawValue }
    case kg
    case pezzo = "pz"
}

extension Uom: CustomStringConvertible {
    var description: String {
        rawValue
    }
}
