import Foundation
import Testing
import studio_caffe_shared

struct PriceChannelSectorTests {
    @Test(arguments: ["11", "011", "x11", "Y28", " 011\n", "é11", "00"])
    func acceptsTwoDigitsWithAnOptionalSingleMachinePrefix(_ value: String) throws {
        let sector = try #require(PriceChannelSector(rawValue: value))
        #expect(sector.rawValue == value.trimmingCharacters(in: .whitespacesAndNewlines))
        #expect(sector.sectorNumber == Int(sector.rawValue.suffix(2)))
        #expect(sector.machinePrefix == String(sector.rawValue.dropLast(2)))
        #expect(PriceChannelDTO(index: 1, price1: 1, machineSectorCode: value).validationMessage == nil)
    }

    @Test(arguments: ["1", "1111", "001A", "11x", "x1", "-20", "1 1", "x１１", "x1a"])
    func rejectsCodesOutsideTheSectorFormat(_ value: String) {
        #expect(PriceChannelSector(rawValue: value) == nil)
        #expect(PriceChannelDTO(index: 1, price1: 1, machineSectorCode: value).validationMessage != nil)
    }

    @Test func permitsAbsentSectorsAndPreservesMachineIdentityIncludingZero() throws {
        for value in [nil, "", " \n"] as [String?] {
            #expect(PriceChannelDTO(index: 1, price1: 1, machineSectorCode: value).validationMessage == nil)
        }
        let sectors = try ["11", "011", "x11"].map { try #require(PriceChannelSector(rawValue: $0)) }
        #expect(Set(sectors).count == 3)
        #expect(sectors.map(\.sectorNumber) == [11, 11, 11])
        #expect(sectors.map(\.machinePrefix) == ["", "0", "x"])
    }
}
