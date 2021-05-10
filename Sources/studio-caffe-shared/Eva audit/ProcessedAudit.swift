//
//  File.swift
//  
//
//  Created by Massimo Di Leonardo on 08/05/21.
//

import Foundation

public struct ProcessedAudit: Equatable, Codable {
    public let deviceID: String
    public let progressivoLettura: Int
    public let dataLettura: Date
    public let success: Bool
    public let message: String
}
