//
//  File.swift
//  
//
//  Created by Massimo Di Leonardo on 31/05/21.
//

import Foundation

public struct TallyDTO: Identifiable, Hashable {
    
    public init(id: UUID, tally: Double, audit: IDType) {
        self.id = id
        self.tally = tally
        self.audit = audit
    }
    
    public var id: UUID
    public var tally: Double
    public var audit: IDType
}
