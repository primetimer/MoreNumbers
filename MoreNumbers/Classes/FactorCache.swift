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

public class TimeOut : CalcCancelProt {
    
    public static var enabletimeout = false
    public static var timeoutdefault = 1.0
    
    public func IsCancelled() -> Bool {
        if TimeOut.enabletimeout && self.timeout > 0.0 {
            let end = CFAbsoluteTimeGetCurrent()
            let dif = end-start
            if dif > 1.0 {
                return true
            }
        }
        return false
    }
	
    public init() {
        self.timeout = TimeOut.timeoutdefault
    }
	public init(timeout : Double) {
		self.timeout = timeout
	}
	
	private var timeout : TimeInterval = 1.0	
	private let start = CFAbsoluteTimeGetCurrent()
}



