import Testing
import Foundation
@testable import studio_caffe_shared

@Suite("Helpers Tests")
struct HelperTests {
    
    @Test func doubleExtensions() async throws {
        let num = 3.14
        #expect(num.EVAStandardized == "314")
    }
    
    @Test func comparingAudits() async throws {
        let oldFileURL = Bundle.module.url(forResource: "missingReportOldFile", withExtension: "txt")!
        let newFileURL = Bundle.module.url(forResource: "missingReportNewFile", withExtension: "txt")!
        let oldFile = try String(contentsOf: oldFileURL, encoding: .utf8)
        let newFile = try String(contentsOf: newFileURL, encoding: .utf8)
        
        var new = ParsedAuditBeta(rawReport: newFile)!
        var old = ParsedAuditBeta(rawReport: oldFile)!
        
        new.parseReport()
        old.parseReport()
        
        #expect(new.venduto_VA1_03 == 0.0)
        
        new.validateImport(old: old)
        let numberOfErrors = new.errors.count
        
        new.fixAllErrors()
        
        #expect(new.venduto_VA1_03 == 216.10)
        #expect(new.erogazioni_VA1_04 == 431)
        #expect(new.dataLetturaPrecedente.EVAStandardized == "250418*071300")
        #expect(new.valoreScontato_VA1_07 == 1.00)
        #expect(new.erogazioniScontate_VA1_08 == 10)
        #expect(new.valoreProve_VA2_03 == 1.00)
        #expect(new.erogazioniProva_VA2_04 == 10)
        #expect(new.valoreErogazioniGratuite_VA3_03 == 1.00)
        #expect(new.erogazioniGratuite_VA3_04 == 10)
        
        #expect(new.errors.count == numberOfErrors)
        #expect(new.errors.filter { $0.isFixed }.count == numberOfErrors)
    }
    
    @Test func manageSingleError() async throws {
        let oldFileURL = Bundle.module.url(forResource: "missingReportOldFile", withExtension: "txt")!
        let newFileURL = Bundle.module.url(forResource: "missingReportNewFile", withExtension: "txt")!
        let oldFile = try String(contentsOf: oldFileURL, encoding: .utf8)
        let newFile = try String(contentsOf: newFileURL, encoding: .utf8)
        
        var new = ParsedAuditBeta(rawReport: newFile)!
        var old = ParsedAuditBeta(rawReport: oldFile)!
        
        new.parseReport()
        old.parseReport()
        
        #expect(new.venduto_VA1_03 == 0.0)
        
        new.validateImport(old: old)
        
        #expect(new.venduto_VA1_03 == 0.0)
        let vendutoError = new.errors.first { $0.id == .VA1_03 }!
        new.manageError(vendutoError.id)
        
        #expect(new.venduto_VA1_03 == 216.10)
        let errorVenduto = new.errors.first { $0.id == .VA1_03 }
        #expect(errorVenduto?.isFixed == true)
        
        new.manageError(.VA1_03)
        #expect(new.venduto_VA1_03 == 0.0)
    }
    
    @Test func autofixDataRilevazionePrecedente() async throws {
        
        let newFile =
        """
        DXS*NIS HI! PE*VA*V0/6*1
        ST-1*001*0001
        ID1*821222440017*PLATINUM EXE**1**PLAEXEHI0000
        ID7*1*21*NIS*821222440017*PLATINUM EXE*HIPE027T00  
        EA3*17*250506*1129**250501*0607***17*17
        """
        
        let oldFile =
        """
        DXS*NIS HI! PE*VA*V0/6*1
        ST-1*001*0001
        ID1*821222440017*PLATINUM EXE**1**PLAEXEHI0000
        ID7*1*21*NIS*821222440017*PLATINUM EXE*HIPE027T00  
        EA3*16*250501*1129**250406*1128***16*16
        """
        
        var new = ParsedAuditBeta(rawReport: newFile)!
        var old = ParsedAuditBeta(rawReport: oldFile)!
        
        new.parseReport()
        old.parseReport()
        
        new.validateImport(old: old)
        
        #expect(new.errors.count == 1)
        let error = new.errors[0]
        #expect(error.isFixed == true)
        #expect(new.dataLetturaPrecedente.EVAStandardized == "250501*112900")
        
        new.revertFixedError(error: error)
        
        #expect(new.errors.count == 1)
        #expect(new.dataLetturaPrecedente.EVAStandardized == "250501*060700")
        #expect(new.errors[0].isFixed == false)
    }
    
    @Test func autofixDataRilevazionePrecedenteELKATT() async throws {
        let oldFileURL = Bundle.module.url(forResource: "ELKATT_old_sample", withExtension: "txt")!
        let newFileURL = Bundle.module.url(forResource: "ELKATT_sample", withExtension: "txt")!
        let oldFile = try String(contentsOf: oldFileURL, encoding: .utf8)
        let newFile = try String(contentsOf: newFileURL, encoding: .utf8)
        
        var new = ParsedAuditBeta(rawReport: newFile)!
        var old = ParsedAuditBeta(rawReport: oldFile)!
        
        new.parseReport()
        old.parseReport()
        
        new.validateImport(old: old)
        
        #expect(new.errors.count == 1)
        #expect(new.errors[0].isFixed == true)
        #expect(new.dataLetturaPrecedente.EVAStandardized == old.dataLettura.EVAStandardized)
        
    }
    
    @Test func controlloCassaContanti() async throws {
        let oldFileURL = Bundle.module.url(forResource: "controllo_cassa_old", withExtension: "txt")!
        let newFileURL = Bundle.module.url(forResource: "controllo_cassa_new", withExtension: "txt")!
        let oldFile = try String(contentsOf: oldFileURL, encoding: .utf8)
        let newFile = try String(contentsOf: newFileURL, encoding: .utf8)
        
        var new = ParsedAuditBeta(rawReport: newFile)!
        var old = ParsedAuditBeta(rawReport: oldFile)!
        
        new.parseReport()
        old.parseReport()
        
        new.validateImport(old: old)
        
        print(new.errors)
    }
    
//    @Test func optionalParsing() async throws {
//        let optionalDate: Date? = .now
//        let date: Date = .now
//        
//        print(optionalDate?.EVAStandardized)
//        print(date.EVAStandardized)
//        
//        print(optionalDate?.textDescription)
//        print(date.textDescription)
//        
//        let optionalDouble: Double? = 123.45
//        let double: Double = 123.45
//        let nilDouble: Double? = nil
//        
//        print(optionalDouble?.EVAStandardized)
//        print(double.EVAStandardized)
//        print(nilDouble?.EVAStandardized)
//        
//        print(optionalDouble?.textDescription)
//        print(double.textDescription)
//        print(nilDouble?.textDescription)
//    }
}
    
@Suite("Date Tests")
struct DateTests {
    
    @Test func testPastMonths() {
        let numberOfMonths = 15
        
        var intervals: [CustomTimeInterval] = []
        let sym = calendar.monthSymbols
        print(sym)
        for i in 0..<numberOfMonths {
            let interval = Date.pastMonths(calendar: .autoupdatingCurrent, offset: i)
            let _month = calendar.dateComponents([.month], from: interval.to)
            let sym = calendar.monthSymbols[_month.month! - 1]
            print(interval)
            intervals.append(interval)
        }
    }
}
