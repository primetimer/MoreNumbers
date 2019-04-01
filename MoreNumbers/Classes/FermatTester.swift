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

public class FermatTester : NumTester {
        public init() {}
	
	/*
	func getDesc(n: BigUInt) -> String? {
		guard let special
		if !TestSpecialSync(n: n) { return nil }
		let mdesc = WikiLinks.shared.Link(key: "Fermat")
		let p = BigUInt(n)
		if PrimeCache.shared.IsPrime(p: p) {
			return String(n) + " is a " + mdesc + " prime"
		}
		
		return String(n) + " is a composite "  + mdesc + "  number"
	}
	*/
	
    public func getLatex(n: BigUInt) -> String? {
        if n <= 2 { return nil }
        guard let special = isSpecial(n: n,cancel : nil) else { return nil }
        if !special { return nil }
        
        guard let oeisseq = OEIS.shared.GetSequence(key: self.property()) else { return nil }
        for (index,p) in oeisseq.enumerated() {
            if n == p {
                let latex = String(n) + "= 2^{2^{" + String(index+1) + "}} + 1 = F_{" + String(index) + "}"
                return latex
            }
        }
        return nil
    }
	
	public func property() -> String {
		return "Fermat"
	}
	
	public func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool? {
		if n <= 2 { return false }
		return OEIS.shared.ContainsNumber(key: self.property(), n: n)
	}
}

public class ConstructibleTester : NumTester {
	    public init() {}
	public func property() -> String {
		return "Constructible"
	}
	public func propertyString() -> String {
		return "con\u{00AD}struc\u{00AD}tible"
	}
	public func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool? {
		if n <= 2 { return false }
		if let _ = Decompose(n: n) {
			return true
		}
		return false
	}
	
	public func Decompose(n: BigUInt) -> (pow2: Int, fermatn : [Int])? {
		if n <= 2 { return nil }
		var nn = n
		var ans : [Int] = []
		
		var pow2 = 0
		while nn % 2 == 0 {
			pow2 = pow2 + 1
			nn = nn / 2
		}
		
		let fermatp = [BigUInt(3),BigUInt(5),BigUInt(17),BigUInt(257),BigUInt(65537)]
		for index in 0..<fermatp.count {
			if nn % fermatp[index] == 0 {
				ans.append(index)
				nn = nn / fermatp[index]
			}
		}
		if nn == 1 { return (pow2,ans) }
		return nil
		
	}
	
	public func getLatex(n: BigUInt) -> String? {
		
		guard let (pow2,fn) = Decompose(n: n) else { return nil }
		
		var started = false
		var latex = String(n) + "="
		if pow2 >= 1  {
			latex = latex + "2^{" + String(pow2) + "} "
			started = true
		}
		for f in fn {
			if started {
				latex = latex + "\\cdot {F_{" + String(f) + "}}"
			} else {
				latex = latex + "F_{" + String(f) + "}"
			}
			started = true
		}
		return latex
	}
}


