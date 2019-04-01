//
//  LoopTester.swift
//  Numbers
//
//  Created by Stephan Jancar on 11.05.18.
//  Copyright © 2018 Stephan Jancar. All rights reserved.
//

import Foundation
import BigInt
import PrimeFactors

public class LoopTester : NumTester {
	    public init() {}
    
	static var count : Int = 0
	public func isSpecial(n: BigUInt, cancel: CalcCancelProt?) -> Bool? {
		LoopTester.count += 1
		print("LOOP:", LoopTester.count)
		while true {
			if let cancelled = cancel?.IsCancelled() {
				if cancelled {
					return true
				}
			}
		}
	}
	
	public func getLatex(n: BigUInt) -> String? {
		return nil
	}
	
	public func property() -> String {
		return "loop"
	}
	
	
}

