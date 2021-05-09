//
//  UserRole.swift
//  Studio Caffe App
//
//  Created by Massimo Di Leonardo on 14/08/20.
//

import Foundation

enum UserRole: String, Codable, CaseIterable, RawRepresentable {
    case amministratore
    case gestore
    case visitatore
}

extension UserRole: CustomStringConvertible {
    var description: String {
        rawValue
    }
}
