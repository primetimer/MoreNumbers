//
//  AbundanceTester.swift
//  Numbers
//
//  Created by Stephan Jancar on 11.12.17.
//  Copyright © 2017 Stephan Jancar. All rights reserved.
//

import Foundation
import BigInt
import PrimeFactors

public class SumOfTwoSquaresTester : NumTester, TestDescriber {
    public init() {}
    
    public func Desc(n: BigUInt) -> String {
        if let (a,b) = Express(n: n,cancel : TimeOut()) {
            let stra = String(a)
            let strb = String(b)
            let latex = String(n) + "=" + stra + "^2 + " + strb + "^2"
            return latex
        }
        return propertyString()
    }
    
    private func GaussianLatex(p: BigUInt) -> String? {
        if let (g1,g2) = GaussianInt.FactorPrime(p: p) {
            var latex = String(p) + "="
            let g1str = g1.asString()
            let g2str = g2.asString()
            
            latex = latex + "(" + g1str + ")"
            latex = latex + "(" + g2str + ")"
            return latex
        }
        return nil
    }
    
    private func EisensteinLatex(p: BigUInt) -> String? {
        if let (g1,g2) = EisensteinInt.FactorPrime(p: p) {
            var latex = String(p) + "="
            let g1str = g1.asString()
            let g2str = g2.asString()
            
            latex = latex + "(" + g1str + ")"
            latex = latex + "(" + g2str + ")"
            return latex
        }
        return nil
    }
    
    public func getLatex(n: BigUInt) -> String? {
        let special = isSpecial(n: n, cancel: nil) ?? false
        if !special { return nil }
        if let (a,b) = Express(n: n,cancel : TimeOut()) {
            let stra = String(a)
            let strb = String(b)
            let latex = String(n) + "=" + stra + "^2 + " + strb + "^2"
            
            
            let glatex = GaussianLatex(p: n) ?? ""
            let elatex = EisensteinLatex(p: n) ?? ""
            
            return latex + "\\\\" + glatex + "\\\\" + elatex
        }
        return nil
    }
	public func property() -> String {
		return "sum of two squares"
	}
	
	private func mods(_ a: BigInt, _ n: BigInt) -> BigInt {
		assert(n>0)
		let amodn = a % n
		if (2 * amodn > n) {
			return amodn - n
		}
		return amodn
	}
	
	private func powmods(_ aa : BigInt, _ rr : BigInt, _ n: BigInt) -> BigInt {
		var out : BigInt = 1
		var r = rr
		var a = aa
		while r > 0 {
			if (r % 2) == 1 {
				r = r - 1
				out = mods(out * a, n)
			}
			r = r / 2
			a = mods(a * a, n)
		}
		return out
	}
	
	private func quos(_ a : BigInt, _ n: BigInt) -> BigInt {
		return (a - mods(a, n)) / n
	}
	
	private func GaussRemainder(_ w0: BigInt, _ w1: BigInt, _ z0: BigInt, _ z1 : BigInt) -> (BigInt,BigInt) {
		//Divide w by z
		let n = z0 * z0 + z1 * z1
		assert(n != 0)
		let u0 = quos(w0 * z0 + w1 * z1, n)
		let u1 = quos(w1 * z0 - w0 * z1, n)
		let r1 = w0 - z0 * u0 + z1 * u1
		let r2 = w1 - z0 * u1 - z1 * u0
		return (r1,r2)
	}
	
	private func ggcd(_ ww: (BigInt,BigInt), _ zz:(BigInt,BigInt)) -> (BigInt,BigInt) {
		var z = zz
		var w = ww
		while z != (0,0) {
			let temp = GaussRemainder(w.0, w.1, z.0, z.1)
			w = z
			z = temp
		}
		return w
	}
	
