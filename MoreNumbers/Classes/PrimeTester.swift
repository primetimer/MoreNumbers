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


public class TwinPrimeTester : NumTester {
	public func property() -> String {
		return "twin prime"
	}
    public func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool? {
		if !PrimeCache.shared.IsPrime(p: n) { return false }
		if !PrimeCache.shared.IsPrime(p: n+2) { return false }
		return true
	}
	
    func getLatex(n: BigUInt) -> String? {
        let special = isSpecial(n: n,cancel : TimeOut()) ?? false
        
        if !special { return nil }
        let nstr = String(n)
        var latex = ""
        if PrimeCache.shared.IsPrime(p: BigUInt(n+2)) {
            latex = nstr + PrimeTester.subset(type:2)
        }
        return latex
    }
	
	public func issubTester() -> Bool {
		return true
	}
}

public class CousinPrimeTester : NumTester {
	public func property() -> String {
		return "cousin prime"
	}
		
	public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		if !PrimeCache.shared.IsPrime(p: n) { return false }
		if !PrimeCache.shared.IsPrime(p: n+4) { return false }
		return true
	}
	
    public func getLatex(n: BigUInt) -> String? {
        guard let special = isSpecial(n: n, cancel: TimeOut()) else { return nil }

        if !special { return nil }
        let nstr = String(n)
        var latex = ""
        if PrimeCache.shared.IsPrime(p: BigUInt(n+4)) {
            latex = nstr + PrimeTester.subset(type:4)
        }
        return latex
    }
	public func issubTester() -> Bool { return true }
}

public class SexyPrimeTester : NumTester {
	public func property() -> String {
		return "sexy prime"
	}
	public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		if !PrimeCache.shared.IsPrime(p: n) { return false }
		if !PrimeCache.shared.IsPrime(p: n+6) { return false }
		return true
	}
    func getLatex(n: BigUInt) -> String? {
        guard let special = isSpecial(n: n,cancel : nil) else { return nil }
        if !special { return nil }

        let nstr = String(n)
        var latex = ""
        if PrimeCache.shared.IsPrime(p: BigUInt(n+6)) {
            latex = nstr + PrimeTester.subset(type:6)
        }
        return latex
    }
    public func issubTester() -> Bool { return true }
}
public class SOGPrimeTester : NumTester {
	public func property() -> String {
		return "Sophie Germain prime"
	}
	public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		if !PrimeCache.shared.IsPrime(p: n) { return false }
		if !PrimeCache.shared.IsPrime(p: 2*n+1) { return false }
		return true
	}
    func getLatex(n: BigUInt) -> String? {
        guard let special = isSpecial(n: n,cancel : TimeOut()) else { return nil }
        if !special { return nil }
        let latex = "2\\cdot{" + String(n) + " + 1 \\in \\mathbb{N}"
        return latex
    }
	public func issubTester() -> Bool { return true }
}

public class SafePrimeTester : NumTester {
    public func property() -> String {
		return "safe prime"
	}
    public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		if !PrimeCache.shared.IsPrime(p: n)  { return false }
		if !PrimeCache.shared.IsPrime(p: (n-1)/2) { return false }
		return true
	}
    func getLatex(n: BigUInt) -> String? {
        
        guard let special = isSpecial(n: n, cancel: TimeOut()) else { return nil }
        if !special { return nil }
        let latex = "\\frac{" + String(n) + "- 1}{2} \\in \\mathbb{N}"
        return latex
    }
	public func issubTester() -> Bool { return true }
}

public class ProbablePrimeTester : NumTester {
	
    public func getLatex(n: BigUInt) -> String? {
        if n <= 2 { return nil }
        let latex = "2^{" + String(n-1) + "} \\equiv_{" + String(n) + "} 1 "
        return latex
    }
	
	var base = BigUInt(2)
	public func property() -> String {
		return "Probable Prime"
	}
	public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		if n <= 2 { return false }
		let test = base.power(n-1, modulus: n)
		if 	test == 1 {
			return true
		}
		return false
	}
	public func issubTester() -> Bool { return true }

}

