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

public class GoldbachTester : NumTester {
    public init() {}
    private func findGoldbach(n: BigUInt, cancel : CalcCancelProt? = nil) -> [(a:BigUInt,b:BigUInt)]? {
        
        //if n % 2 == 1 { assert(false); return nil }
        var ans : [(a:BigUInt,b:BigUInt)] = []
        if n <= BigUInt(220) {
            for p in OEIS.shared.smallprimes {
                if p > Int(n) / 2 {
                    return ans
                }
                let q = Int(n) - p
                if OEIS.shared.smallprimes.contains(q) {
                    let (a,b) = (BigUInt(p),BigUInt(q))
                    ans.append((a,b))
                }
            }
            assert(false)
        }
        
        var m = n / 2
        if m % 2 == 0 { m = m + 1 }
        while m < n {
            if m.isPrime() {
                let q = n - m
                if q.isPrime() {
                    ans.append((m,q))
                    return ans
                }
            }
            m = m + 2
            if cancel?.IsCancelled() ?? false { return nil }
        }
        assert(false)
        return nil
    }
    
    public func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool? {
        let special = OEIS.shared.ContainsNumber(key: self.property(), n: n)
        return special
    }
    
    public func getLatex(n: BigUInt) -> String? {
        let special = isSpecial(n: n, cancel: nil) ?? false
        var latex = ""
        
        if n <= 3 {
            return nil
        }
        
        if (n < 11) || (n % 2 == 0) {
            if let summands = findGoldbach(n: n, cancel: TimeOut()) {
                for s in summands {
                    if !latex.isEmpty { latex = latex + "\\\\" }
                    latex = latex + String(n) + "=" + String(s.a) + "+" + String(s.b)
                }
            }
        } else {
            let n3 = n - 3
            if let summands = findGoldbach(n: n3, cancel: TimeOut()) {
                for s in summands {
                    if !latex.isEmpty { latex = latex + "\\\\" }
                    latex = latex + String(n) + "= 3 +" + String(s.a) + "+" + String(s.b)
                }
            }
            
        }
        if special {
            latex = latex + "\\\\ \\forall p \\in \\mathbb{P}, n/2 <= p < n : n-p \\in \\mathbb{P}"
        }
        return latex
    }
    
    public func property() -> String {
        return "Goldbach record"
    }
    
    
}
