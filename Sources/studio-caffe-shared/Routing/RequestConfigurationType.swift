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
    var body: Body? { get set }
}

public extension RequestConfigurationType {
    var allowsCaching: Bool { false }
    var requiresToken: Bool { true }
}

public struct AuditEndpointGroup {
    private static let group = "evaReport"
    public static func reports_reportsByMachine(machineID: Int? = nil, from: Date? = nil, to: Date? = nil) -> EndpointConfiguration {
        let parameters = [ PathParameter(name: "reports_by_machine", value: nil),
                           PathParameter(name: "id", value: .int(machineID)),
                           PathParameter(name: "from", value: .date(from)),
                           PathParameter(name: "to", value: .date(to))]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .get)
    }
}
