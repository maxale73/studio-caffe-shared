    import Testing
    @testable import studio_caffe_shared

@Suite("Helpers Tests")
struct HelperTests {
    
    let new = """
    DXS*NIS HI! PE*VA*V0/6*1
    ST-1*001*0001
    ID1*821222440017*PLATINUM EXE**1**PLAEXEHI0000
    ID7*1*21*NIS*821222440017*PLATINUM EXE*HIPE027T00  
    VA1*211695*4173*0*0*100*10*0*0
    VA2*100*10*0*0
    VA3*100*10*0*0
    CA1*000000000000*000000000000*0000
    CA2*148070*2940*0*0
    CA3*0*0*0*0*298855*209335*89520*0*0*0
    CA4*0*0*84070*100
    CA8*0*1110
    CA10*0*0
    CA11*5*0*0*0*179*43*136
    CA11*10*0*0*0*685*313*372
    CA11*20*0*0*0*553*347*206
    CA11*50*0*0*0*1961*613*1348
    CA11*100*0*0*0*786*664*122
    CA11*200*0*0*0*517*510*7
    CA15*5905
    CA17*2*20*69
    CA17*3*50*65
    CA17*4*100*0
    CA17*5*200*0
    BA1*ACCETTATORE     *SMILE           *0
    DA1*821222440017*PLATINUM EXE*0027
    DA2*63625*1233*0*0
    DA5*0*0*0*0
    DA9*0*0
    DB1*MOBILE APP  *CREDIT CARD *0000
    DB2*0*0*0*0
    DB3*0*0
    DB4*0*0
    LA1*0*1*50*0*2572
    LA1*0*2*60*0*281
    LA1*0*3*70*0*0
    LA1*1*1*50*0*994
    LA1*1*2*60*0*226
    LA1*1*3*70*0*0
    LA1*2*1*50*0*0
    LA1*2*2*60*0*0
    LA1*2*3*70*0*0
    LA1*3*1*50*0*0
    LA1*3*2*60*0*0
    LA1*3*3*70*0*0
    LA1*4*1*50*0*0
    LA1*4*2*60*0*0
    LA1*4*3*70*0*0
    LA1*5*1*50*0*0
    LA1*5*2*60*0*0
    LA1*5*3*70*0*0
    LA1*5*101*50*0*0
    LA1*5*102*60*0*0
    LA1*5*103*70*0*0
    LA1*6*1**0*0
    LA1*6*2**0*0
    LA1*6*3**0*0
    LA1*6*101**0*0
    LA1*6*102**0*0
    LA1*6*103**0*0
    LA1*6*201**0*0
    LA1*6*202**0*0
    LA1*6*203**0*0
    LA1*6*301**0*0
    LA1*6*302**0*0
    LA1*6*303**0*0
    LA1*7*1**0*0
    LA1*7*2**0*1110
    LA1*7*3**0*0
    LA1*7*4**0*0
    LA1*7*5**0*2610
    LA1*7*6**0*365
    LA1*7*17**0*68315
    LA1*7*18**0*0
    LA1*7*19**0*0
    LA1*7*20**0*0
    LA1*7*21**0*0
    LA1*7*22**0*0
    LA1*7*23**0*0
    LA1*7*24**0*0
    LA1*7*26**0*0
    LA1*7*27**0*0
    LA1*7*28**0*0
    LA1*7*29**0*0
    LA1*7*30**0*0
    LA1*7*31**0*87
    LA1*7*32**0*13
    LA1*7*33**0*0
    LA1*7*34**0*0
    LA1*7*35**0*0
    LA1*7*36**0*0
    LA1*7*37**0*0
    LA1*7*101**0*0
    LA1*7*102**0*0
    LA1*7*103**0*0
    LA1*8*1*50*0*0
    LA1*8*2*60*0*0
    LA1*8*3*70*0*0
    PA1*1*50*LINEA PREZZO 1  ****0
    PA2*3566*178300*0*0*0*0*0*0
    PA4*0*0*0*0
    PA1*2*60*LINEA PREZZO 2  ****0
    PA2*507*30420*0*0*0*0*0*0
    PA4*0*0*0*0
    PA1*3*70*LINEA PREZZO 3  ****0
    PA2*0*0*0*0*0*0*0*0
    PA4*0*0*0*0
    EA2*NE1*0*0
    EA2*NE2*0*11
    EA2*NE3*0*0
    EA2*NE4*0*0
    EA2*NE5*0*0
    EA2*NE6*0*0
    EA2*NE7*0*0
    EA2*NE8*0*1
    EA2*NE9*0*2
    EA2*NE10*0*0
    EA2*NE11*0*0
    EA2*NE12*0*0
    EA2*NE13*0*0
    EA2*NE14*0*0
    EA2*NE15*0*0
    EA2*NE16*0*0
    EA2*NSA*0*2196
    EA2*NSB*0*627
    EA2*NSC*0*0
    EA2*NSD*0*43
    EA2*NSE*21008*8213
    EA2*NSF*0*2
    EA3*16*250506*1129**250506*1128***16*16
    EA7*0*0
    G85*b891
    SE-1*135*0001
    CA17*0*5*87*0
    CA17*1*10*84**0
    CA7*0**0**0
    CA9*0
    DA10**0
    DA3*63625*0*0
    DA4*65705*0*0
    TA2***0****0
    @$1*HI*37*ID101*821222440017**p
    @$2*Type*Periodo
    @$3*Progressivo*14738
    @$4*Formato*COR10
    @$5*Tipo*DA
    @$6*IdDispositivo*02069690671821222440017
    @$7*Lat*42.8706
    @$8*Long*13.7556
    @$9*DataOraRilevazione*2025-05-06T11:29:00
    @$10*Venduto*0.00
    @$11*VendutoContante*0.00
    @$12*VendutoNoContante*0.00
    @$13*Incassato*0.00
    @$14*IncassatoRicarica*0.00
    @$15*IncassatoVendita*0.00
    @$16*TotaleResoTubiResto*0.00
    @$17*TotaleCaricatoTubiResto*0.00
    @$18*TotaleResoManualeTubiResto*0.00
    @$19*TotaleCaricatoManualeTubiResto*0.00
    @$20*DataOraPrelievoPrec*2025-05-06T11:28:00
    @$21*ProgressivoPrelievo*16
    @$52*Type*Cumulato
    @$53*Progressivo*14738
    @$54*Formato*COR10
    @$55*Tipo*DA
    @$56*IdDispositivo*02069690671821222440017
    @$57*Lat*42.8706
    @$58*Long*13.7556
    @$59*DataOraRilevazione*2025-05-06T11:29:00
    @$60*Venduto*2116.95
    @$61*VendutoContante*1480.70
    @$62*VendutoNoContante*636.25
    @$63*Incassato*2988.55
    @$64*IncassatoRicarica*657.05
    @$65*IncassatoVendita*2331.50
    @$66*TotaleResoTubiResto*840.70
    @$67*TotaleCaricatoTubiResto*895.20
    @$68*TotaleResoManualeTubiResto*1.00
    @$69*TotaleCaricatoManualeTubiResto*0.00
    @$70*DataOraPrelievoPrec*2025-05-06T11:28:00
    @$71*ProgressivoPrelievo*16
    @$91*Prova*N
    @$92*CodDis*510
    DXE*1*1
    """
    
