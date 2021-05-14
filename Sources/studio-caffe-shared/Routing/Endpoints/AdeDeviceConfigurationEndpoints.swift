//
//  File.swift
//  
//
//  Created by Massimo Di Leonardo on 14/05/21.
//

import Foundation

public struct AdeDeviceConfigurationDTO: Codable, Identifiable, Hashable {
    
    public var id: UUID
    
    public var coinAcceptor: CoinAcceptor
    public var billAcceptor: BillAcceptor
    public var appEnabled: Bool

    public init(
        id: UUID,
         
        coinnAcceptor: CoinAcceptor,
        billAcceptor: BillAcceptor,
        appEnabled: Bool)
    {
        self.id = id
        
        self.coinAcceptor = coinnAcceptor
        self.billAcceptor = billAcceptor
        self.appEnabled = appEnabled
    }
    
    public static func == (lhs: AdeDeviceConfigurationDTO, rhs: AdeDeviceConfigurationDTO) -> Bool {
    return
        lhs.id == rhs.id &&
        lhs.coinAcceptor == rhs.coinAcceptor &&
        lhs.billAcceptor == rhs.billAcceptor &&
        lhs.appEnabled == rhs.appEnabled
    }
}

public extension AdeDeviceConfigurationDTO {
    var confDescription: String {
        var retString = ""
        
        if coinAcceptor != .none {
            retString.append(coinAcceptor.coinAcceptorDescription + ", ")
        }
        
        if billAcceptor != .none {
            retString.append(billAcceptor.billAcceptorDescription + ", ")
        }
        
        if appEnabled {
            retString.append("app")
        } else {
            if retString.count > 0 {
                retString.removeLast(2)
            }
        }
        return retString
    }
    
    var shortDescription: String {
        
        var retString = ""
        
        if coinAcceptor != .none {
            retString.append("moneta, ")
        }
        
        if billAcceptor != .none {
            retString.append("banconote, ")
        }
        
        if appEnabled {
            retString.append("app")
        } else {
            if retString.count > 0 {
                retString.removeLast(2)
            }
        }
        return retString
    }
}

public struct AdeDeviceConfigurationEndpointsGroup {
    
    public static let group = "adeDeviceConfiguration"
    
    public static func indexWithFilter(filter: Body? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "index_with_filter", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: filter)
    }
    
    public static func save(customer: Body? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "save", value: nil),
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: customer)
    }
}

