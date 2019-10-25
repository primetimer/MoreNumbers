//
//  AbundanceTester.swift
//  Numbers
//
//  Created by Stephan Jancar on 11.12.17.
//  Copyright © 2017 Stephan Jancar. All rights reserved.
//

import Foundation
import BigInt
import PrimeFactors

public class AmicableTester : NumTester {
	    public init() {}
	public func property() -> String {
		return "amicable"
	}
	public func propertyString() -> String {
		return "ami\u{00AD}cable"
	}
	public func isSpecial(n: BigUInt, cancel : CalcCancelProt?) -> Bool? {
        if n < 2 { return false }
        guard let div1 = SumOfProperDivisors(n: n, cancel: cancel) else { return nil }
        if div1 == n { return false }
        guard let div2 = SumOfProperDivisors(n: div1, cancel: cancel) else { return nil }
        if div2 == n { return true }
        return false
	}
    
    func SumOfProperDivisors(n: BigUInt,cancel : CalcCancelProt?) -> BigUInt? {
        let p = BigUInt(n)
        if let sigma = FactorCache.shared.Sigma(p: p,cancel: cancel) {
            return sigma - p
        }
        return nil
    }
    
    public func getLatex(n: BigUInt) -> String? {
        guard let special = isSpecial(n: n, cancel: nil) else { return nil }
        if !special { return nil }
        
        let div1 = FactorCache.shared.Divisors(p: n, cancel: TimeOut())
        guard let sigma1 = SumOfProperDivisors(n: n, cancel: TimeOut()) else { return nil }
        let div2 = FactorCache.shared.Divisors(p: sigma1, cancel: TimeOut())
        
        var latex = "\\sigma*(" + String(n) + ") = " + String(sigma1) + " = "
        var div1str = ""
        for d in div1 {
            if d == n { continue }
            if !div1str.isEmpty { div1str = div1str + "+"}
            div1str = div1str + String(d)
        }
        latex = latex + div1str + "\\\\"
        
        latex = latex + "\\sigma*(" + String(sigma1) + ") = " + String(n) + " = "
        var div2str = ""
        for d in div2 {
                  if d == sigma1 { continue }
                  if !div2str.isEmpty { div2str = div2str + "+"}
                  div2str = div2str + String(d)
        }
        latex = latex + div2str 
        
        
        return latex
    }
	
}

public class SocialTester : NumTester {
    
    let maxcycle = 28
    public init() {}
    public func property() -> String {
        return "social"
    }
    public func propertyString() -> String {
        return "social"
    }
    public func isSpecial(n: BigUInt, cancel : CalcCancelProt?) -> Bool? {
        if n < 12496 { return false } //Code unten ist aber auch für zahlen von 2...12496 geeignet
        var nn = n
        for cycle in 0...maxcycle {
            guard let sigma = SumOfProperDivisors(n: nn, cancel: cancel) else { return nil }
            if sigma == 1 { return false }
            if sigma == n {
                if cycle < 2 {
                    return false
                } else {
                    return true
                }
            }
            nn = sigma
        }
        return false
    }
    
    func SumOfProperDivisors(n: BigUInt,cancel : CalcCancelProt?) -> BigUInt? {
        let p = BigUInt(n)
        if let sigma = FactorCache.shared.Sigma(p: p,cancel: cancel) {
            return sigma - p
        }
        return nil
    }
    
    public func getLatex(n: BigUInt) -> String? {
        guard let special = isSpecial(n: n, cancel: nil) else { return nil }
        if !special { return nil }
        
        var nn = n
        var latex = ""
        for _ in 0...maxcycle {
            let div = FactorCache.shared.Divisors(p: nn, cancel: TimeOut())
            guard let sigma = SumOfProperDivisors(n: nn, cancel: TimeOut()) else { return nil }
            
            if !latex.isEmpty { latex = latex + "\\\\" }
            latex = latex + "\\sigma*(" + String(nn) + ") = " + String(sigma) + " = "
            var divstr = ""
            for d in div {
                if d == nn { continue }
                if !divstr.isEmpty { divstr = divstr + "+"}
                divstr = divstr + String(d)
            }
            latex = latex + divstr
            
            if sigma == n {
                break
            }
            nn = sigma
        }
        return latex
    }
    
}