	private func root4(p : BigInt) -> BigInt {
		//# 4th root of 1 modulo p
		assert(p>1)
		assert(p % 4 == 1)
		let k = p / 4
		var j : BigInt = 2
		while true {
			let a = powmods(j, k, p)
			let b = mods(a * a, p)
			if b == -1 {
				return a
			}
			//assert( b != 1) //not a prime input
		
			j = j + 1
		}
	}
	
	private func sq2(p : BigInt) -> (BigInt,BigInt) {
		if p <= 1 { return (0,1) }
		if p == 2 { return (1,1) }
		let r = root4(p: p)
		var (a,b) = ggcd((p,0),(r,1))
		if a < 0 { a = -a }
		if b < 0 { b = -b }
		return(a,b)
	}
	
	public func Express(n: BigUInt,cancel: CalcCancelProt?) -> (a: BigUInt, b:BigUInt)? {
		if n <= 1 {
			return nil
		}
		if n == 2 {
			return (1,1)
		}
		if n.isPrime() {
			if n % 4 == 3 { return nil }
			let (a,b) = sq2(p: BigInt(n))
			return (BigUInt(a),BigUInt(b))
		}
		
		let factors = FactorsWithPot(n: n, cancel: cancel)
		if cancel?.IsCancelled() ?? false { return nil }
		if factors.unfactored > 1  { return nil }
		var squarerest : BigUInt = 1
		var singlefactors : [BigUInt] = []
		for f in factors.factors {
            if f.f != BigUInt(2) {
                if (f.f % 4 != 1 ) && (f.e % 2 == 1) {
                    return nil
                }
            }
			if f.e % 2 == 1 {
				singlefactors.append(f.f)
				squarerest = squarerest * f.f.power((f.e-1) / 2 )
			}
			else {
				squarerest = squarerest * f.f.power((f.e) / 2 )
			}
		}
		
		//Zerlege die einzelnen Faktoren
		var (a,b) = (BigInt(1),BigInt(0))
		for s in singlefactors {
			let (c,d) = sq2(p: BigInt(s))
			(a,b) = (a*c+b*d,a*d-b*c)
		}
		if a < 0 { a = -a }
		if b < 0 { b = -b }
		let reta = BigUInt(a) * squarerest
		let retb = BigUInt(b) * squarerest
		
		return (a: BigUInt(reta), b: BigUInt(retb))
	}
	public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		if n <= 1 { return false }
		if n == 2 { return true }
		if n.isPrime() {
			if n % 4 != 1 { return false }
			return true
		}
		let factors = FactorsWithPot(n: n, cancel : cancel)
		if factors.unfactored > 1 { return nil }
		for f in factors.factors {
			if (f.e % 2 == 1) && (f.f % 4 == 3) { return false }
		}
		return true
	}
	
	//NUmber of ways to write n = a^2 + b^2
	func r2(n: BigUInt,cancel: CalcCancelProt?) -> BigUInt {
		if n == 0 { return 1 }
		var (ans,d1,d3) = (0,0,0)
		let divisors = FactorCache.shared.Divisors(p: n,cancel: cancel)
		if cancel?.IsCancelled() ?? false { return 0 }
		for d in divisors {
			switch Int(d % 4) {
			case 1:
				d1 = d1 + 1
			case 3:
				d3 = d3 + 1
			default:
				break
			}
		}
		ans = 4*(d1 - d3)
		return BigUInt(ans)
	}
}


public class SumOf4SquaresTester: NumTester,TestDescriber {
    public init() {}
    public func isSpecial(n: BigUInt, cancel: CalcCancelProt?) -> Bool? {
        if n < 7 { return false }
//        let r = n.squareRoot()
        if (BigInt(n) / divisor(BigInt(n), factor : 4)) % 8 != 7 {
            return false
        }
        return true
    }
    
    public func property() -> String {
        return "Only sum of 4 squares"
    }
    
