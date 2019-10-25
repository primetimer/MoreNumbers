//
//  PrimeTester.swift
//  Numbers
//
//  Created by Stephan Jancar on 10.12.17.
//  Copyright © 2017 Stephan Jancar. All rights reserved.
//

import Foundation
import BigInt
import PrimeFactors


public class PinTester10n : NumTester {
    
    public static var pcalc = PrimeCalculator()
    public static var pitable = PiTable(pcalc: pcalc, tableupto: 100000)
    public static var ml = PiMeisselLehmer(pcalc: pcalc, pitable: pitable)
    

    public init() {
    }
	public func property() -> String {
		return "primes up to 10^n"
	}
    
    private func WhichPow(n: BigUInt) -> (pow: UInt64,npow: Int)? {
        var npow: UInt64 = 1
        for pow in 0...7 {
            let pin = PinTester10n.ml.Pin(n: npow)
            if pin == n { return (npow,pow) }
            if n < pin { return (0,0) }
            npow = npow * 10
        }
        return nil
    }
    
    public func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool? {
        
        guard let npow = WhichPow(n: n) else { return nil }
        if npow.pow == 0 { return false }
        return true
    }
	
    public func getLatex(n: BigUInt) -> String? {
        
        guard let npow = WhichPow(n: n) else { return nil }
        if npow.pow == 0 { return nil }
        var latex = String(n) + " = \\pi(" + String(npow.pow) + ")"
        latex = latex + "\\\\ pi(x) = \\mid {{ p in mathbb{P} : p <= x }} \\mid"
        return latex
    }
	
	public func issubTester() -> Bool {
		return false
	}
}

public class PinReverseTester : NumTester {
    
    public func property() -> String {
        return "Pinreverse"
    }
    
    public func getLatex(n: BigUInt) -> String? {
        return nil
    }
    
    public init() {}
    
    private func reverse(n: BigUInt, base : Int) -> BigUInt {
        if n == 0 { return 0 }
        var ans = BigUInt(0)
        
        var n = n
        while n > 0 {
            let d = n % BigUInt(base)
            ans = ans * BigUInt(base) + d
            n = n / BigUInt(base)
        }
        return ans
    }

    public func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool? {
        if !n.isInt64() { return nil }

        let rev = reverse(n: n, base: 10)
        let pinrev = PinTester10n.ml.Pin(n: UInt64(rev))
        
        let pin = PinTester10n.ml.Pin(n: UInt64(n))
        let revpin = reverse(n: BigUInt(pin), base: 10)
        
        if pinrev == revpin { return true }
        return false
    }

    
}

public class SheldonNumberTester : NumTester {
    
    public init() {
        #if true
        radix = []
        for n in 2...5000 {
            radix.append(n)
        }
        #endif
    }
    public func property() -> String {
        return "Sheldon number"
    }
    
    fileprivate var radix : [Int] = [10] //,2,4,16,12,20]
    //private var radix : []= [2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20]
    
    fileprivate func Digits(n: BigUInt, base : Int) -> [Int] {
        if n == 0 { return [0] }
        
        var ans : [Int] = []
        var n = n
        let b = BigUInt(base)
        while n > 0 {
           let d = n % b
            n = n / b
            ans.insert(Int(d), at: 0)
        }
        return ans
    }
    
    fileprivate func BigBaseString(n: BigUInt, base : Int) ->String {
        if base <= 36 {
            return String(n, radix: base)
        }
        let d = Digits(n: n, base: base)
        var ans = ""
        for dig in d {
            if !ans.isEmpty { ans = ans + " " }
            ans = ans + String(dig)
        }
        return ans
    }
    
    fileprivate func Product(n: BigUInt, base: Int) -> BigUInt {
        let d = Digits(n: n, base: base)
        var prod : BigUInt = 1
        for dig in d {
            prod = prod * BigUInt(dig)
        }
        return prod
    }
    
