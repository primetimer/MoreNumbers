//
//  MersenneTester.swift
//  Numbers
//
//  Created by Stephan Jancar on 25.12.17.
//  Copyright © 2017 Stephan Jancar. All rights reserved.
//

import Foundation
import BigInt
import PrimeFactors

public enum Divergents : Int, CaseIterable {
    case one12 = 0
    case onehalf
    case onethird
    case minusone
    case minusone10
    
    
    public var pvalue : padic {
        switch self {
        case .one12:
            return padic(-1, base: 7) / padic(12,base :7)
        case .onehalf:
             return padic(1,base:7) / padic(2,base :7)
        case .onethird:
             return padic(1, base: 7) / padic(3, base: 7)
        case .minusone:
            return  padic(-1, base: 7)
        case .minusone10:
            return  padic(-1, base: 10)
        }
    }
    
    public var svalue : String {
        switch self {
        case .one12:
            return "-\\frac{1}{12}"
        case .onehalf:
            return "\\frac{1}{2}"
        case .onethird:
            return "\\frac{1}{3}"
        case .minusone,.minusone10:
            return "-1"
        }
    }
    
    public var series : String  {
        switch self {
        case .one12:
            return "\\sum_{k=1}^{\\infty} k = 1 + 2 + 3 + ..."
        case .onehalf:
            return "\\sum_{k=0}^{\\infty} (-1)^k = 1 - 1 + 1 - 1 + ..."
        case .onethird:
            return "\\sum_{k=0}^{\\infty} (-1)^k 2^k= 1 - 2 + 4 - 8 + ..."
        case .minusone,.minusone10:
            return "\\sum_{k=0}^{\\infty} 2^k= 1 + 2 + 4 + 8 + ..."
        }
    }
    
    public var explain : String  {
        switch self {
        case .one12:
            return ""
        case .onehalf:
            var ans = "\\\\ S = 1 - 1 + 1 - 1 + ..."
            ans = ans + "\\\\ 1 - S = 1 - 1 + 1 - 1 + ... = S"
            ans = ans + "\\\\ \\rightarrow S = 1/2"
            return ans
        case .onethird:
            return ""
        case .minusone,.minusone10:
            var ans = "\\\\ S = 1 + 2 + 4 + 8 + ..."
            ans = ans + "\\\\ 1 + 2S = S"
            ans = ans + "\\\\ \\rightarrow S = -1"
            return ans
        }
    }
    
}
public class DivergentTester : NumTester {
    public init() {}
    
    
    private func checkBackwards(n: BigUInt, p : padic) -> Bool {
        let sn = String(n,radix : 10).reversed()
        if sn.count < 3 { return false }
        
        let sp = String(p.value, radix :Int(p.base)).reversed()
        
       let an = Array(sn)
        let ap = Array(sp)
        
        for i in 0..<min(an.count,ap.count) {
            if an[i] != ap[i] { return false }
        }
        return true
        
    }
    
    private func findpadic(n : BigUInt) -> Divergents? {
        
        for d in Divergents.allCases {
            let p = d.pvalue
            if checkBackwards(n: n, p: p) { return d }
        }
        return nil
    }
    
    public func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool? {
        if findpadic(n: n) != nil {
            return true
        }
        return false
        
    }
    public func getLatex(n: BigUInt) -> String? {
        if let d = findpadic(n: n) {
            let p = d.pvalue
            let l = 10 // String(n, radix: 10).count
            var latex = String(p, digits : UInt(l))
            latex = latex.replacingOccurrences(of: "...", with: "..._{\(p.base)}")
            latex = d.svalue + "=" + latex + "\\\\"
            latex = latex + d.svalue + "=_R" + d.series
            latex = latex + d.explain
            return latex
        }
        
        return nil
    }
	
	public func property() -> String {
		return "p-adic"
	}
}

