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


public class CompositeTester : NumTester {
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

public struct GaussianInt {
	var a: BigInt = 0
	var i: BigInt = 0
	init(_ a: BigInt, i : BigInt) {
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
	
	public static func FactorPrime(p : BigUInt ) -> (GaussianInt,GaussianInt)? {
		if p == 2 {
			let g1 = GaussianInt(1,i: 1)
			let g2 = GaussianInt(1,i:-1)
			return (g1,g2)
		}
		if p % 4 == 3 {
			return nil
		}
		if let (a,b) = SumOfTwoSquaresTester().Express(n: p,cancel : TimeOut()) {
			let g1 = GaussianInt(BigInt(a),i:BigInt(b))
			let g2 = GaussianInt(BigInt(a),i:-BigInt(b))
			return (g1,g2)
		}
		return nil
	}
}

public struct EisensteinInt {
	var a: BigInt = 0
	var w: BigInt = 0
	init(_ a: BigInt, w : BigInt) {
		self.a = a
		self.w = w
	}
	
	#if false
	func asString() -> String {
		let wstr = " e^{\\frac{\\pi i}{3}}"
		var ans = String(a)
		if self.w == 1 {
			ans = ans + "+" + wstr
		} else if self.w == -1 {
			ans = ans + "-" + wstr
		} else if w > 0 {
			ans = ans + "+" + String(self.w) + wstr
		} else if w < 0 {
			ans = ans + String(self.w) + wstr
		}
		return ans
	}
	#else
	func asString() -> String {
		let wstr = "\\omega"
		let wstr2 = "\\omega^2"
		var ans = String(a)
		if self.w == 1 {
			ans = ans + "+" + wstr
		} else if self.w == -1 {
			ans = ans + "+" + wstr2
		} else if w > 0 {
			ans = ans + "+" + String(self.w) + wstr
		} else if w < 0 {
			ans = ans + "+" + String(-self.w) + wstr2
		}
		return ans
	}
	
	#endif
	
	public static func FactorPrime(p : BigUInt ) -> (EisensteinInt,EisensteinInt)? {
		/*
		if p == 3 {
			let g1 = EisensteinInt(-1,w: -2)
			let g2 = EisensteinInt(1,w: 2)
			return (g1,g2)
		}
		*/
		if p % 3 == 2 {
			return nil
//			let g1 = EisensteinInt(BigInt(p),w: 0)
//			let g2 = EisensteinInt(1,w: 0)
//			return (g1,g2)
		}
		
		//Suche a+bw mit a^2-ab+b^2 = p
		for a in 0..<BigInt(p) {
			for b in 0..<BigInt(p) {
				let d = a*a-a*b+b*b
				if d == p {
					let g1 = EisensteinInt(a,w: b)
					let g2 = EisensteinInt(a,w: -b)
					return (g1,g2)
				}
				if d > p { break }
			}
		}
		assert(false)
		return nil
	}
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



