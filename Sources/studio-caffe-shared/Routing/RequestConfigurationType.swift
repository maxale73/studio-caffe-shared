//
//  File.swift
//  
//
//  Created by Massimo Di Leonardo on 11/05/21.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public protocol RequestConfigurationType {
    var requiresToken: Bool { get }
    var clientRoute: String { get }
    var allowsCaching: Bool { get }
    var httpMethod: HTTPMethod { get set }
    var body: RequestBody? { get set }
    var loginString: String? { get set }
}

public extension RequestConfigurationType {
    var allowsCaching: Bool { false }
    var requiresToken: Bool { true }
}
