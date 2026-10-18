import Foundation

public enum ProductCategory: String, CaseIterable, RawRepresentable, Codable, Identifiable, Sendable {
    
    public var id: String { rawValue }
    
    case undefined
    case C_13_05_045
    
//    case C_73_01_550 //old
    case C_73_01_551
    case C_73_01_552
    case C_73_01_553
    case C_73_01_554
    
//    case C_73_01_560 //old
    case C_73_01_561
    case C_73_01_562
    case C_73_01_563
    case C_73_01_564
    
    case C_73_01_565
    case C_73_01_555
    
    case C_73_01_533
    case C_73_01_534
    case C_73_01_535
    
    case C_73_09_501
    case C_73_09_502
    case C_73_09_503
    case C_73_09_069
    
    case C_73_01_017
    case C_73_09_006
    case C_75_01_025
    
    case C_75_11_509

    case C_60_01_169

    case C_73_09_005
    case C_73_09_045
    case C_73_09_049
    case C_73_09_053
    case C_73_09_077
    case C_73_09_078
    case C_73_09_122
    case C_73_09_500

    case C_75_01_022
    case C_75_01_037

    case C_75_05_041
    case C_75_05_109

    case C_75_11_026
    case C_75_11_109
    case C_75_11_114
    case C_75_11_133
    case C_75_11_500
    case C_75_11_513

    case C_75_13_037
    case C_75_13_551

    case C_75_15_021
    case C_75_15_077

    case C_75_17_049
    case C_75_17_081
    case C_75_17_300
    case C_75_17_301
    case C_75_17_505
    case C_75_17_540
    case C_75_17_542
    case C_75_17_543
    case C_75_17_575

    case C_77_01_009

    case C_77_05_065

    case C_77_07_013

    case C_79_01_001

    case C_79_03_001
    case C_79_03_005

    case C_79_05_005

    case C_79_09_037

    case C_81_01_009

    case C_81_03_021

    case C_83_05_009
    case C_83_05_021
    case C_83_05_037
    case C_83_05_045

    case C_83_07_005

    case C_83_09_005
    case C_83_09_061
    case C_83_09_077

    case C_89_01_009
    case C_89_01_013

    case C_91_01_033

    case C_92_01_001
    case C_92_01_013
    case C_92_01_033
    case C_92_01_041
    case C_92_01_085
    case C_92_01_089
    case C_92_01_097
    case C_92_01_113
    case C_92_01_141
    case C_92_01_154

    case C_93_15_029
    case C_93_15_045
    case C_93_15_049
    case C_93_15_082

    case C_96_01_001
    case C_96_01_005
}

