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

public class PandigitalTester : NumTester, TestDescriber {
    
    public init() {}
	
    public func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool? {
        if n == 0 { return false }
        return OEIS.shared.ContainsNumber(key: self.property(), n: n)
    }
    
	public func Base(n: BigUInt) -> Int? {
        guard let index = OEIS.shared.NumberIndex(key: self.property(), n: n) else { return nil }
        return index+1
	}
			
	public func getLatex(n: BigUInt) -> String? {
        guard let b = Base(n: n) else { return nil }
        if b <= 1 { return nil }
        var latex = String(n)
		latex = latex + " = " + String(n,radix : b).uppercased()
        latex = latex + "_{" + String(b) + "}"
		
		return latex

	}
    
    public func Desc(n: BigUInt) -> String {
        guard let b = Base(n: n) else { return "not pandigital" }
        //if b <= 1 { return "" }
        var latex = String(n) + " is the smallest pandigital number in base \(b)"
        if b <= 1 { return latex }
        latex = latex + "\n \(String(n)) = " + String(n,radix : b).uppercased()
        latex = latex + "_" + String(b) + ""
        
        return latex

    }
	
	public func property() -> String {
		return "pandigital"
	}
	public func propertyString() -> String {
		return "pan\u{00AD}digital"
	}
	
	
}
