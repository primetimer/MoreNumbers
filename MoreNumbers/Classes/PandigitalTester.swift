//
//  PalindromicTester.swift
//  Numbers
//
//  Created by Stephan Jancar on 11.12.17.
//  Copyright © 2017 Stephan Jancar. All rights reserved.
//

import Foundation
import BigInt
import PrimeFactors

class PandigitalTester : NumTester {
	
    func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool? {
        if n == 0 { return false }
        return OEIS.shared.ContainsNumber(key: self.property(), n: n)
    }
    
	private func Base(n: BigUInt) -> Int? {
        guard let index = OEIS.shared.NumberIndex(key: self.property(), n: n) else { return nil }
        return index+1
	}
		
	func getDesc(n: BigUInt) -> String? {
		var desc = WikiLinks.shared.getLink(tester: self, n: n)
        guard let pbase = Base(n: n) else { return nil }
		
		desc = desc + " It is pandigital in base: \(pbase)"
		return desc
	}
	
	func getLatex(n: BigUInt) -> String? {
        guard let b = Base(n: n) else { return nil }		
        var latex = String(n)
		latex = latex + " = " + String(n,radix : b).uppercased()
        latex = latex + "_{" + String(b) + "}"
		
		return latex

	}
	
	func property() -> String {
		return "pandigital"
	}
	func propertyString() -> String {
		return "pan\u{00AD}digital"
	}
	
	
}