    fileprivate func ProductString(n: BigUInt, base: Int) -> String {
        let d = Digits(n: n, base: base)
        var ans = ""
        
        for dig in d {
            if !ans.isEmpty {
                ans = ans + "\\cdot{" + String(dig) + "\\}"
            } else {
                ans = ans + String(dig)
            }
        }
        return ans
    }
    
    public func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool? {
        
        guard let isprime = PrimeTester().isSpecial(n: n, cancel: cancel) else { return nil }
        if !isprime { return false }
        if !n.isInt64() { return nil }
        
        for base in radix {
            let prod = Product(n: n, base: base)
            let prodpin = PinTester10n.ml.Pin(n: UInt64(n))
        
            if prod == prodpin { return true }
        }
        return false
    }
    
    public func Info(n: BigUInt) -> (pin: UInt64, base: Int, str: String)? {
        if !n.isInt64() { return nil }
        for base in radix {
                let prod = Product(n: n, base: base)
                let pin = PinTester10n.ml.Pin(n: UInt64(n))
                if pin == prod {
                    let s = ProductString(n: n, base: base)
                    return (pin: pin, base: base, str: s)
                }
        }
        return nil
    }
    
    public func getLatex(n: BigUInt) -> String? {
        if !n.isInt64() { return nil }
       
        for base in radix {
            let prod = Product(n: n, base: base)
            let prodpin = PinTester10n.ml.Pin(n: UInt64(n))
            if prodpin == prod {
                var latex = "\\pi(" + String(n) + ")="
                if base != 10 {
                    latex = latex + "\\pi(" + BigBaseString(n: n, base: base) + "_{\(base)} )="
                }
                latex = latex + String(prodpin)
                let s = ProductString(n: n, base: base)
                return latex + "=" + s
            }
        }
        return nil
    }
}

public class SheldonReverseNumberTester : NumTester {
    
    private func reverse(n: BigUInt, base : Int) -> BigUInt {
        if n == 0 { return 0 }
        var ans = BigUInt(0)
        
        var n = n
        while n > 0 {
            let d = n % BigUInt(base)
            ans = ans * BigUInt(base) + d
            n = n / BigUInt(base)
        }
        return ans
    }
    
    private func baseconv(n: BigUInt, base : Int) -> [Int] {
        if n == 0 { return [0] }
        var ans : [Int] = []
        
        var n = n
        while n > 0 {
            let d = Int(n % BigUInt(base))
            n = n / BigUInt(base)
            ans.insert(d, at: 0)
        }
        return ans
    }
    
    public func isSpecial(n: BigUInt, cancel: CalcCancelProt?) -> Bool? {
        if !n.isInt64() { return nil }
        if n < 2 { return false }
        
        var special = false
        //guard let info = stester.Info(n: n) else { return nil }
        let pin = PinTester10n.ml.Pin(n: UInt64(n))
        
        for base in 2...Int(n) {
            let revpin = reverse(n: BigUInt(pin), base: Int(base)) //12
            let rev = reverse(n: n, base: Int(base)) //37
            let pintest = PinTester10n.ml.Pin(n: UInt64(rev)) //12
            if pintest == revpin {
                print("n = \(String(n))")
                print("base=\(base) : n = \(baseconv(n: n, base: base))")
                print("base=\(base) : r = \(baseconv(n: rev, base: base)) = \(String(rev))")
                print("pin =\(pin) : \(baseconv(n: BigUInt(pin), base: base))")
                print("rpin=\(revpin) : \(baseconv(n: revpin, base: base))")
                special = true
            }
        }
        return special
    }
    
    
    private let stester = SheldonNumberTester()
    public init() {
    }
    
    public func property() -> String {
        return "Sheldon reverse number"
    }
    
    
    public func getLatex(n: BigUInt) -> String? {
        let latex = stester.getLatex(n: n)
        return latex
    }
}

