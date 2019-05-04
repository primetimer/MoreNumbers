//
//  Sampler.swift
//  Palindrome
//
//  Created by Stephan Jancar on 19.10.18.
//  Copyright © 2018 Stephan Jancar. All rights reserved.
//

import Foundation
//import UIKit
import BigInt

public enum digitButtonType : Int {
	case src = 0
	case p1,p2,p3
	case c
	case sum
}

extension digitButtonType : CaseIterable {}

extension digitButtonType : CustomStringConvertible {
    public var description: String {
		return text
	}
	
	public var text : String {
		switch(self) {
			
		case .src:
			return "Target:"
		case .p1:
			return "p1:"
		case .p2:
			return "+ p2:"
		case .p3:
			return "+ p3:"
		case .c:
			return "carry" //carry:"
		case .sum:
			return "= sum:"
			//		case .dif:
			//			return "dif:"
		}
	}
}

public protocol protPalindromSampler {
	func Sample(type : digitButtonType ,index : Int, digit : Int, algorithm : Int)
//	func Finished(_ type: digitButtonType, _ ppi : BigUInt)
	func Finished(_ split : PalindromeSplitter)
}



public struct PalindromSample  {
	var type : digitButtonType
	var index : Int
	var digit : Int
	
	init(type: digitButtonType,index : Int, digit : Int) {
		self.type = type
		self.index = index
		self.digit = digit
	}
}

extension PalindromSample : CustomStringConvertible {
	public var description: String {
		return type.description + String(index) + ":" + String(digit)
	}
}
public class PalindromSampler : protPalindromSampler {
	public func Finished(_ split: PalindromeSplitter) {
		var digits : [digitButtonType:[Int]] = [:]
		digits[.p1] = split.p1.getDigits(base: split.base)
		digits[.p2] = split.p2.getDigits(base: split.base)
		digits[.p3] = split.p3.getDigits(base: split.base)
		
		for i in 1...split.d.count {
			for type in [digitButtonType.p1,digitButtonType.p2,digitButtonType.p3] {
				let l = digits[type]!.count - i
				if l < 0 { continue }
				let v = digits[type]![l]
				Sample(type: type, index: l, digit: v, algorithm: split.algorithm)
			}
		}
		
	}
	
	
	private (set) var samples : [PalindromSample] = []
//	func Finished(_ type: digitButtonType, _ pi: BigUInt) {
//		if pi == 0 { return }
//		let d = pi.getDigits(base: 10)
//		for (i,digit) in d.enumerated().reversed() {
//			Sample(type: type, index: i, digit: digit, algorithm: 0)
//		}
//	}
	
	public func Sample(type: digitButtonType, index: Int, digit: Int, algorithm: Int) {
		let sample = PalindromSample(type: type, index: index, digit: digit)
		samples.append(sample)
	}
		
	public init() {
		samples = []
	}
}

extension PalindromSampler : CustomStringConvertible {
	public var description: String {
		
		let ans = samples.reduce("",  { (result,next) -> String in return result + next.description })
		return ans
	}
}

