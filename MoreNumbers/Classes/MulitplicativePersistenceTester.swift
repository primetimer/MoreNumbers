//
//  HCNTester.swift
//  Numbers
//
//  Created by Stephan Jancar on 30.12.17.
//  Copyright © 2017 Stephan Jancar. All rights reserved.
//

import Foundation
import BigInt
import PrimeFactors

//https://www.youtube.com/watch?v=Wim9WJeDTHQ
//https://en.wikipedia.org/wiki/Persistence_of_a_number

public class MultiplicativePersistenceTester : NumTester {
    
    private var records : [BigUInt] = [0, 10, 25, 39, 77, 679, 6788, 68889, 2677889, 26888999, 3778888999, 277777788888899]
    public func calc(n : BigUInt) -> Int {
        var n = n
        var count = 0
        while true {
            if n <= 9 { return count }
            var newValue = BigUInt(1)
            let str = String(n)
            for c in str {
                let digit = BigUInt(Int(String(c)) ?? 0)
                newValue = newValue * digit
            }
            n = newValue
            count = count + 1
        }
    }
    public func isSpecial(n: BigUInt, cancel: CalcCancelProt?) -> Bool? {
        if records.contains(n) { return true }
        return false
    }
    
    public func property() -> String {
        return "multiplicative persistent"
    }
}
