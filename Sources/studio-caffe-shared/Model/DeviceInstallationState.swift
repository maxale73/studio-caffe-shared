//
//  File.swift
//  
//
//  Created by Massimo Di Leonardo on 09/05/21.
//

import Foundation

public enum DeviceInstallationState: String, CaseIterable, RawRepresentable, Identifiable, Codable {
    
    public var id: String {
        rawValue
    }
    case uninstalled = "non installati"
    case installed = "installati"
}

extension DeviceInstallationState: CustomRawRepresentable {}
