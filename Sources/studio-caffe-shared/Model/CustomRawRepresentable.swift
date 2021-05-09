//
//  CustomRawRepresentable.swift
//  Studio Caffe App
//
//  Created by Massimo Di Leonardo on 26/12/20.
//

import Foundation

public protocol CustomRawRepresentable: CaseIterable, RawRepresentable {
    static var representableCases: [Self] { get }
    var representableValue: String { get }
}

extension CustomRawRepresentable where Self.RawValue == String {
    public static var representableCases: [Self] {
        Array(allCases)
    }
    
    public var representableValue: String {
        rawValue
    }
}
