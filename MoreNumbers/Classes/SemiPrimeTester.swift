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

public class SemiPrimeTester : NumTester {
	
	private let first : [UInt64] = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,71,73,79,83,89,97]
	
	private func SemiPrimeQuickTest(p: BigUInt) -> Bool? {
		if let factors = FactorCache.shared.IsFactored(p: p) {
			if factors.factors.count > 2 {
				return false
			}
			if factors.factors.count == 2 && factors.unfactored == 1 {
				return true
			}
			return false
		}
		
		for d in first {
			if p % BigUInt(d) == 0 {
				let pd = p / BigUInt(d)
				if PrimeCache.shared.IsPrime(p: pd) {
					return true
				}
				else {
					return false
				}
			}
		}
		
		let pollard = PrimeFaktorRho()
		let d = pollard.GetFactor(n: p, cancel: nil)
		if d > 0 {
			if !PrimeCache.shared.IsPrime(p: d) {
				return false
			}
			let pd = p / d
			if !PrimeCache.shared.IsPrime(p: pd) {
				return false
			}
			return true
		}
		return nil
	}
	public func isSpecial(n: BigUInt, cancel: CalcCancelProt?) -> Bool? {
		if n < 4 { return false }
		if let quicktest = SemiPrimeQuickTest(p: n) {
			return  quicktest
		}
		
		let factors = FactorCache.shared.Factor(p:n , cancel: cancel)
		if cancel?.IsCancelled() ?? false { return nil }
		if factors.factors.count > 2 { return false }
		if factors.unfactored == 1 {
			if factors.factors.count == 2 {
				return true
			}
			return false
		}
		return nil
	}
	
//    func getDesc(n: BigUInt) -> String? {
//        let desc = WikiLinks.shared.getLink(tester: self, n: n)
//        return desc
//    }
//
//    func getLatex(n: BigUInt) -> String? {
//        let dummycert = "is there a semiprime certifcate"
//        return nil // Factorization is shown elsewhere
//    }
	
	public func property() -> String {
		return "semiprime"
	}
	public func propertyString() -> String {
		return "semi\u{00AD}prime"
	}
}
