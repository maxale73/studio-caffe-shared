//
//  File.swift
//  
//
//  Created by Massimo Di Leonardo on 27/05/21.
//

import Foundation

public struct SellingPointBySP: Codable, Hashable, Identifiable, Sendable {
    public init(id: UUID, sellingPointID: Int, site: String, user: UserDTO, machines: [MachineBySP], brews: [BrewDTO], weekdays: [WeekdayDTO], communications: [ASLCommunicationDTO]) {
        self.id = id
        self.sellingPointID = sellingPointID
        self.site = site
        self.user = user
        self.machines = machines
        self.brews = brews
        self.weekdays = weekdays
        self.communications = communications
    }
    
    
    public var id: UUID
    public var sellingPointID: Int
    public var site: String
    
    public var user: UserDTO
    public var machines: [MachineBySP]
    
    public var brews: [BrewDTO]
    public var weekdays: [WeekdayDTO]
    public var communications: [ASLCommunicationDTO]
    
    public static func == (lhs: SellingPointBySP, rhs: SellingPointBySP) -> Bool {
        lhs.id == rhs.id
        && lhs.sellingPointID == rhs.sellingPointID
        && lhs.site == rhs.site
        && lhs.user == rhs.user
        && lhs.brews == rhs.brews
        && lhs.weekdays == rhs.weekdays
        && lhs.machines == rhs.machines
        && lhs.communications == rhs.communications
    }
    
    public var brewsDescription: String {
        var retString = ""
        guard !brews.isEmpty else {
            return "nessuna miscela selezionata"
        }
        let sb = brews.sorted(by: { $0.index >= $1.index })
        for b in sb {
            let isTop = b == sb.first
            let appendix = isTop ? " (T)" : ""
            retString.append(b.brewDescription + appendix + ", ")
        }
        retString.removeLast(2)
        return retString
    }
    
    public var weekdaysDescription: String {
        var retString = ""
        guard !weekdays.isEmpty else {
            return "nessun giorno selezionato"
        }
        let sw = weekdays.sorted(by: { $0.index <= $1.index })
        for wd in sw {
            retString.append(wd.weekdayDescription + ", ")
        }
        retString.removeLast(2)
        return retString
    }
    
    public var oneLinerDescription: String {
        var retString = ""
        retString.append(String(sellingPointID) + " \(site)")
        retString.append(" ")
        if let m = machines.first {
            retString.append("\(m.installation.rawValue.uppercased().first!) " + String(m.internalID))
            if let device = m.adeDevice {
                retString.append(" ")
                retString.append(device.adeID)
            }
            retString.append("\n\(m.model.makerPlusModel)")
        }
        return retString
    }
}

extension SellingPointBySP: CustomStringConvertible, RequestBody {
    public var description: String {
        "selling Point ID: \(sellingPointID), site: \(site), user: \(user.name)"
    }
}

public struct SellingPointEndpointsGroup: EndpointGroupType {
    
    public static var group: String { "sellingPoint" }
    
    public static func createWithAddress(sellingPoint: RequestBody? = nil, addressID: UUID? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "create_with_address", value: nil),
            PathParameter(name: "address_id", value: .uuid(addressID))
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: sellingPoint)
    }
    
    public static func update(sellingPoint: RequestBody? = nil) -> EndpointConfiguration {
        let parameters = [
            PathParameter(name: "update", value: nil)
        ]
        let constructor = PathConstructor(group: group, elements: parameters)
        return EndpointConfiguration(pathConstructor: constructor, method: .post, body: sellingPoint)
    }
}
