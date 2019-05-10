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


public class CompositeTester : NumTester, TestDescriber {
    public func Desc(n: BigUInt) -> String {
        let basedesc = TesterDescriber.defaultDesc(n:n,tester: self) ?? ""
        let factorstr = FactorCache.shared.Desc(n: n, withpot: true, cancel: TimeOut()) ?? ""
        return basedesc + "\n" + factorstr
    }
    
    public func getLatex(n: BigUInt) -> String? {
        return FactorCache.shared.Latex(n: n, withpot: true, cancel: TimeOut())
    }
    
    public init() {}
	public func property() -> String {
		return "composite"
	}
	public func propertyString() -> String {
		return "com\u{00AD}po\u{00AD}site"
	}
	public func isSpecial(n: BigUInt, cancel : CalcCancelProt?) -> Bool? {
		if n <= 2 { return false }
		return !PrimeCache.shared.IsPrime(p:n)
	}
}

public struct GaussianInt : CustomStringConvertible, Equatable {
    public var description: String { return self.asString() }
	public private (set) var a: BigInt = 0
	public private (set) var i: BigInt = 0
	init(_ a: BigInt, i : BigInt = 0 ) {
		self.a = a
		self.i = i
	}
	
	public func asString() -> String {
		var ans = String(a)
		if self.i == 1 {
			ans = ans + "+i"
		} else if self.i == -1 {
			ans = ans + "-i"
		} else if i > 0 {
			ans = ans + "+" + String(self.i) + "i"
		} else if i < 0 {
			ans = ans + String(self.i) + "i"
		}
		return ans
	}
	
	public static func FactorPrime(p : BigUInt ) -> (GaussianInt,GaussianInt?)? {
		if p == 2 {
			let g1 = GaussianInt(1,i: 1)
			let g2 = GaussianInt(1,i:-1)
			return (g1,g2)
		}
		if p % 4 == 3 {
			return (GaussianInt(BigInt(p), i: 0),nil)
		}
		if let (a,b) = SumOfTwoSquaresTester().Express(n: p,cancel : TimeOut()) {
			let g1 = GaussianInt(BigInt(a),i:BigInt(b))
			let g2 = GaussianInt(BigInt(a),i:-BigInt(b))
			return (g1,g2)
		}
		return nil
	}
}

public func +(_ lhs: GaussianInt, _ rhs: GaussianInt) -> GaussianInt {
    
    let ans = GaussianInt(lhs.a+rhs.a,i: lhs.i+rhs.i)
    return ans
    
}

public func -(_ lhs: GaussianInt, _ rhs: GaussianInt) -> GaussianInt {
    let ans = GaussianInt(lhs.a-rhs.a,i: lhs.i-rhs.i)
    return ans
}

public func *(_ lhs: GaussianInt, _ rhs: GaussianInt) -> GaussianInt {
   
    let a = lhs.a*rhs.a-lhs.i*rhs.i
    let i = lhs.a*rhs.i+rhs.a*lhs.i
    let ans = GaussianInt(a, i: i)
    return ans
}

public func +(_ lhs: HurwitzInt, _ rhs: HurwitzInt) -> HurwitzInt {
    
    var a : [BigInt] = [0,0,0,0]
    
    for i in 0...3 {
        a[i] = lhs.a[i] + rhs.a[i]
    }
    let ans = HurwitzInt(a)
    return ans 
    
}

public func -(_ lhs: HurwitzInt, _ rhs: HurwitzInt) -> HurwitzInt {
    
    var a : [BigInt] = [0,0,0,0]
    
    for i in 0...3 {
        a[i] = lhs.a[i] - rhs.a[i]
    }
    let ans = HurwitzInt(a)
    return ans
    
}

public func *(_ lhs: HurwitzInt, _ rhs: HurwitzInt) -> HurwitzInt {
    
    let lhsa = lhs.a
    let rhsa = rhs.a
    
    let prod = [
        lhsa[0]*rhsa[0] - lhsa[1]*rhsa[1] - lhsa[2]*rhsa[2] - lhsa[3]*rhsa[3],
        lhsa[0]*rhsa[1] + lhsa[1]*rhsa[0] - lhsa[2]*rhsa[3] + lhsa[3]*rhsa[2],
        lhsa[0]*rhsa[2] + lhsa[1]*rhsa[3] + lhsa[2]*rhsa[0] - lhsa[3]*rhsa[1],
        lhsa[0]*rhsa[3] - lhsa[1]*rhsa[2] + lhsa[2]*rhsa[1] + lhsa[3]*rhsa[0] ]
    
    let ans = HurwitzInt(prod)
    return ans
    
}


public struct HurwitzInt : CustomStringConvertible, Equatable {
    public var description: String { return self.asString() }
    
    public private (set) var a: [BigInt] = [0,0,0,0]
    
    public init(_ a: [BigInt]) {
        self.a = a
    }
    public init(_ h : HurwitzInt) {
        self.a = h.a
    }
    public init(_ a: BigInt) {
        self.a = [a,0,0,0]
    }
    
    public mutating func conjugate() {
        for i in 1...3 {
            self.a[i] = -self.a[i]
        }
    }
    
    public var conj : HurwitzInt {
        var hquer = HurwitzInt(self)
        hquer.conjugate()
        return hquer
    }
    
    
    
    public func asString() -> String {
        
        func format(x : BigInt, i : String) -> String {
            if x == 1 {
                return "+\(i)"
            } else if x == -1 {
                return "-\(i)"
            } else if x > 0 {
                return "+\(x)\(i)"
            } else if x < 0 {
                return "-\(x)\(i)"
            }
            return ""
        }
        
        var ans = String(a[0])
        ans = ans + format(x: a[1], i: "i")
        ans = ans + format(x: a[2], i: "j")
        ans = ans + format(x: a[3], i: "k")
        return ans
    }
    
    private static let sum4tester = SumOf4SquaresTester()
    
    public static func FactorHurwitz(n : BigUInt, cancel: CalcCancelProt? = nil) -> [(h: HurwitzInt,pow: Int)]? {
        
        var ans : [(h: HurwitzInt,pow : Int)] = []
        var hf: [HurwitzInt] = []
        if n == 1 { return ans }
        let factors = FactorCache.shared.Factor(p: n, cancel: cancel)
        for f in factors.factors {
            guard let sq = sum4tester.squareTerms4Primes(p: f, cancel: cancel) else { return nil }
            let h = HurwitzInt(sq)
            hf.append(h)
            hf.append(h.conj)
         }
        
        for h in hf {
            var found = false
            for j in 0..<ans.count {
               
                if h == ans[j].h {
                    ans[j].pow += 1
                    found = true
                    break
                }
            }
            if !found {
                ans.append((h:h,pow:1))
            }
        }
    
        return ans
    }
}