public class CarmichaelTester : NumTester{
	public func property() -> String {
		return "Carmichael"
	}
	public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		if n <= 2 { return false }
		if n % 2 == 0 { return false }
		let dummxy = "<<<<falsch!!!?"
		//		guard let special = TestSpecialSync(n: n) else { return nil }
		//		if !special { return nil }
		
		
		let factors = FactorsWithPot(n: n, cancel: cancel)
		if cancel?.IsCancelled() ?? false { return nil }
		for f in factors.factors {
			if f.e > 1 { return false }
			if f.f % BigUInt(2) == 0 { return false }
			if (n - BigUInt(1)) % (f.f - BigUInt(1)) != 0 {
				return false
			}
		}
		if factors.unfactored>1 { return nil }
		return true
	}
	
//    func getLatex(n: BigUInt) -> String? {
//        if n <= 2 { return nil }
//        let latex = "\\forall b \\in \\mathbb{N} : b^{" + String(n-1) + "} \\equiv_{" + String(n) + "} 1 "
//        return latex
//    }
}

public class PrimeTester : NumTester {
	public func property() -> String {
		return "prime"
	}
	public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
		return PrimeCache.shared.IsPrime(p: n)
	}
	public func invers() -> NumTester? {
		return CompositeTester()
	}
	
	public func issubTester() -> Bool {
		return false
	}
    public init() {}
	
//    func LatexSet() -> LatexString? {
//        let set = "\\mathbb{P} := \\{ n > 1 \\in \\mathbb{N} : n|ab \\rightarrow n\\mid a \\lor n\\mid b\\}"
//        return set
//    }
	
    static  public func subset(type : Int) -> String {
        let difstr : String = (type > 0 ) ? "+" + String(type) : String(type)
        let latex = "\\in \\mathbb{P}_{" + String(type) + "}:= \\{ p \\in \\mathbb{P} : p" + difstr + "\\in \\mathbb{P} \\}"
        return latex
    }
	
//    private func GaussianLatex(p: BigUInt) -> String? {
//        if let (g1,g2) = GaussianInt.FactorPrime(p: p) {
//            var latex = String(p) + "="
//            let g1str = g1.asString()
//            let g2str = g2.asString()
//
//            latex = latex + "(" + g1str + ")"
//            latex = latex + "(" + g2str + ")"
//            return latex
//        }
//        return nil
//    }
//
//    private func EisensteinLatex(p: BigUInt) -> String? {
//        if let (g1,g2) = EisensteinInt.FactorPrime(p: p) {
//            var latex = String(p) + "="
//            let g1str = g1.asString()
//            let g2str = g2.asString()
//
//            latex = latex + "(" + g1str + ")"
//            latex = latex + "(" + g2str + ")"
//            return latex
//        }
//        return nil
//    }
//
//
//    func getLatex(n: BigUInt) -> String? {
//        var set = LatexSet() ?? ""
//        let nstr = String(n)
//
//        guard let special = isSpecial(n: n, cancel: nil) else { return set }
//        if special {
//            set = nstr + "\\in" + set
//        } else {
//            set = nstr + "\\notin" + set
//        }
//        var latex = set
//
//        //var latex = nstr + "\\in \\mathbb{P} := \\{ p \\in \\mathbb{N} | \\forall q : q\\mid p \\rightarrow q=1 \\lor q=p \\}"
//
//        if special {
//            if let gausslatex = GaussianLatex(p: n) {
//                latex = latex + "\\\\" + gausslatex
//            }
//            if let eisensteinlatex = EisensteinLatex(p: n) {
//                latex = latex + "\\\\" + eisensteinlatex
//                latex = latex + "," + EisensteinInt.omegaDefinition
//            }
//        }
//        return latex
//    }
	
	private var subtesters : [NumTester] = []
	public func subtester() -> [NumTester]? {
		//avoid recursion
		if self.property() != PrimeTester().property() {
			return nil
		}
		if !subtesters.isEmpty { return subtesters }
		subtesters.append(TwinPrimeTester())
		subtesters.append(CousinPrimeTester())
		subtesters.append(SexyPrimeTester())
		return subtesters
	}
}
