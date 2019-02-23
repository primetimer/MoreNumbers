//
//  TesterCache.swift
//  Numbers
//
//  Created by Stephan Jancar on 18.02.18.
//  Copyright © 2018 Stephan Jancar. All rights reserved.
//

import Foundation
import BigInt
import PrimeFactors

/*
class TestResult : NSObject {
	var special : Bool?
	var desc : String?
	var latex : String?
	var property : String
	
	init(special : Bool, desc: String?,latex: String?, property: String) {
		self.special = special
		self.desc = desc
		self.latex = latex
		self.property = property
	}
	
	init(tester : NumTester, n: BigUInt) 	{
		self.special = tester.isSpecial(n: n)
		self.desc = tester.getDesc(n: n)
		self.latex = tester.getLatex(n: n)
		self.property = tester.property()
	}
}
*/


public class TesterCache  {
    
    //Synchroner Aufruf
    func TestSpecial(tester : NumTester, n: BigUInt,cancel : CalcCancelProt? ) -> Bool? {
        let key = CacheKey(tester: tester, n: n)
        if let val = specialcache.object(forKey: key) {
            return val.boolValue
        }
        guard let special = tester.isSpecial(n: n,cancel : cancel) else { return nil }
        let ns_special = NSNumber(booleanLiteral: special)
        specialcache.setObject(ns_special, forKey: key)
        return special
    }

	func NotifySpecial(t: NumTester, nr: BigUInt, special: Bool?) {
		if let special = special {
			let key = CacheKey(tester: t, n: nr)
			let ns_special = NSNumber(booleanLiteral: special)
			specialcache.setObject(ns_special, forKey: key)
		}
	}
	func NotifyLatex(t: NumTester, nr: BigUInt, latex: LatexString?, completed: Bool) {
		let key = CacheKey(tester: t, n: nr)
		if let nsval = latex as NSString? {
			latexcache.setObject(nsval, forKey: key)
		}
	}
	private func CacheKey(tester: NumTester, n: BigUInt) -> NSString {
		let nsstr = NSString(string: tester.property() + ":" + String(n.hashValue))
		return nsstr
	}
	func HasCacheSpecial(tester: NumTester, n: BigUInt) -> Bool? {
		let key = CacheKey(tester: tester, n: n)
		if let val = specialcache.object(forKey: key) {
			return val.boolValue
		}
		return nil
	}
	func HasCacheLatex(tester: NumTester, n: BigUInt) -> LatexString? {
		let key = CacheKey(tester: tester, n: n)
		if let val = latexcache.object(forKey: key) {
			return String(val)
		}
		return nil
	}

	
//    func getDesc(tester: NumTester,n: BigUInt) -> String? {
//        return tester.getDesc(n: n)
//    }
//
//    func getLatex(tester: NumTester,n: BigUInt) -> String? {
//        return tester.getLatex(n: n)
//    }
	
	public func property(tester: NumTester) -> String {
		return tester.property()
	}
	
    private var latexcache = NSCache<NSString, NSString>()
	private var specialcache = NSCache<NSString, NSNumber>()
	static public var shared = TesterCache()
	private init() {}
}