    let old = """
        DXS*NIS HI! PE*VA*V0/6*1
        ST-1*001*0001
        ID1*821222440017*PLATINUM EXE**1**PLAEXEHI0000
        ID7*1*21*NIS*821222440017*PLATINUM EXE*HIPE027T00  
        VA1*190085*3742*9740*193*0*0*0*0
        VA2*0*0*0*0
        VA3*0*0*0*0
        CA1*000000000000*000000000000*0000
        CA2*132700*2632*5750*114
        CA3*12555*9150*3405*0*268835*188245*80590*0*0*0
        CA4*3385*0*75000*100
        CA8*0*1110
        CA10*0*0
        CA11*5*5*0*5*167*43*124
        CA11*10*20*16*4*632*268*364
        CA11*20*24*12*12*479*280*199
        CA11*50*81*19*62*1756*581*1175
        CA11*100*30*30*0*723*601*122
        CA11*200*24*24*0*460*453*7
        CA15*6045
        CA17*2*20*74
        CA17*3*50*67
        CA17*4*100*0
        CA17*5*200*0
        BA1*ACCETTATORE     *SMILE           *0
        DA1*821222440017*PLATINUM EXE*0027
        DA2*57385*1110*3990*79
        DA5*0*0*0*0
        DA9*0*0
        DB1*MOBILE APP  *CREDIT CARD *0000
        DB2*0*0*0*0
        DB3*0*0
        DB4*0*0
        LA1*0*1*50*103*2279
        LA1*0*2*60*9*272
        LA1*0*3*70*0*0
        LA1*1*1*50*75*883
        LA1*1*2*60*4*215
        LA1*1*3*70*0*0
        LA1*2*1*50*0*0
        LA1*2*2*60*0*0
        LA1*2*3*70*0*0
        LA1*3*1*50*0*0
        LA1*3*2*60*0*0
        LA1*3*3*70*0*0
        LA1*4*1*50*0*0
        LA1*4*2*60*0*0
        LA1*4*3*70*0*0
        LA1*5*1*50*0*0
        LA1*5*2*60*0*0
        LA1*5*3*70*0*0
        LA1*5*101*50*0*0
        LA1*5*102*60*0*0
        LA1*5*103*70*0*0
        LA1*6*1**0*0
        LA1*6*2**0*0
        LA1*6*3**0*0
        LA1*6*101**0*0
        LA1*6*102**0*0
        LA1*6*103**0*0
        LA1*6*201**0*0
        LA1*6*202**0*0
        LA1*6*203**0*0
        LA1*6*301**0*0
        LA1*6*302**0*0
        LA1*6*303**0*0
        LA1*7*1**0*0
        LA1*7*2**0*1110
        LA1*7*3**0*0
        LA1*7*4**0*0
        LA1*7*5**60*2430
        LA1*7*6**0*335
        LA1*7*17**3420*62555
        LA1*7*18**0*0
        LA1*7*19**0*0
        LA1*7*20**0*0
        LA1*7*21**0*0
        LA1*7*22**0*0
        LA1*7*23**0*0
        LA1*7*24**0*0
        LA1*7*26**0*0
        LA1*7*27**0*0
        LA1*7*28**0*0
        LA1*7*29**0*0
        LA1*7*30**0*0
        LA1*7*31**2*81
        LA1*7*32**0*12
        LA1*7*33**0*0
        LA1*7*34**0*0
        LA1*7*35**0*0
        LA1*7*36**0*0
        LA1*7*37**0*0
        LA1*7*101**0*0
        LA1*7*102**0*0
        LA1*7*103**0*0
        LA1*8*1*50*0*0
        LA1*8*2*60*0*0
        LA1*8*3*70*0*0
        PA1*1*50*LINEA PREZZO 1  ****0
        PA2*3162*158100*178*8900*0*0*0*0
        PA4*0*0*0*0
        PA1*2*60*LINEA PREZZO 2  ****0
        PA2*487*29220*13*780*0*0*0*0
        PA4*0*0*0*0
        PA1*3*70*LINEA PREZZO 3  ****0
        PA2*0*0*0*0*0*0*0*0
        PA4*0*0*0*0
        EA2*NE1*0*0
        EA2*NE2*0*11
        EA2*NE3*0*0
        EA2*NE4*0*0
        EA2*NE5*0*0
        EA2*NE6*0*0
        EA2*NE7*0*0
        EA2*NE8*0*1
        EA2*NE9*0*2
        EA2*NE10*0*0
        EA2*NE11*0*0
        EA2*NE12*0*0
        EA2*NE13*0*0
        EA2*NE14*0*0
        EA2*NE15*0*0
        EA2*NE16*0*0
        EA2*NSA*120*1993
        EA2*NSB*32*551
        EA2*NSC*0*0
        EA2*NSD*0*38
        EA2*NSE*21008*8213
        EA2*NSF*0*2
        EA3*14*250418*0713**250411*134100***14*14
        EA7*0*0
        G85*33ab
        SE-1*135*0001
        CA17*0*5*75*0
        CA17*1*10*84**0
        CA7*0**0**0
        CA9*0
        DA10**0
        DA3*57385*3990*0
        DA4*60125*3420*0
        TA2***0****0
        @$1*HI*37*ID101*821222440017**p
        @$2*Type*Periodo
        @$3*Progressivo*14598
        @$4*Formato*COR10
        @$5*Tipo*DA
        @$6*IdDispositivo*02069690671821222440017
        @$7*Lat*42.8706
        @$8*Long*13.7557
        @$9*DataOraRilevazione*2025-04-18T07:13:00
        @$10*Venduto*97.40
        @$11*VendutoContante*57.50
        @$12*VendutoNoContante*39.90
        @$13*Incassato*125.55
        @$14*IncassatoRicarica*34.20
        @$15*IncassatoVendita*91.35
        @$16*TotaleResoTubiResto*33.85
        @$17*TotaleCaricatoTubiResto*34.05
        @$18*TotaleResoManualeTubiResto*0.00
        @$19*TotaleCaricatoManualeTubiResto*0.00
        @$20*DataOraPrelievoPrec*2025-04-11T13:40:00
        @$21*ProgressivoPrelievo*14
        @$52*Type*Cumulato
        @$53*Progressivo*14598
        @$54*Formato*COR10
        @$55*Tipo*DA
        @$56*IdDispositivo*02069690671821222440017
        @$57*Lat*42.8706
        @$58*Long*13.7557
        @$59*DataOraRilevazione*2025-04-18T07:13:00
        @$60*Venduto*1900.85
        @$61*VendutoContante*1327.00
        @$62*VendutoNoContante*573.85
        @$63*Incassato*2688.35
        @$64*IncassatoRicarica*601.25
        @$65*IncassatoVendita*2087.10
        @$66*TotaleResoTubiResto*750.00
        @$67*TotaleCaricatoTubiResto*805.90
        @$68*TotaleResoManualeTubiResto*1.00
        @$69*TotaleCaricatoManualeTubiResto*0.00
        @$70*DataOraPrelievoPrec*2025-04-11T13:40:00
        @$71*ProgressivoPrelievo*14
        @$91*Prova*N
        @$92*CodDis*510
        DXE*1*1
        """
    @Test func doubleExtensions() async throws {
        let num = 3.14
        #expect(num.EVAStandardized == "314")
    }
    
    @Test func comparingAudits() async throws {
        var new = ParsedAuditBeta(rawReport: new)!
        var old = ParsedAuditBeta(rawReport: old)!
        
        new.parseReport()
        #expect(new.venduto_VA1_03 == 0.0)
        old.parseReport()
        
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
}
    
