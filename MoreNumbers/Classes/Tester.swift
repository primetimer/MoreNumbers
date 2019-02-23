//
//  Tester.swift
//  Numbers
//
//  Created by Stephan Jancar on 10.12.17.
//  Copyright © 2017 Stephan Jancar. All rights reserved.
//

import Foundation
import BigInt
import PrimeFactors

public protocol NumTester {
	func isSpecial(n: BigUInt, cancel : CalcCancelProt?) -> Bool?
	func property() -> String	        //Name of tested property
	func invers() -> NumTester?
	func subtester() -> [NumTester]?
	func issubTester() -> Bool
}

public extension NumTester {
	func invers() ->  NumTester? { return nil }
	func subtester() -> [NumTester]? { return nil }
	func issubTester() -> Bool { return false }
    func propertyString() -> String { return property() } //Includes hyphenation
}

public class EverTrueTester : NumTester {
	public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		return true
	}
	public func property() -> String {
		return "number"
	}
}

public class Tester {
	public func property() -> String {
		return "Interesting"
	}
	
	public static var shared = Tester()
	public static let testers : [NumTester] = [
        NarcisticTester(),
		ExtraTester(),BigNumberTester(),PrimeTester(), SemiPrimeTester(),
		CarmichaelTester(),AbundanceTester(),
		TriangleTester(),PronicTester(),SquareTester(),CubeTester(),
		FibonacciTester(),TetrahedralTest(),
		PentagonalTester(),HexagonalTester(),
		Pow2Tester(),MersenneTester(),TitanicTester(),HeegnerTester(),
		PerfectTester(),ProthTester(),FermatTester(),ConstructibleTester(),
		HCNTester(),SumOfTwoSquaresTester(),SumOfTwoCubesTester(),TaxiCabTester(),
		SierpinskiTester(),CatalanTester(),NonTotientTester(),
		PlatonicTester(),
		PalindromicTester(),PandigitalTester(), LucasTester(),SupersingularTester(),
		HappyTester(),LookAndSayTester(),AudioActiveTester(),
		LuckyTester(),
		SmithTester(),
		MathConstantTester(),LatticeTester(),BernoulliTester()
		//,IrregularTester()
	]
	
	public static let xtesters : [NumTester] = [TwinPrimeTester(),CousinPrimeTester(),SexyPrimeTester(),
								  SOGPrimeTester(),SafePrimeTester()]
	
	static public var completetesters : [NumTester] = []
	private init() {
		for t in Tester.testers {
			Tester.completetesters.append(t)
			if t.invers() != nil { Tester.completetesters.append(t.invers()!)}
			if t.subtester() != nil {
				for sub in t.subtester()! {
					Tester.completetesters.append(sub)
				}
			}
		}
	}
	
	public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		return true //!isDull(n: n)
	}
}

public class TriangleTester : NumTester {
	public func property() -> String {
		return "triangle"
	}
	public func propertyString() -> String {
		return "tri\u{00AD}angle"
	}
	private func triangleroot(n: BigUInt) -> BigUInt? {
		let m = (8 * n + 1)
		let r = m.squareRoot()
		if r*r != m { return nil }
		
		let t = (r - 1)
		if t % 2 == 0 {
			return t / 2
		}
		return nil
	}
	
	public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		if n == 0 { return false }
		if triangleroot(n: n) != nil {
			return true
		}
		return false
	}
}

public class PronicTester : NumTester {
    public func property() -> String {
        return "pronic"
    }
    public func propertyString() -> String {
        return "pro\u{00AD}nic"
    }
    
    public func pronicroot(n: BigUInt) -> BigUInt? {
        let r = n.squareRoot()
        if r*(r+1) == n { return r }
        return nil
    }
    public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
        if n == 0 { return false }
        if pronicroot(n: n) != nil {
            return true
        }
        return false
    }
}


class PentagonalTester : NumTester {
	public func property() -> String {
		return "pentagonal"
	}
	public func propertyString() -> String {
		return "penta\u{00AD}gonal"
	}
	public func pentagonalroot(n: BigUInt) -> BigUInt? {
		let m = (24 * n + 1)
		let r = m.squareRoot()
		if r*r != m { return nil }
		let t = r + 1
		if t % 6 == 0 {
			return t / 6
		}
		return nil
	}
	public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		if pentagonalroot(n: n) != nil {
			return true
		}
		return false
	}
}

