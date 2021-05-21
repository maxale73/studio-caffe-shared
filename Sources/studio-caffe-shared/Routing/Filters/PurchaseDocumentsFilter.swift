//
//  File.swift
//  
//
//  Created by Massimo Di Leonardo on 21/05/21.
//

import Foundation

public struct PurchaseDocumentsFilter: Codable, Equatable, Identifiable {
    
    public init(supplierID: UUID? = nil, from: Date, to: Date) {
        self.id = UUID()
        self.supplierID = supplierID
        self.from = from
        self.to = to
    }
    
    
    public var id: UUID
    public var supplierID: UUID?
    public var from: Date
    public var to: Date
    
    public var empty: Bool {
        supplierID == nil
    }
    
    public static var emptyFilter: PurchaseDocumentsFilter {
        PurchaseDocumentsFilter(supplierID: nil, from: .defaultStartDate, to: Date())
    }
}
