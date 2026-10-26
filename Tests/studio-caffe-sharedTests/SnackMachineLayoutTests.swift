import Foundation
import Testing
import studio_caffe_shared

struct SnackMachineLayoutTests {
    @Test func reconstructsTheExampleWithPairedSelectionsAndMissingDrawers() {
        let sectors = [11, 13, 15] + Array(20...25) + Array(30...35) + Array(50...55) + Array(60...65)
        let channels = sectors.enumerated().map { index, sector in channel(index + 1, sector: String(sector)) }
        let layout = SnackMachineLayout(channels: channels.reversed())
        #expect(layout.columnCount == 6 && layout.firstPosition == 0)
        #expect(layout.drawers.map(\.number) == [1, 2, 3, 5, 6])
        #expect(layout.drawers.first?.selections.map(\.columns) == [0..<2, 2..<4, 4..<6])
        #expect(layout.drawers.dropFirst().allSatisfy { $0.selections.count == 6 && $0.selections.allSatisfy { $0.columnSpan == 1 } })
        #expect(layout.unplacedChannels.isEmpty && layout.drawers.allSatisfy { !$0.hasUnresolvedGaps })
        #expect(layout.drawers.flatMap(\.selections).map(\.channel) == channels)
    }

    @Test func supportsPairsWhoseCodesMarkTheFirstPosition() {
        let channels = ([10, 12, 14] + Array(20...25)).enumerated().map { channel($0.offset + 1, sector: String($0.element)) }
        let layout = SnackMachineLayout(channels: channels)
        #expect(layout.drawers.first?.selections.map(\.columns) == [0..<2, 2..<4, 4..<6])
    }

    @Test func infersSixPositionsEvenWhenAllDrawersArePaired() {
        let channels = [11, 13, 15, 21, 23, 25].enumerated().map { channel($0.offset + 1, sector: String($0.element)) }
        let layout = SnackMachineLayout(channels: channels)
        #expect(layout.columnCount == 6)
        #expect(layout.drawers.allSatisfy { $0.selections.map(\.columnSpan) == [2, 2, 2] })
    }

    @Test(arguments: [3, 4, 5, 6, 7, 8])
    func supportsBothNumberingOriginsAndDifferentMachineWidths(_ columns: Int) {
        for origin in [0, 1] {
            let channels = (origin..<(origin + columns)).map { channel($0 + 1, sector: String(20 + $0)) }
            let layout = SnackMachineLayout(channels: channels)
            #expect(layout.columnCount == columns && layout.firstPosition == origin)
            #expect(layout.drawers.count == 1 && layout.drawers[0].selections.count == columns)
            #expect(layout.drawers[0].selections.map(\.columns) == (0..<columns).map { $0..<($0 + 1) })
        }
    }

