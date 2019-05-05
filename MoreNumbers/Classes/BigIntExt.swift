//
//  BigIntExt.swift
//  Palindrome
//
//  Created by Stephan Jancar on 25.09.18.
//  Copyright © 2018 Stephan Jancar. All rights reserved.
//

import Foundation
import BigInt
import PrimeFactors

public extension BigUInt {
    func getDigits(base : Int) -> [Int] {
        var ans : [Int] = []
        var t = self
        while t > 0 {
            let digit = Int(t % BigUInt(base))
            ans.append(digit)
            t = t / BigUInt(base)
        }
        return ans
    }
	
	func digitsCount(base : Int) -> Int {
		var ans : [Int] = []
		var t = self
		while t > 0 {
			let digit = Int(t % BigUInt(base))
			ans.append(digit)
			t = t / BigUInt(base)
		}
		return ans.count
	}
	
	func isPalindromic(base : Int) -> Bool {
		let d = self.getDigits(base: base)
		let l = d.count
		for i in 0..<l {
			if d[i] != d[l-i-1] { return false }
		}
		return true
	}
	
	static func random(ndigits : Int, base : Int = 10) -> BigUInt {
		let r = Int.random(in: 1..<base)
		var ans = BigUInt(r)
		for _ in 1..<ndigits {
			let r = Int.random(in: 0..<base)
			ans = ans * 10 + BigUInt(r)
		}
		return ans
	}
}


public extension FactorCache {
func Desc(n: BigUInt, withpot : Bool, cancel: CalcCancelProt?) -> String? {
    if n<2 { return nil }
    let factors = Factor(p: n,cancel: cancel)
    if cancel?.IsCancelled() ?? false { return nil }
    if factors.factors.count < 2 { return nil }
    var latex = String(n) + "="
    
    if withpot {
        let fwithpots = FactorsWithPot(n: n, cancel: cancel)
        for (index,f) in fwithpots.factors.enumerated() {
            if index > 0 { latex = latex + "*" }
            latex = latex + String(f.f)
            if f.e > 1 {
                latex = latex + "^" + String(f.e)
            }
            //                if index>0 {
            //                    latex = latex + "}"
            //                }
        }
    } else {
        for (index,f) in factors.factors.enumerated() {
            if index > 0 { latex = latex + "*" }
            latex = latex + String(f)
            //                if index > 0 { latex = latex + "}" }
        }
    }
    if factors.unfactored > 1 {
        latex = latex + "*?"
    }
    //latex = latex + "\\\\"
    return latex
}
}


