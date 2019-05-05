//
//  Tester.swift
//  Numbers
//
//  Created by Stephan Jancar on 10.12.17.
//  Copyright © 2017 Stephan Jancar. All rights reserved.
//

import Foundation
import BigInt
import PrimeFactors

public protocol TestDescriber {
    func Desc(n:BigUInt) -> String
}
public class TesterDescriber {
    
    static func Desc(n:BigUInt,tester: NumTester) -> String {
        
        if let selfdescriber = tester as? TestDescriber {
            return selfdescriber.Desc(n: n)
        }
        
        if let rtest = tester as? RationalApproxTester {
            return rtest.Desc(n: n) ?? ""
        }
        
        if let ctest = tester as? SpecialConstantTester{
            return ctest.Desc(n: n, type: ctest.type) ?? ""
        }
        
        let desc = defaultDesc(n: n, tester: tester) ?? ""
        return desc
    }

    static public func defaultDesc(n: BigUInt, tester: NumTester) -> String? {
        if let index = tester.RootIndex(n: n) {
            if index > 0 {
                let ord = (index+1).ordinal
                let ans = "\(n) is the \(ord) \(tester.propertyString()) number"
                return ans
            }
        }
        let ans = "\(n) is a \(tester.propertyString()) number"
        return ans 
    }
}

//public extension NumTester {
//    func getLatex(n: BigUInt) ->  String? { return nil }
//}