    public func Desc(n: BigUInt) -> String {
        var latex = ""
        guard let sq = squareTerms(n: n, cancel: TimeOut()) else { return "" }
        for q in sq {
            if latex.count > 0 { latex = latex + "+" }
            latex = latex + String(q) + "^2"
        }
        latex = String(n) + "=" + latex
        
        if let hfactors = HurwitzInt.FactorHurwitz(n: n, cancel: TimeOut()) {
            var more = ""
            for (i,h) in hfactors.enumerated() {
                if !more.isEmpty { more = more + "*" }
                more = more + "(" + h.0.asString() + ")"
                if h.pow > 1 { more = more + "^{ \(h.pow) }" }
                if i % 2 == 1 { more = more + "\n" }
            }
            more = "\(n) = " + more
            more = more + "i^2=j^2=k^2 = ijk = -1"
            latex = latex + "\n" + more
        }
        
        return latex

    }
    
    public func getLatex(n: BigUInt) -> String? {
        var latex = ""
        guard let sq = squareTerms(n: n, cancel: TimeOut()) else { return nil }
        for q in sq {
            if latex.count > 0 { latex = latex + "+" }
            latex = latex + String(q) + "^{2}"
        }
        latex = String(n) + "=" + latex
        
        if let hfactors = HurwitzInt.FactorHurwitz(n: n, cancel: TimeOut()) {
            var more = ""
            for (i,h) in hfactors.enumerated() {
                if !more.isEmpty { more = more + "\\cdot" }
                more = more + "(" + h.0.asString() + ")"
                if h.pow > 1 { more = more + "^{ \(h.pow) }" }
                if i % 2 == 1 { more = more + "\\\\" }
            }
            more = "\(n) = " + more
            more = more + "i^2=j^2=k^2 = ijk = -1"
            latex = latex + "\\\\" + more
        }
        
        return latex
        
    }
    
    
    
    private let sum2tester = SumOfTwoSquaresTester()
    
    private func divisor(_ n: BigInt, factor: BigInt) -> BigInt {
        var n = n
        var divisor = BigInt(1)
        while (n % factor == 0) {
            n = n / factor;
            divisor = divisor * factor;
        }
        return divisor
    }
    
    public func squareTerms(n : BigUInt, cancel : CalcCancelProt?) -> [BigInt]? {
        if n == 0 { return [BigInt(0),BigInt(0),BigInt(0),BigInt(0)] }
        if n == 1 { return [BigInt(1),BigInt(0),BigInt(0),BigInt(0)] }
        var res = [BigInt(1),BigInt(0),BigInt(0),BigInt(0)]
        let factors = FactorCache.shared.Factor(p: n, cancel: cancel)

        for f in factors.factors {
            if cancel?.IsCancelled() ?? false { return nil}
            guard let sq = squareTerms4Primes(p: f, cancel: cancel) else { return nil }
            
//            print(res)
//            print(sq)
            var prod = [BigInt(0),BigInt(0),BigInt(0),BigInt(0)]
            
            prod = [
                res[0]*sq[0] + res[1]*sq[1] + res[2]*sq[2] + res[3]*sq[3],
                res[0]*sq[1] - res[1]*sq[0] + res[2]*sq[3] - res[3]*sq[2],
                res[0]*sq[2] - res[1]*sq[3] - res[2]*sq[0] + res[3]*sq[1],
                res[0]*sq[3] + res[1]*sq[2] - res[2]*sq[1] - res[3]*sq[0] ]
            
            res = prod
//               print(res)
            
            
        }
        return res
        
    }
    
