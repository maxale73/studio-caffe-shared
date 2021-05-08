//
//  File.swift
//  
//
//  Created by Massimo Di Leonardo on 08/05/21.
//

import Foundation

struct ProcessedAudit: Equatable, Codable {
    let deviceID: String
    let progressivoLettura: Int
    let dataLettura: Date
    let success: Bool
    let message: String
}
