//
//  FactorCache.swift
//  Numbers
//
//  Created by Stephan Jancar on 17.12.17.
//  Copyright © 2017 Stephan Jancar. All rights reserved.
//

import Foundation
import BigInt
import PrimeFactors

class TimeOut : CalcCancelProt {
	func IsCancelled() -> Bool {
		return false
		let end = CFAbsoluteTimeGetCurrent()
		let dif = end-start
		if dif > 1.0 {
			return true
		}
		return false
	}
	
	init(timeout : Double = 1.0) {
		self.timeout = timeout
	}
	
	private var timeout : TimeInterval = 1.0	
	private let start = CFAbsoluteTimeGetCurrent()
}



