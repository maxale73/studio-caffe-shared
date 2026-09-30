import Foundation
import Testing
@testable import studio_caffe_shared

struct EvaLineEndingsTests {
    private let lines = [
        "DXS*NIS HI! PE*VA*V0/6*1",
        "ID1*823042505198*PLATINUM EXE**1**PLAEXEHI0000",
        "VA1*497946*10024*10490*220",
        "CA2*42170*807*1350*26",
        "DA2*326786*6795*7160*147",
        "EA3*46*260928*1127**260921*1013***46*46",
        "DXE*1*1"
    ]

    @Test(arguments: ["\n", "\r\n", "\r"])
    func parsesLineEndingsWithoutLosingLastFields(_ newline: String) throws {
        try verify(lines.joined(separator: newline) + newline)
    }

    @Test func parsesMixedLineEndings() throws {
        let raw = lines.enumerated().map { index, line in
            line + (index.isMultiple(of: 2) ? "\r\n" : "\n")
        }.joined()
        try verify(raw)
    }

    private func verify(_ raw: String) throws {
        var parsed = try #require(ParsedAuditBeta(rawReport: raw))
        parsed.parseReport()
        #expect(parsed.rawReport == lines.joined(separator: "\n") + "\n")
        #expect(parsed.dispositivo == "823042505198")
        #expect(parsed.detectedDeviceModel == .NEWIS_HI)
        #expect(parsed.progressivoLettura == 46)
        #expect(parsed.dataLettura.EVAStandardized == "260928*112700")
        #expect(parsed.erogazioni == 220)
        #expect(parsed.numeroVenditeCash_CA2_04 == 26)
        #expect(parsed.erogazioniCashless1_DA2_04 == 147)
        #expect(parsed.venduto == 104.90)
    }
}