class Pow2Tester : NumTester {
	func property() -> String {
		return "power of two"
	}
	func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		if n == 0 { return false }
		if n == 1 { return true }
        if n == 2 { return true }
		var nn = n
		while nn>1 {
			if nn % 2 != 0 {
				return false
			}
			nn = nn / 2
		}
		return true
	}
}


class HexagonalTester : NumTester {
	func property() -> String {
		return "hexagonal"
	}
	func propertyString() -> String {
		return "hexa\u{00AD}gonal"
	}
	
	public func hexroot(n: BigUInt) ->BigUInt? {
		let m = 8 * n + 1
		let r = m.squareRoot()
		if r * r != m {
			return nil
		}
		if r + 1 % 4 == 0 {
			return (r+1) / 4
		}
		return nil
	}
	func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		if let _ = hexroot(n: n) {
			return true
		}
		return false
	}
}


class SquareTester : NumTester {
	func property() -> String {
		return "square"
	}
	func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool? {
		if n == 0 { return false }
		let r = n.squareRoot()
		return r*r == n
	}
}

class CubeTester : NumTester {
	func property() -> String {
		return "cube"
	}
	func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		if n == 0 { return false }
		let r = n.iroot3()
		return r*r*r == n
	}
}

class FibonacciTester : NumTester {
	public func property() -> String {
		return "Fibonacci"
	}
	public func propertyString() -> String {
		return "Fibo\u{00AD}nacci"
	}
	public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		if n == 0 { return false }
		if n == 1 { return true }
		let n2 = n*n //Double(n) * Double(n)
		let x1 = 5*n2 + 4
		let x2 = 5*n2 - 4
		let r1 = x1.squareRoot()
		let r2 = x2.squareRoot()
		if r1*r1 == x1 || r2*r2 == x2 {
			return true
		}
		return false
	}
	
	public static func Fn(n: Int) -> Double {
		let phi = Double.phi
		let psi = Double.psi
		let f1 = pow(phi,Double(n))
		let f2 = pow(psi,Double(n))
		let ans = (f1-f2) / sqrt(5.0)
		return ans
	}
	
	public func NIndex(n: BigUInt) -> Int {
		let phi = (1.0 + sqrt(5)) / 2.0
		let a = Double(n)*sqrt(5.0)+0.5
		let l = log(a) / log(phi)
		let nth = floor(l)
		return Int(nth)
	}
	
	private func prev(n: BigUInt) -> BigUInt {
		let phi = Double.phi
		let nbyphi = Double(n) / phi
		let round = Darwin.round(nbyphi)
		let previ = BigUInt(round)
		guard let special = isSpecial(n: n, cancel: nil) else { return 0 }
		if !special { return 0 }
		return previ
	}
}

class LucasTester : NumTester {
	func property() -> String {
		return "Lucas"
	}
	
	public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		if n == 0 { return false }
		if n <= 3 { return true }
		var (l1,l2,l3) = (BigUInt(2),BigUInt(1),BigUInt(3))
		
		while n>l3 {
			l3 = l1 + l2
			l1 = l2
			l2 = l3
		}
		if n == l3 {
			return true
		}
		return false
	}
	
	public func prev(n: BigUInt) -> (BigUInt,BigUInt) {
		if n == 1 { return (0,1) }
		if n == 2 { return (0,2) }
		if n == 3 { return (1,2) }
		var (l1,l2,l3) = (BigUInt(2),BigUInt(1),BigUInt(3))
		
		while n>=l3 {
			l3 = l1 + l2
			if n == l3 { return (l1,l2) }
			l1 = l2
			l2 = l3
		}
		return (0,0)
	}
	
	static public func NIndex(n: BigUInt) -> Int {
		let a = Double(n)*sqrt(5.0)+0.5
        let phi = Double.phi
        
		let l = log(a) / log(phi)
		let nth = floor(l)
		return Int(nth)
	}
	static public func Ln(n: Int) -> Double {
        let phi = Double.phi //(1.0 + sqrt(5.0)) / 2.0
        let psi = Double.psi //(1.0 - sqrt(5.0)) / 2.0
		let f1 = pow(phi,Double(n))
		let f2 = pow(psi,Double(n))
		let ans = f1+f2
		return ans
	}
}

/*
class RamanujanNagellTester : MersenneTester {
	override public func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool {
		if n == 0 { return false }
		return OEIS.shared.ContainsNumber(key: self.property(), n: n)
	}
	
	override func getLatex(n: BigUInt) -> String? {
		return nil //Solved by TriangleTester && MersenneTester
	}
	
	override func property() -> String {
		return "Ramanujan-Nagell"
	}
}
*/

