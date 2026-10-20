import Foundation

public enum ServiceCounterConsistency {
    public static let conflictReason = "Il numero di battute non è coerente con la data e con gli interventi già registrati per questo distributore."

    public static func isConsistent(counter: Int, previousMaximum: Int?, nextMinimum: Int?,
                                    sameDateMinimum: Int?, sameDateMaximum: Int?) -> Bool {
        if let previousMaximum, counter <= previousMaximum { return false }
        if let nextMinimum, counter >= nextMinimum { return false }
        if let sameDateMinimum, counter != sameDateMinimum { return false }
        if let sameDateMaximum, counter != sameDateMaximum { return false }
        return true
    }
}
