//
//  File.swift
//  
//
//  Created by Massimo Di Leonardo on 20/06/2020.
//

import Foundation

public enum InstallationType: String, Codable, Identifiable, CaseIterable, RawRepresentable {
    
    public var id: String {
        rawValue
    }
    case master
    case slave
    case associato
    case deposito
    case dismesso
}

extension InstallationType: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}
