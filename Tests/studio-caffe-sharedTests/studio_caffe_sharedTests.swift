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
        
        let errors = new.validateImport(old: old)
        
        new.updateValues(from: errors)
        #expect(new.venduto_VA1_03 == 216.10)
        #expect(new.erogazioni_VA1_04 == 431)
        #expect(new.dataLetturaPrecedente.EVAStandardized == "250418*071300")
        #expect(new.valoreScontato_VA1_07 == 1.00)
        #expect(new.erogazioniScontate_VA1_08 == 10)
        #expect(new.valoreProve_VA2_03 == 1.00)
        #expect(new.erogazioniProva_VA2_04 == 10)
        #expect(new.valoreErogazioniGratuite_VA3_03 == 1.00)
        #expect(new.erogazioniGratuite_VA3_04 == 10)
    }
    
    @Test func resource() async throws {
        let oldFileURL = Bundle.module.url(forResource: "ELKATT_old_sample", withExtension: "txt")!
        let newFileURL = Bundle.module.url(forResource: "ELKATT_sample", withExtension: "txt")!
        let oldFile = try String(contentsOf: oldFileURL, encoding: .utf8)
        let newFile = try String(contentsOf: newFileURL, encoding: .utf8)
        
        var new = ParsedAuditBeta(rawReport: newFile)!
        var old = ParsedAuditBeta(rawReport: oldFile)!
        
        new.parseReport()
        old.parseReport()
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
        
        let errors = new.validateImport(old: old)
        
        #expect(errors.count == 1)
        let error = errors[0]
        #expect(error.isFixed == true)
        #expect(new.dataLetturaPrecedente.EVAStandardized == "250501*112900")
        print(errors)
    }
    
    @Test func optionalParsing() async throws {
        let optionalDate: Date? = .now
        let date: Date = .now
        
        print(optionalDate?.EVAStandardized)
        print(date.EVAStandardized)
        
        print(optionalDate?.textDescription)
        print(date.textDescription)
    }
}
    