extension ProductCategory: CustomStringConvertible {
    public var description: String {
        switch self {
        case .undefined: return "non classificato"
        case .C_13_05_045: return "distributori automatici (13.05.045)"
            
//        case .C_73_01_550: return "snack/bibite automatico (73.01.550)" //old
        case .C_73_01_551: return "acqua (73.01.551)"
        case .C_73_01_552: return "altre bibite (73.01.552)"
        case .C_73_01_553: return "snack (73.01.553)"
        case .C_73_01_554: return "freschi (73.01.554)"
            
//        case .C_73_01_560: return "caldo automatico (73.01.560)" //old
        case .C_73_01_561: return "caffè in grani (73.01.561)"
        case .C_73_01_562: return "caffè in cialda (73.01.562)"
        case .C_73_01_563: return "accessori automatico (73.01.563)"
        case .C_73_01_564: return "solubili (73.01.564)"
            
        case .C_73_01_565: return "OCS (73.01.565)"
        case .C_73_01_555: return "boccioni (73.01.555)"
            
        case .C_73_01_533: return "Gettoniere/rendiresto/lettori banconote (73.01.533)"
        case .C_73_01_534: return "Sistemi cashless (73.01.534)"
        case .C_73_01_535: return "Altri componenti distributori (73.01.535)"
            
        case .C_73_09_501: return "materiale manutenzione distributori (73.09.501)"
        case .C_73_09_502: return "ricambi freddo (73.09.502)"
        case .C_73_09_503: return "ricambi caldo (73.09.503)"
        case .C_73_09_069: return "abbigliamento del personale (73.09.069)"
            
        case .C_73_01_017: return "materiale di consumo (73.01.017)"
        case .C_73_09_006: return "carburanti (73.09.006)"
        case .C_75_01_025: return "energia elettrica (75.01.025)"
        case .C_75_11_509: return "ristorni (75.11.509)"

        case .C_60_01_169: return "differenze su incasso distributori (60.01.169)"

        case .C_73_09_005: return "materiali per pulizia (73.09.005)"
        case .C_73_09_045: return "cancelleria e stampati (73.09.045)"
        case .C_73_09_049: return "materiale pubblicitario (73.09.049)"
        case .C_73_09_053: return "trasporti su acquisti (73.09.053)"
        case .C_73_09_077: return "beni inferiori a 516 euro (73.09.077)"
        case .C_73_09_078: return "beni inferiori a 516 euro (cellulari) (73.09.078)"
        case .C_73_09_122: return "altri acquisti indeducibili (73.09.122)"
        case .C_73_09_500: return "piccola attrezzatura di consumo (73.09.500)"

        case .C_75_01_022: return "lavorazioni esterne per servizi (75.01.022)"
        case .C_75_01_037: return "acqua (utenza) (75.01.037)"

        case .C_75_05_041: return "manutenzione impianto d'allarme (75.05.041)"
        case .C_75_05_109: return "manutenzione autocarri (75.05.109)"

        case .C_75_11_026: return "compensi amministratori co.co.co. soci (75.11.026)"
        case .C_75_11_109: return "servizi amministrativi (75.11.109)"
        case .C_75_11_114: return "spese telefonia mobile (75.11.114)"
        case .C_75_11_133: return "spese per comunicazioni semestrali (75.11.133)"
        case .C_75_11_500: return "spese per PEC e servizi internet (75.11.500)"
        case .C_75_11_513: return "consulenze tenuta contabilità/paghe (75.11.513)"

        case .C_75_13_037: return "spese di pubblicità (75.13.037)"
        case .C_75_13_551: return "consulenza su sicurezza e HACCP (75.13.551)"

        case .C_75_15_021: return "assicurazioni autocarri (75.15.021)"
        case .C_75_15_077: return "assicurazioni non obbligatorie (75.15.077)"

        case .C_75_17_049: return "costi per buoni pasto (75.17.049)"
        case .C_75_17_081: return "spese per servizi bancari (75.17.081)"
        case .C_75_17_300: return "altre spese automezzi (75.17.300)"
        case .C_75_17_301: return "omaggi a clienti inferiori a 50 euro (75.17.301)"
        case .C_75_17_505: return "spese per formalità CCIAA (75.17.505)"
        case .C_75_17_540: return "pedaggi autostradali deducibili (75.17.540)"
        case .C_75_17_542: return "pasti e soggiorni fuori comune (75.17.542)"
        case .C_75_17_543: return "pasti e soggiorni spese di rappresentanza (75.17.543)"
        case .C_75_17_575: return "sicurezza, formazione, estintori (75.17.575)"

        case .C_77_01_009: return "canone locazione fabbricati civili (77.01.009)"

        case .C_77_05_065: return "canone noleggio autocarri (77.05.065)"

        case .C_77_07_013: return "licenza d'uso software di esercizio (77.07.013)"

        case .C_79_01_001: return "salari (79.01.001)"

        case .C_79_03_001: return "oneri INPS (79.03.001)"
        case .C_79_03_005: return "oneri INAIL (79.03.005)"

        case .C_79_05_005: return "quota TFR maturata nell'anno (79.05.005)"

        case .C_79_09_037: return "spese per visite mediche (79.09.037)"

        case .C_81_01_009: return "ammortamento spese di costituzione (81.01.009)"

        case .C_81_03_021: return "ammortamento spese di pubblicità (81.03.021)"

        case .C_83_05_009: return "ammortamento impianto elettrico (83.05.009)"
        case .C_83_05_021: return "ammortamento impianto d'allarme (83.05.021)"
        case .C_83_05_037: return "ammortamento macchinari automatici (83.05.037)"
        case .C_83_05_045: return "ammortamento macchinari (83.05.045)"

        case .C_83_07_005: return "ammortamento attrezzature commerciali (83.07.005)"

        case .C_83_09_005: return "ammortamento autocarri (83.09.005)"
        case .C_83_09_061: return "ammortamento macchine d'ufficio elettroniche (83.09.061)"
        case .C_83_09_077: return "ammortamento mobili (83.09.077)"

        case .C_89_01_009: return "rimanenze iniziali materiale di consumo (89.01.009)"
        case .C_89_01_013: return "rimanenze iniziali merci (89.01.013)"

        case .C_91_01_033: return "accantonamento fondo trattamento fine mandato amministratori (91.01.033)"

        case .C_92_01_001: return "imposta di bollo (92.01.001)"
        case .C_92_01_013: return "imposta di registro (92.01.013)"
        case .C_92_01_033: return "tasse concessione governativa (92.01.033)"
        case .C_92_01_041: return "tasse proprietà autocarri (92.01.041)"
        case .C_92_01_085: return "diritti CCIAA (92.01.085)"
        case .C_92_01_089: return "tassa sui rifiuti (92.01.089)"
        case .C_92_01_097: return "perdite su crediti (92.01.097)"
        case .C_92_01_113: return "multe e ammende (92.01.113)"
        case .C_92_01_141: return "abbuoni passivi (92.01.141)"
        case .C_92_01_154: return "sopravvenienze passive ordinarie deducibili (92.01.154)"

        case .C_93_15_029: return "interessi passivi debiti verso altri finanziatori (93.15.029)"
        case .C_93_15_045: return "interessi passivi debiti verso erario (93.15.045)"
        case .C_93_15_049: return "interessi passivi debiti verso enti previdenziali (93.15.049)"
        case .C_93_15_082: return "imposte e bolli su conto corrente (93.15.082)"

        case .C_96_01_001: return "IRES (96.01.001)"
        case .C_96_01_005: return "IRAP (96.01.005)"
        }
    }
    
