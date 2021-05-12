//
//  File.swift
//  
//
//  Created by Massimo Di Leonardo on 12/05/21.
//

import Foundation

public struct ProductsFilter: Equatable, Codable, Identifiable {
    public var id: UUID
    public var textFilter: String
    
    public var empty: Bool {
        textFilter.isEmpty
    }
    
    public static var emptyFilter: ProductsFilter {
        ProductsFilter(id: UUID(), textFilter: "")
    }
}
