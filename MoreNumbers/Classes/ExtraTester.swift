//
//  ExtraTester
//  Numbers
//
//  Created by Stephan Jancar on 11.12.17.
//  Copyright © 2017 Stephan Jancar. All rights reserved.
//

import Foundation
import BigInt
import PrimeFactors

public class ZeroTester : NumTester {
        public init() {}
	public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		if n == 0 { return true }
		return false
	}
	
	public func property() -> String {
		return "zero"
	}
	public func issubTester() -> Bool {
		return true
	}
	
}

public class OneTester : NumTester {
        public init() {}
	public func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool? {
		if n == 1 { return true }
		return false
	}
	public func getLatex(n: BigUInt) -> String? {
		let latex = "\\forall n in \\mathBB{N} : n = \\prod_{k=1}^{n} p_k^{n_k}"
		return latex
	}
	public func property() -> String {
		return "one"
	}
	public func propertyString() -> String {
		return "unit"
	}
	public func issubTester() -> Bool {
		return true
	}
	
}





