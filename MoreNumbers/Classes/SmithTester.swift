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

extension BigUInt {
	func SumOfDigits(base : BigUInt = 10) -> BigUInt {
		var temp = self
		var ans = BigUInt(0)
		while temp > 0 {
			let digit = temp % base
			ans = ans + digit
			temp = temp / base
		}
		return ans
	}
}

class SmithTester : NumTester {
	
	private func SmithSum(n: BigUInt, base : BigUInt = 10, cancel: CalcCancelProt?) -> BigUInt {
		let factors = FactorCache.shared.Factor(p: n, cancel: cancel)
		if cancel?.IsCancelled() ?? false { return 0 }
		var sum = BigUInt(0)
		for f in factors.factors {
			sum = sum + f.SumOfDigits(base: base)
		}
		return sum
	}
	func property() -> String {
		return "Smith"
	}
	func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool? {
		if n <= 3 { return false }
		if PrimeCache.shared.IsPrime(p: n) { return false }
		
		let dsum = n.SumOfDigits()
		let ssum = SmithSum(n: n,cancel: cancel)
		if cancel?.IsCancelled() ?? false { return nil }
		return  dsum == ssum
	}
	
	
	/*
	func getDesc(n: BigUInt) -> String? {
		if n<=3 { return nil }
		let special = TestSpecialSync(n: n) ?? false
		if !special { return nil }
		var desc = WikiLinks.shared.getLink(tester: self, n: n)
		
		if TestSpecialSync(n: n-1) {
			desc = desc + "(with brother:" + String(n-1) + ")."
		}
		if TestSpecialSync(n: n+1) {
			desc = desc + "(with brother:" + String(n+1) + ")."
		}
		return desc
	}
	*/
	
//    func getLatex(n: BigUInt) -> String? {
//        let special = TestSpecialSync(n: n) ?? false
//        if !special { return nil }
//        let factors = FactorCache.shared.Factor(p: n,cancel: TimeOut())
//        var latex = ""
//        let s = String(n)
//        for (index,c) in s.enumerated() {
//            if index > 0 { latex = latex + "+" }
//            latex = latex + String(c)
//        }
//        latex = latex + "="
//        for (findex,f) in factors.factors.enumerated() {
//            if findex > 0 { latex = latex + "+" }
//            if f >= 10 {
//                let strf = String(f)
//                var latexf = ""
//                for (index,c) in strf.enumerated() {
//                    if index > 0 { latexf = latexf + "+" }
//                    latexf = latexf + String(c)
//                }
//                latex = latex + "(" + latexf + ")"
//            } else {
//                latex = latex + String(f)
//            }
//        }
//        //latex = latex + "\\\\"
//        return latex
//    }
//}
}

