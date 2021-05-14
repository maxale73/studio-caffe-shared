//
//  File.swift
//  
//
//  Created by Massimo Di Leonardo on 14/05/21.
//

import Foundation

public enum QRCodeState: String {
    case generato
    case nonGenerato = "non generato"
    case nonValido = "non valido"
    
    public static func state(for deviceID: String, qrCode: String) -> Self {
        if qrCode.contains("https://ivaservizi.agenziaentrate.gov.it") {
            return .generato
        } else if deviceID == qrCode {
            return .nonGenerato
        } else {
            return .nonValido
        }
    }
}
