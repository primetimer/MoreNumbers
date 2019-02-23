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

class LoopTester : NumTester {
	
	static var count : Int = 0
	func isSpecial(n: BigUInt, cancel: CalcCancelProt?) -> Bool? {
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
	
	func getLatex(n: BigUInt) -> String? {
		return nil
	}
	
	func property() -> String {
		return "loop"
	}
	
	
}

