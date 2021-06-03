//
//  File.swift
//  
//
//  Created by Massimo Di Leonardo on 03/06/21.
//

import Foundation

public struct DataPoint: Codable, Equatable {
    
    public init(date: Date, amount: Double) {
        self.date = date
        self.amount = amount
    }
    
    public var date: Date
    public var amount: Double
}

public struct AveragePoint: Identifiable {
    public init(date: Date, relativePointInTime: TimeInterval, average: Int) {
        self.date = date
        self.relativePointInTime = relativePointInTime
        self.average = average
    }
    
    public let id = UUID()
    public var date: Date
    public var relativePointInTime: TimeInterval
    public var average: Int
}

public enum MovingAveragePeriod: String, Identifiable, RawRepresentable, CaseIterable {
    public var id: String { rawValue }
    case oneMonth = "un mese"
    case threeMonths = "tre mesi"
    case sixMonths = "sei mesi"
    
    public var number: Int {
        switch self {
            case .oneMonth: return 1
            case .threeMonths: return 3
            case .sixMonths: return 6
        }
    }
}

public extension Array where Element == DataPoint {
    
    func calculateAverage(months: Int) -> Double? {
        let calendar = Calendar(identifier: .gregorian)
        let reps = self.sorted(by: { $0.date <= $1.date })

        guard let lastReport = reps.last else { return nil }
        let secondsInAMonth: Double = 60 * 60 * 24 * 30
        guard let reference = calendar.date(byAdding: .month, value: -months, to: lastReport.date) else
        { return nil }
        let afterReports = reps.filter{$0.date >= reference}
        guard let prec = reps.filter({$0.date <= reference}).last else { return nil }

        let elapsedSeconds = Double(calendar.dateComponents([.second], from: prec.date, to: lastReport.date).second!)
        let consumption = afterReports.reduce(0.0) { $0 + $1.amount }
        let avgPerSecond = consumption / elapsedSeconds
        return secondsInAMonth * avgPerSecond
    }
    
    func createPoints(months: Int) -> [AveragePoint] {
        guard count > 1 else {
            return []
        }
        let sorted = sorted(by: { $0.date <= $1.date })
        let firstDate = sorted.first!.date
        let points = sorted.reduce([]) { (partialPoints, report) -> [AveragePoint] in

            guard report.amount > 0 else { return partialPoints }
            let reportsToCalculate = filter({ $0.date <= report.date })
            guard let average = reportsToCalculate.calculateAverage(months: months) else { return partialPoints }
            let rpit = firstDate.distance(to: report.date)
            //let avg = averages.0 > 0 ? averages.0 : averages.1
            return partialPoints + [AveragePoint(date: report.date, relativePointInTime: rpit, average: Int(average))]
            
        }
        return points
    }
}

