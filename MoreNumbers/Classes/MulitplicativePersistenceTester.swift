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
    public init() {}
    public func calc(n : BigUInt) -> [String] {
        var ans : [String] = []
        var n = n
        var count = 0
        while true {
            let str = String(n)
            ans.append(str)
            if n <= 9 {
                ans.append(str)   //Replication
                return ans
            }
            var newValue = BigUInt(1)

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
    
    public func getLatex(n: BigUInt) -> String? {
        let seq = calc(n: n)
        var latex = ""
        for i in 0..<seq.count-1 {
            let s = seq[i]
            var comp = ""
            for c in s {
                if comp.count > 0 {
                    comp = comp + "\\cdot"
                }
                comp = comp + String(c)
            }
            let next = seq[i+1]
            comp = comp + "=" + String(next)
            if latex.count > 0 {
                latex = latex + "\\\\ \\rightarrow"
            }
            latex = latex + comp
        }
        return latex
    }
    
    public func property() -> String {
        return "multiplicative persistent"
    }
}