    public var codeDescription: String {
        switch self {
        case .undefined: return "nd"
        case .C_13_05_045: return "13.05.045"
            
//        case .C_73_01_550: return "73.01.550"
        case .C_73_01_551: return "73.01.551"
        case .C_73_01_552: return "73.01.552"
        case .C_73_01_553: return "73.01.553"
        case .C_73_01_554: return "73.01.554"
            
//        case .C_73_01_560: return "73.01.560"
        case .C_73_01_561: return "73.01.561"
        case .C_73_01_562: return "73.01.562"
        case .C_73_01_563: return "73.01.563"
        case .C_73_01_564: return "73.01.564"
            
        case .C_73_01_565: return "73.01.565"
        case .C_73_01_555: return "73.01.555"
            
        case .C_73_01_533: return "73.01.533"
        case .C_73_01_534: return "73.01.534"
        case .C_73_01_535: return "73.01.535"
            
        case .C_73_09_501: return "73.09.501"
        case .C_73_09_502: return "73.09.502"
        case .C_73_09_503: return "73.09.503"
        case .C_73_09_069: return "73.09.069"
            
        case .C_73_01_017: return "73.01.017"
        case .C_73_09_006: return "73.09.006"
        case .C_75_01_025: return "75.01.025"
        case .C_75_11_509: return "75.11.509"

        case .C_60_01_169: return "60.01.169"

        case .C_73_09_005: return "73.09.005"
        case .C_73_09_045: return "73.09.045"
        case .C_73_09_049: return "73.09.049"
        case .C_73_09_053: return "73.09.053"
        case .C_73_09_077: return "73.09.077"
        case .C_73_09_078: return "73.09.078"
        case .C_73_09_122: return "73.09.122"
        case .C_73_09_500: return "73.09.500"

        case .C_75_01_022: return "75.01.022"
        case .C_75_01_037: return "75.01.037"

        case .C_75_05_041: return "75.05.041"
        case .C_75_05_109: return "75.05.109"

        case .C_75_11_026: return "75.11.026"
        case .C_75_11_109: return "75.11.109"
        case .C_75_11_114: return "75.11.114"
        case .C_75_11_133: return "75.11.133"
        case .C_75_11_500: return "75.11.500"
        case .C_75_11_513: return "75.11.513"

        case .C_75_13_037: return "75.13.037"
        case .C_75_13_551: return "75.13.551"

        case .C_75_15_021: return "75.15.021"
        case .C_75_15_077: return "75.15.077"

        case .C_75_17_049: return "75.17.049"
        case .C_75_17_081: return "75.17.081"
        case .C_75_17_300: return "75.17.300"
        case .C_75_17_301: return "75.17.301"
        case .C_75_17_505: return "75.17.505"
        case .C_75_17_540: return "75.17.540"
        case .C_75_17_542: return "75.17.542"
        case .C_75_17_543: return "75.17.543"
        case .C_75_17_575: return "75.17.575"

        case .C_77_01_009: return "77.01.009"

        case .C_77_05_065: return "77.05.065"

        case .C_77_07_013: return "77.07.013"

        case .C_79_01_001: return "79.01.001"

        case .C_79_03_001: return "79.03.001"
        case .C_79_03_005: return "79.03.005"

        case .C_79_05_005: return "79.05.005"

        case .C_79_09_037: return "79.09.037"

        case .C_81_01_009: return "81.01.009"

        case .C_81_03_021: return "81.03.021"

        case .C_83_05_009: return "83.05.009"
        case .C_83_05_021: return "83.05.021"
        case .C_83_05_037: return "83.05.037"
        case .C_83_05_045: return "83.05.045"

        case .C_83_07_005: return "83.07.005"

        case .C_83_09_005: return "83.09.005"
        case .C_83_09_061: return "83.09.061"
        case .C_83_09_077: return "83.09.077"

        case .C_89_01_009: return "89.01.009"
        case .C_89_01_013: return "89.01.013"

        case .C_91_01_033: return "91.01.033"

        case .C_92_01_001: return "92.01.001"
        case .C_92_01_013: return "92.01.013"
        case .C_92_01_033: return "92.01.033"
        case .C_92_01_041: return "92.01.041"
        case .C_92_01_085: return "92.01.085"
        case .C_92_01_089: return "92.01.089"
        case .C_92_01_097: return "92.01.097"
        case .C_92_01_113: return "92.01.113"
        case .C_92_01_141: return "92.01.141"
        case .C_92_01_154: return "92.01.154"

        case .C_93_15_029: return "93.15.029"
        case .C_93_15_045: return "93.15.045"
        case .C_93_15_049: return "93.15.049"
        case .C_93_15_082: return "93.15.082"

        case .C_96_01_001: return "96.01.001"
        case .C_96_01_005: return "96.01.005"
        }
    }
}
