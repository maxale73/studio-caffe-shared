import Foundation

public enum DefaultServiceTypeProto: String, CaseIterable, RawRepresentable {
    case counterID
    case refillID
    case espressoGroupSubstitutionID
    case espressoGroupWashingID
    case altEspressoGroupSubstitutionID
    case altEspressoGroupWashingID
    case grinderSubID
    case espressoBoilerSubID
    case instantBoilerSubID
    case waterPurifierSubID
    case fanSystemCheckID
    case coolerSystemCheckID
    case completeReviewID
}
