import Foundation
import Testing
@testable import studio_caffe_shared

struct NewisHIPriceListTests {
    @Test(arguments: ["ID1*D*PLATINUM EXE", "ID7*1*21*NIS*D*PLATINUM EXE*HIPE027T00"], [false, true])
    func normalizesBeforeAndAfterParsingWithoutLosingPricesOrVends(_ header: String, _ parseFirst: Bool) throws {
        let raw = [header, "LA1*0*1*50*2*20", "LA1*1*1*40*3*30",
                   "LA1*5*1*50*5*50", "LA1*5*101*50*7*70"].joined(separator: "\n")
        var parsed = try #require(ParsedAuditBeta(rawReport: raw))
        if parseFirst { parsed.parseReport() }
        let products = parsed.priceList()
        let product = try #require(products.first)
        #expect(products.count == 1 && product.code == "1")
        #expect(product.prices.count == 2)
        #expect(product.prices.first { $0.value == 0.50 }?.vends == 14)
        #expect(product.prices.first { $0.value == 0.40 }?.vends == 3)
    }

    @Test func onlyNormalizesTheDocumentedDeviceListAndRange() throws {
        let hi = try #require(ParsedAuditBeta(rawReport: "ID1*D*PLATINUM EXE"))
        #expect(hi.priceListProductCode(listNumber: 5, productCode: "101") == "1")
        #expect(hi.priceListProductCode(listNumber: 5, productCode: "200") == "100")
        for code in ["1", "100", "201", "301", "unknown"] {
            #expect(hi.priceListProductCode(listNumber: 5, productCode: code) == code)
        }
        for list in [0, 1, 2, 3, 4, 6, 7, 8] {
            #expect(hi.priceListProductCode(listNumber: list, productCode: "101") == "101")
        }
        for header in ["ID1*D*ELK ATTO COIN", "ID1*D*CF7900", "ID1*D*unknown"] {
            let parsed = try #require(ParsedAuditBeta(rawReport: header + "\nLA1*5*101*50*2*20"))
            #expect(parsed.priceList().map(\.code) == ["101"])
        }
    }

    @Test func keepsAnActualChannel101AndHandlesLoyaltyWithoutANormalSale() throws {
        let raw = "ID1*D*PLATINUM EXE\nLA1*0*101*80*1*10\nLA1*5*101*50*2*20"
        let parsed = try #require(ParsedAuditBeta(rawReport: raw))
        let products = parsed.priceList()
        #expect(Set(products.map(\.code)) == ["1", "101"])
        #expect(products.first { $0.code == "1" }?.prices.first?.value == 0.50)
        #expect(products.first { $0.code == "101" }?.prices.first?.value == 0.80)
    }

    @Test(arguments: ["missingReportOldFile", "missingReportNewFile"])
    func loyaltyCountersBelongToTheOriginalChannels(_ resource: String) throws {
        let url = try #require(Bundle.module.url(forResource: resource, withExtension: "txt"))
        let raw = try String(contentsOf: url, encoding: .utf8)
        let parsed = try #require(ParsedAuditBeta(rawReport: raw))
        let products = parsed.priceList()
        #expect(Set(products.map(\.code)) == ["1", "2", "3"])
        #expect(products.count == 3)
    }
}
