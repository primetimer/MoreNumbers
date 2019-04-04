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
    func getLatex(n: BigUInt) -> String?
}

public extension NumTester {
	func invers() ->  NumTester? { return nil }
	func subtester() -> [NumTester]? { return nil }
	func issubTester() -> Bool { return false }
    func propertyString() -> String { return property() } //Includes hyphenation
}

//public extension NumTester {
//    func getLatex(n: BigUInt) ->  String? { return nil }
//}

public class EverTrueTester : NumTester {
    public func getLatex(n: BigUInt) -> String? {
        return nil
    }
    
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
//        ExtraTester(),
        BigNumberTester(),PrimeTester(), SemiPrimeTester(),
//        CarmichaelTester(),
        AbundanceTester(),
		TriangleTester(),PronicTester(),SquareTester(),CubeTester(),
		FibonacciTester(),TetrahedralTest(),
		PentagonalTester(),HexagonalTester(),
		Pow2Tester(),MersenneTester(),TitanicTester(),HeegnerTester(),
		PerfectTester(),ProthTester(),FermatTester(),ConstructibleTester(),
		HCNTester(),SumOfTwoSquaresTester(),SumOfTwoCubesTester(),TaxiCabTester(),
		SierpinskiTester(),CatalanTester(),NonTotientTester(),
		PlatonicTester(),
		PalindromicTester(),PandigitalTester(), LucasTester(),SupersingularTester(),
		HappyTester(),
//        LookAndSayTester(),
        AudioActiveTester(),
		LuckyTester(),
		SmithTester(),
//        MathConstantTester(),
        LatticeTester(),
        BernoulliTester()
		//,IrregularTester()
	]
	
	public let xtesters : [NumTester] = [TwinPrimeTester(),CousinPrimeTester(),SexyPrimeTester(),
								  SOGPrimeTester(),SafePrimeTester()]
	
	public var completetesters : [NumTester] = []
	private init() {
		for t in Tester.testers {
			self.completetesters.append(t)
			if t.invers() != nil { self.completetesters.append(t.invers()!)}
			if t.subtester() != nil {
				for sub in t.subtester()! {
					self.completetesters.append(sub)
				}
			}
		}
        
        for type in MathConstantType.allValues {
            let t = SpecialConstantTester(type)
            self.completetesters.append(t)
            
            let r = RationalApproxTester(type)
            self.completetesters.append(r)
        }
	}
	
	public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		return true //!isDull(n: n)
	}
}

public class TriangleTester : NumTester {
    public func getLatex(n: BigUInt) -> String? {
        guard let r = triangleroot(n: n) else { return nil }
        let latex = String(n) + "= \\sum_{k=1}^{\(r)} k"
        return latex
    }
    
    public init() {}
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
    public func getLatex(n: BigUInt) -> String? {
        guard let r = pronicroot(n: n) else { return nil }
        let latex = String(n) + "= \(r)(\(r)+1)"
        return latex
    }
    
    public init() {}
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
    func getLatex(n: BigUInt) -> String? {
        guard let r = pentagonalroot(n: n) else { return nil }
        let latex = String(n) + "= \\frac{3\(r)^2-\(r)}{2}"
        return latex
    }
    
        public init() {}
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

public class Pow2Tester : NumTester {
    public func getLatex(n: BigUInt) -> String? {
        if n == 1 { return "1 = 2^0"}
        if n == 2 { return "2 = 2^1"}
        var nn = n
        var pow = 1
        while nn>1 {
            if nn % 2 != 0 {
                return nil
            }
            nn = nn / 2
            pow = pow + 1
        }
            let latex = String(n) + "= 2^{\(pow)}"
        return latex
    }
    
        public init() {}
	public func property() -> String {
		return "power of two"
	}
	public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
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


public class HexagonalTester : NumTester {
    public func getLatex(n: BigUInt) -> String? {
        guard let r = hexroot(n: n) else { return nil }
        let latex = String(n) + "=" + "2\(r)^2 - \(r)"
        return latex
    }
    
        public init() {}
	public func property() -> String {
		return "hexagonal"
	}
	public func propertyString() -> String {
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
	public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		if let _ = hexroot(n: n) {
			return true
		}
		return false
	}
    
}


public class SquareTester : NumTester {
    public func getLatex(n: BigUInt) -> String? {
        let r = n.squareRoot()
        if r*r != n { return nil }
        let latex = String(n) + "=" + "\(r)^2"
        return latex
    }
    
        public init() {}
	public func property() -> String {
		return "square"
	}
	public func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool? {
		if n == 0 { return false }
		let r = n.squareRoot()
		return r*r == n
	}
}

public class CubeTester : NumTester {
    public init() {}
	public func property() -> String {
		return "cube"
	}
	public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		if n == 0 { return false }
		let r = n.iroot3()
		return r*r*r == n
	}
    public func getLatex(n: BigUInt) -> String? {
        let r = n.iroot3()
        if r*r*r != n { return nil }
        let latex = String(n) + "=" + "\(r)^3"
        return latex
    }
}


public class RamanujanNagellTester : MersenneTester {
    
	override public func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool {
		if n == 0 { return false }
		return OEIS.shared.ContainsNumber(key: self.property(), n: n)
	}
	
	override public func getLatex(n: BigUInt) -> String? {
		return nil //Solved by TriangleTester && MersenneTester
	}
	
    override public func property() -> String {
		return "Ramanujan-Nagell"
	}
}


