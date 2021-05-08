//
//  Sequence + Extensions.swift
//  Studio Caffe App
//
//  Created by Massimo Di Leonardo on 25/03/21.
//

import Foundation

extension Sequence  {
    func sum<T: AdditiveArithmetic>(_ predicate: (Element) -> T) -> T { reduce(.zero) { $0 + predicate($1) } }
}
