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

public class PalindromicTester : NumTester, TestDescriber {
    public init() {
        
    }
	private let radix = [10,2,4,16,12,20]
	public func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool? {
		if n < 11 { return false }
		let pbase = PalindromicBase(n: n)
		if pbase.isEmpty { return false }
		return true
	}
	
	public func PalindromicBase(n: BigUInt) -> [Int] {
		var ans : [Int] = []
		for r in radix {
			let s = String(n,radix :r)
			if ispalindromicString(s: s) {
				ans.append(r)
			}
		}
		return ans
	}
	
	private func ispalindromicString(s : String) -> Bool
	{
		let c = Array(s)
		if c.count <= 1 { return false }
		for i in 0..<c.count {
			if c[i] != c[c.count - i - 1] {
				return false
			}
		}
		return true
	}
	
//    func getDesc(n: BigUInt) -> String? {
//        var desc = WikiLinks.shared.getLink(tester: self, n: n)
//        let pbase = PalindromicBase(n: n)
//        if pbase.count == 0 { return nil }
//
//        if pbase.count == 1 && pbase[0] == 10 {
//            return desc
//        }
//        desc = desc + " It is palindromic in base:"
//        for b in pbase {
//            desc = desc + String(b) + " "
//        }
//        return desc
//    }
//
    public func getLatex(n: BigUInt) -> String? {
        let pbase = PalindromicBase(n: n)
        if pbase.count == 0 { return nil }
        var latex = String(n)
        for b in pbase {
            //var nstr = n.asString(toBase: b)
            latex = latex + " = " + String(n,radix : b).uppercased() + "_{" + String(b) + "}"
        }
        return latex

    }
    
    public func Desc(n: BigUInt) -> String {
        let pbase = PalindromicBase(n: n)
        if pbase.count == 0 { return "" }
        let nrstr = String(n)
        var desc = ""
        
        for b in pbase {
            desc = desc + nrstr + " is palindromic in base " + String(b) + "\n"
        }
        return desc
    }
	
	public func property() -> String {
		return "palindromic"
	}
	public func propertyString() -> String {
		return "palin\u{00AD}dromic"
	}
	
	
}

public class Palindromic2Tester : NumTester, TestDescriber {
    
    public init() {}
    
    static public func Pali2(n: BigUInt, b: Int = 10, cancel : CalcCancelProt?) -> (BigUInt,BigUInt)? {
        
        func isPalindromic(_ d: [Int]) -> Bool {
            let l = d.count
            for i in 0..<l {
                if d[i] != d[l-i-1] { return false }
            }
            return true
        }
        
        if n == 0 { return (0,0) }
        let d = n.getDigits(base: b)
        let nfirst = d[d.count-1]
        let m = d.count / 2
        
        if isPalindromic(d) {
            return (n,0)
        }
        
        for r in 0...1 {
            
            var p = Array(repeating: 0, count: d.count)
            var q = Array(repeating: 0, count: d.count)
            
            var loopcount = b
            for _ in 0...m-r {
                loopcount = loopcount * b
            }
            
            for _ in 0...loopcount - 1 {
                
                if cancel?.IsCancelled() ?? false { return nil }
                
                var j = 0
                repeat {
                    p[j] = p[j] + 1
                    p[d.count-j-1-r] = p[j]
                    if p[j] == b {
                        p[j] = 0
                        p[d.count-j-1-r] = p[j]
                        j = j + 1
                    } else {
                        break
                    }
                    
                } while j <= m-r
                
                if r == 0 && p[d.count-1] > d[d.count-1] {
                    continue // loop
                }
                //Potentielle q an erster Stelle
                //                let qtest = nfirst - p.last!
                //                if qtest < 0 {
                //                    continue
                //                }
                
                if p[0] == 0 {
                    continue
                }
                if j > m {
                    continue //r-loop
                }
                
                //Reflect
                //            for r in 0..<m {
                //                p[d.count-1-r] = p[r]
                //            }
                
                var carry = 0
                for k in 0..<d.count {
                    q[k] = d[k] - p[k] - carry
                    if q[k] < 0 {
                        carry = 1
                        q[k] = q[k] + b
                    } else {
                        carry = 0
                    }
                }
                if carry>0 {
                    continue
                }
                
                //sum
                var start = d.count
                repeat {
                    start = start - 1
                } while q[start] == 0 && start > 0
                
                var ispalindrom = true
                for l in 0...start {
                    if q[start-l] != q[l] {
                        ispalindrom = false
                        break
                    }
                }
                
                if ispalindrom {
                    var ansp : BigUInt = 0
                    var ansq : BigUInt = 0
                    for i in 0..<p.count {
                        ansp = ansp * BigUInt(b) + BigUInt(p[d.count-i-1])
                        ansq = ansq * BigUInt(b) + BigUInt(q[d.count-i-1])
                    }
                    return (ansp,ansq)
                }
            }
        }
        return nil
    }

    public func isSpecial(n: BigUInt, cancel: CalcCancelProt?) -> Bool? {
        if n.isPalindromic(base: 10) {
            return false
        }
        if let(a,b) = Palindromic2Tester.Pali2(n: n, b: 10, cancel: cancel) {
            return false
        }
        if cancel?.IsCancelled() ?? false { return nil }
        return true
    }
    
    public func property() -> String {
        return "not sum of 2 palindromes"
    }
    
    public func Desc(n: BigUInt) -> String {
        if n.isPalindromic(base: 10) { return "" }
        
        var latex = String(n) + "="
        if let (a,b) = Palindromic2Tester.Pali2(n: n, b: 10, cancel: TimeOut()) {
            latex = latex + String(a) + "+" + String(b)
        } else {
            let splitter = PalindromeSplitter(p: n, base: 10)
            splitter.Calc()
            latex = latex + String(splitter.p1) + "+"
            latex = latex + String(splitter.p2) + "+"
            latex = latex + String(splitter.p3)
        }
        return latex
    }
    
    public func propertyString() -> String {
        var prop = "Not the sum of two palindromes\n"
        return prop
    }
    
    public func getLatex(n: BigUInt) -> String? {
        if n.isPalindromic(base: 10) { return nil }
        var latex = String(n) + "="
        if let (a,b) = Palindromic2Tester.Pali2(n: n, b: 10, cancel: TimeOut()) {
            latex = latex + String(a) + "+" + String(b)
        } else {
            let splitter = PalindromeSplitter(p: n, base: 10)
            splitter.Calc()
            latex = latex + String(splitter.p1) + "+"
            latex = latex + String(splitter.p2) + "+"
            latex = latex + String(splitter.p3)
        }
        return latex
    }
    
    
}
