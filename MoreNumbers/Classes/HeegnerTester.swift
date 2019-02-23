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

public class HeegnerTester : NumTester {
	
	func getLatex(n: BigUInt) -> String? {
        guard let special = isSpecial(n: n,cancel: nil) else { return nil }
		if !special { return nil }
		var latex = "\\mathbb{Q} [\\sqrt{-" + String(n) + "}] \\text{has unique prime factorization}"
		switch Int(n) {
		case 19:
			latex = latex + "\\\\e^{\\pi\\sqrt{-19}} \\approx 96^3 + 744 - 0.2"
		case 43:
			latex = latex + "\\\\e^{\\pi\\sqrt{-43}} \\approx 960^3 + 744 - 0.000001"
		case 67:
			latex = latex + "\\\\e^{\\pi\\sqrt{-67}} \\approx 5280^3 + 744 - 0.0002"
		case 163:
			latex = latex + "\\\\e^{\\pi\\sqrt{-163}} \\approx 640320^3 + 744 - 0.0000000000008"
		default:
			break
		}
		return latex
	}
	
	public func property() -> String {
		return "Heegner"
	}
	
	public func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool? {
		if OEIS.shared.ContainsNumber(key: self.property(), n: n) {
			return true
		}
		return false
	}
}