    public func squareTerms4Primes(p : BigUInt, cancel : CalcCancelProt?) -> [BigInt]? {
        var res = [BigInt(1),BigInt(0),BigInt(0),BigInt(0)]
        
        var sq1 = BigInt(p.squareRoot())
        var n2 = BigInt(p) - sq1*sq1
        
        // 1. Find a suitable first square
        while sq1 > 0 {
            if cancel?.IsCancelled() ?? false { return nil }
            // A number can be written as a sum of three squares
            // <==> it is NOT of the form 4^a(8b+7)
            if ( (n2 / divisor(n2, factor : 4)) % 8 != 7 ) {
                break
            }
            sq1 = sq1 - 1
            n2 = BigInt(p) - sq1*sq1
        }
        
        var sq2 = BigInt(0)
        while n2 > sq2*sq2 {
            let n3 = n2 - sq2*sq2
            if n3 == 1 {
                res[0] = sq1
                res[1] = 1
                return res
            }
            if cancel?.IsCancelled() ?? false { return nil }
            guard let special = TesterCache.shared.TestSpecial(tester: sum2tester, n: n3.magnitude, cancel: cancel) else {
                return nil
            }
            if special {
                guard let (a,b) = sum2tester.Express(n: n3.magnitude, cancel: cancel) else { return nil }
                res[0] = sq1
                res[1] = sq2
                res[2] = BigInt(a)
                res[3] = BigInt(b)
//                print(res)
                return res
            }
            
            sq2 = sq2 + 1
        }
//        assert(false)
        return nil
    }
}

public class SumOf3SquaresTester: NumTester, TestDescriber {
    public init() {}
    public func isSpecial(n: BigUInt, cancel: CalcCancelProt?) -> Bool? {
        if n < 3 { return false }
        
        let sum2special = TesterCache.shared.TestSpecial(tester: sum2tester, n: n, cancel: cancel) ?? false
        if sum2special {
            return false
        }
        if (BigInt(n) / divisor(BigInt(n), factor : 4)) % 8 != 7 {
            return true
        }
        return false
    }
    
    public func property() -> String {
        return "sum of 3 squares"
    }
    
    public func getLatex(n: BigUInt) -> String? {
        var latex = ""
        guard let sq = squareTerms(n: n, cancel: TimeOut()) else { return nil }
        for q in sq {
            if latex.count > 0 { latex = latex + "+" }
            latex = latex + String(q) + "^{2}"
        }
        latex = String(n) + "=" + latex
        return latex
        
    }
    
    public func Desc(n: BigUInt) -> String {
        
        var latex = ""
        guard let sq = squareTerms(n: n, cancel: TimeOut()) else { return "" }
        for q in sq {
            if latex.count > 0 { latex = latex + "+" }
            latex = latex + String(q) + "^2"
        }
        latex = String(n) + "=" + latex
        return latex
        
    }
    private let sum2tester = SumOfTwoSquaresTester()
    
    private func divisor(_ n: BigInt, factor: BigInt) -> BigInt {
        var n = n
        var divisor = BigInt(1)
        while (n % factor == 0) {
            n = n / factor;
            divisor = divisor * factor;
        }
        return divisor
    }
    
    public func squareTerms(n : BigUInt, cancel : CalcCancelProt?) -> [BigInt]? {
        if n == 0 { return [BigInt(0),BigInt(0),BigInt(0)] }
        if n == 1 { return [BigInt(1),BigInt(0),BigInt(0)] }
        var res = [BigInt(1),BigInt(0),BigInt(0)]
        
        let n2 = BigInt(n)
        var sq2 = BigInt(0)
        while n2 > sq2*sq2 {
            let n3 = n2 - sq2*sq2
            if n3 == 1 {
                res[0] = sq2
                res[1] = 1
                return res
            }
            if cancel?.IsCancelled() ?? false { return nil }
            guard let special = sum2tester.isSpecial(n: n3.magnitude, cancel: cancel) else { return nil }
            if special {
                guard let (a,b) = sum2tester.Express(n: n3.magnitude, cancel: cancel) else { return nil }
                res[0] = sq2
                res[1] = BigInt(a)
                res[2] = BigInt(b)
                //                print(res)
                return res
            }
            
            sq2 = sq2 + 1
        }
        //        assert(false)
        return nil
    }
}