    @Test func strictModePreservesUnmappedAndConflictingChannels() {
        let values = [channel(1, sector: nil), channel(2, sector: ""), channel(3, sector: "001A"),
                      channel(4, sector: "11"), channel(5, sector: "011"), channel(6, sector: "-20"),
                      channel(7, sector: "29"), channel(8, sector: "999999999999999999999999999"),
                      channel(9, sector: "21.5"), channel(10, sector: "5")]
        let layout = SnackMachineLayout(channels: values + [channel(100, sector: "20", type: .hot)], useChannelIndexForMissingSector: false)
        #expect(layout.drawers.isEmpty && layout.columnCount == 0)
        #expect(layout.unplacedChannels.map(\.channel) == values)
        #expect(layout.unplacedChannels.map(\.reason) == [.missingSector, .missingSector, .invalidSector,
            .duplicateSector, .duplicateSector, .invalidSector, .incompatibleNumbering, .invalidSector, .invalidSector, .invalidSector])
    }

    @Test func usesThePriceChannelIndexWhenTheSectorIsMissingOrBlank() {
        let values = [channel(11, sector: nil), channel(13, sector: ""), channel(15, sector: " \n")]
            + (20...25).map { channel($0, sector: nil) }
        let layout = SnackMachineLayout(channels: values)
        #expect(layout.columnCount == 6 && layout.unplacedChannels.isEmpty)
        #expect(layout.drawers[0].selections.map(\.columns) == [0..<2, 2..<4, 4..<6])
        #expect(layout.drawers.flatMap(\.selections).allSatisfy { $0.sector == $0.channel.index })
        #expect(layout.drawers.flatMap(\.selections).map(\.channel) == values)
    }

    @Test func explicitSectorsWinAndFallbackCodesStillParticipateInConflictValidation() {
        let values = [channel(1, sector: "21"), channel(2, sector: nil),
                      channel(20, sector: nil), channel(99, sector: "020")]
        let layout = SnackMachineLayout(channels: values)
        #expect(layout.drawers[0].selections.map(\.sector) == [21])
        #expect(layout.drawers[0].selections.first?.channel.index == 1)
        #expect(layout.unplacedChannels.map(\.channel.index) == [2, 20, 99])
        #expect(layout.unplacedChannels.map(\.reason) == [.invalidSector, .duplicateSector, .duplicateSector])
    }

    @Test func gapsLargerThanAPairRemainUnresolvedInsteadOfStretchingASelection() {
        let channels = ([10, 13, 15] + Array(20...25)).enumerated().map { channel($0.offset + 1, sector: String($0.element)) }
        let layout = SnackMachineLayout(channels: channels)
        #expect(layout.drawers[0].hasUnresolvedGaps)
        #expect(layout.drawers[0].selections.allSatisfy { $0.columnSpan == 1 })
        #expect(layout.drawers[0].cells.map(\.columns) == [0..<1, 1..<3, 3..<4, 4..<5, 5..<6])
        #expect(layout.drawers[0].selections.map(\.sector) == [10, 13, 15])
    }

    @Test func snackTypeSectorAndPriceIndexHaveDistinctMeaningsAndDataRemainsExact() throws {
        var snack = channel(102, sector: "  011\n")
        snack.price1 = Decimal(string: "0.80")!
        snack.description = "Pipas"
        let values = [snack, channel(1, sector: "20"), channel(2, sector: "21"), channel(3, sector: "22"),
                      channel(200, sector: "12", type: .undefined), channel(201, sector: "13", type: .hot)]
        let layout = SnackMachineLayout(channels: values)
        let selection = try #require(layout.drawers.first?.selections.first)
        #expect(selection.sector == 11 && selection.channel.index == 102)
        #expect(selection.channel.price1 == Decimal(string: "0.80") && selection.channel.description == "Pipas")
        #expect(layout.drawers.flatMap(\.selections).count == 4)
    }

    @Test func contradictoryZeroAndEightPositionsDoNotCreateANineColumnMachine() {
        let values = [20, 21, 22, 23, 24, 25, 26, 27, 28].enumerated().map { channel($0.offset + 1, sector: String($0.element)) }
        let layout = SnackMachineLayout(channels: values)
        #expect(layout.columnCount == 8 && layout.drawers[0].selections.count == 8)
        #expect(layout.unplacedChannels.map(\.channel.machineSectorCode) == ["28"])
        #expect(layout.unplacedChannels.first?.reason == .incompatibleNumbering)
    }

    @Test func emptyAndNonSnackListsProduceAnEmptyDiagram() {
        for channels in [[], [channel(1, sector: "11", type: .hot)]] {
            let layout = SnackMachineLayout(channels: channels)
            #expect(layout.columnCount == 0 && layout.drawers.isEmpty && layout.unplacedChannels.isEmpty)
        }
    }

    private func channel(_ index: Int, sector: String?, type: PriceChannelType = .snack) -> PriceChannelDTO {
        .init(index: index, type: type, price1: Decimal(index) / 10, description: "Prodotto \(index)", machineSectorCode: sector)
    }
}
