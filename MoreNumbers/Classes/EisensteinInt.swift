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

public struct EisensteinInt : CustomStringConvertible, Equatable  {
	
    public var description: String { return self.asString() }

    public private (set) var a: BigInt = 0
	public private (set) var w: BigInt = 0
	public init(_ a: BigInt, w : BigInt = 0) {
		self.a = a
		self.w = w
	}
    
	func asStringLatex() -> LatexString {
		let wstr = " e^{\\frac{2\\pi i}{3}}"
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

	func asString() -> String {
        var ans = String(a)
        let wstr = "ω"
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
//
//        let wstr = "\\omega"
////        let wstr2 = "\\omega^2"
//        var ans = String(a)
//        if self.w == 1 {
//            ans = ans + "+" + wstr
//        } else if self.w == -1 {
//            ans = ans + "+" + wstr2
//        } else if w > 0 {
//            ans = ans + "+" + String(self.w) + wstr
//        } else if w < 0 {
//            ans = ans + "+" + String(-self.w) + wstr2
//        }
//        return ans
	}
    
    public mutating func conjugate() {
        let tmp = self.conj
        self.a = tmp.a
        self.w = tmp.w
    }
    
    public var conj : EisensteinInt {
        
        //w = 1/2 ( -1 + i *√3)
        //w^2 = -1 - w
        
        //a + bw = (a - b/2 , b/2 √3)
        //conj(w) = w^2 = -1-w
        //conj(a+bw) = a-b-w
        
        let ans = EisensteinInt(a-w, w: -w)
        return ans
    }

	
	public static func FactorPrime(p : BigUInt ) -> (EisensteinInt,EisensteinInt?)? {
		
		if p == 3 {
			let g1 = EisensteinInt(-1,w: -2)
			let g2 = EisensteinInt(1,w: 2)
			return (g1,g2)
		}
		
		if p % 3 == 2 {
            assert(p.isPrime())
			let g1 = EisensteinInt(BigInt(p),w: 0)
			//let g2 = EisensteinInt(1,w: 0)
			return (g1,nil)
		}
		
		//Suche a+bw mit a^2-ab+b^2 = p
		for a in 0..<BigInt(p) {
			for b in 0..<BigInt(p) {
                
            
				let d = a*a-a*b+b*b
                
				if d == p {
                    
                    //(a+bw)*(a+bw^2) =
                    // (a+bw)*(a-b-bw) =
                    // a*(a-b) + abw -abw - b^2*w^2 = a^2 - ab - b^2(-1-w) =
                    
					let g1 = EisensteinInt(a,w: b)
					let g2 = EisensteinInt(a-b,w: -b)
                    let dummy = g1*g2
                    print(p,dummy)
					return (g1,g2)
				}
				if d > p { break }
			}
		}
        assert(false)
		return nil
	}
    
    public static func FactorEisenstein(n : BigUInt, cancel: CalcCancelProt? = nil) -> [(h: EisensteinInt,pow: Int)]? {
        var ans : [(h: EisensteinInt,pow : Int)] = []
        var hf: [EisensteinInt] = []
        if n == 1 { return ans }
        let factors = FactorCache.shared.Factor(p: n, cancel: cancel)
        for f in factors.factors {
            if let (a,b) = FactorPrime(p: f) {
                hf.append(a)
                if b != nil { hf.append(b!) }
            }
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

public func +(_ lhs: EisensteinInt, _ rhs: EisensteinInt) -> EisensteinInt {
    let a = lhs.a + rhs.a
    let w = lhs.w + rhs.w
    let ans = EisensteinInt(a, w: w)
    return ans 
    
}

public func -(_ lhs: EisensteinInt, _ rhs: EisensteinInt) -> EisensteinInt {
    let a = lhs.a - rhs.a
    let w = lhs.w - rhs.w
    let ans = EisensteinInt(a, w: w)
    return ans
}

public func *(_ lhs: EisensteinInt, _ rhs: EisensteinInt) -> EisensteinInt {
    
    let a = lhs.a
    let b = lhs.w
    let c = rhs.a
    let d = rhs.w
   
    let ac = a*c
    let w = a*d+b*c
    let w2 = b*d
    
    
    
    let ans = EisensteinInt(ac - w2, w: w-w2)
    return ans
}





