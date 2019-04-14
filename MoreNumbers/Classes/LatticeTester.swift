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

public class PiLatticeTester : NumTester {
	public func getLatex(n: BigUInt) -> String? {
		return nil
	}
	public func property() -> String {
		return "Pi Lattice Approximation"
	}
	
	private func PiRoundOff(x: BigUInt) -> BigUInt
	{
		let d = Double(x)
		let p = round(d*d*Double.pi)
		return BigUInt(p)
		
	}
	public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		if n<=2 { return false }
		//n == pi*p^2 -> p = sqrt(n/pi)
		let pd = sqrt(Double(n) / Double.pi) - 1
		var pguess = BigUInt(pd)
		repeat {
			if cancel?.IsCancelled() ?? false { return nil }
			let pr = PiRoundOff(x: pguess)
			if n > pr {
				return false
			}
			if n == pr {
				return false
			}
			pguess = pguess + 1
		} while true
	}
	
}
public class LatticeTester : NumTester {
	    public init() {}
	public func getLatex(n: BigUInt) -> String? {
		return nil
	}
    public func property() -> String {
		return "Lattice points in circle"
	}
	
    public func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool? {
		if n == 1 { return true }
		if n < 5 { return false }
		if OEIS.shared.ContainsNumber(key: self.property(),n: n) {
			return true
		}
		return false
	}
	
	//NUmber of ways to write n = a^2 + b^2
	public func r2(n: BigUInt,cancel: CalcCancelProt?) -> BigUInt {
		if n == 0 { return 1 }
		var (ans,d1,d3) = (0,0,0)
		let divisors = FactorCache.shared.Divisors(p: n,cancel: cancel)
		if cancel?.IsCancelled() ?? false { return 0 }
		for d in divisors {
			//let t = (d-1)/2
			switch Int(d % 4) {
			case 1:
				d1 = d1 + 1
			case 3:
				d3 = d3 + 1
			default:
				break
			}
		}
		ans = 4*(d1 - d3)
		return BigUInt(ans)
	}
}

