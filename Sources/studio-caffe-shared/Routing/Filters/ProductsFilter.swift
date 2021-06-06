//
//  File.swift
//  
//
//  Created by Massimo Di Leonardo on 12/05/21.
//

import Foundation

public struct ProductsFilter: Equatable, Codable, Identifiable {
    
    public init(textFilter: String = "", supplierID: UUID? = nil, category: ProductCategory? = nil) {
        self.id = UUID()
        self.supplierID = supplierID
        self.category = category
        self.textFilter = textFilter
    }
    
    
    public var id: UUID
    public var supplierID: UUID?
    public var category: ProductCategory?
    public var textFilter: String
    
    public var empty: Bool {
        textFilter.isEmpty
    }
    
    public static var emptyFilter: ProductsFilter {
        ProductsFilter()
    }
}
