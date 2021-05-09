//
//  File.swift
//  
//
//  Created by Massimo Di Leonardo on 14/04/21.
//

import Foundation

enum ProductCategory: String, CaseIterable, RawRepresentable, Codable, Identifiable {
    
    var id: String { rawValue }
    
    case prodotti
    case ricambi
    case distributori
    case generiDiConsumo = "generi di consumo"
    case utenze
    case altro
    
}

extension ProductCategory: CustomStringConvertible {
    var description: String {
        rawValue
    }
}
