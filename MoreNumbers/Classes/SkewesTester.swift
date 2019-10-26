//
//  ExtraTester
//  Numbers
//
//  Created by Stephan Jancar on 11.12.17.
//  Copyright © 2017 Stephan Jancar. All rights reserved.
//

import Foundation
import BigInt
import PrimeFactors

public class SkewesTester : NumTester {
    
    let s = "1.397162"
    let seq = ["139","1397","13971","139716","1397162"]
    let pow = "316"
    
    public func isSpecial(n: BigUInt, cancel: CalcCancelProt?) -> Bool? {
        let nstr = String(n)
        if seq.contains(nstr) {
            return true
        }
        return false
    }
    
    public func property() -> String {
        return "skewes"
    }
    
    public func getLatex(n: BigUInt) -> String? {
        let latexskewes = //"Sk_{1} = e^{e^{e^{79}}} \\approx 10^{10^{10^{34}}} \\\\" +
            //"Sk_{2} = 10^{10^{10^{963}}} \\\\" +
        "\\exists n <= Sk_{1} : \\pi(n) - Li(n) \\leq 0  \\\\" +
            //"\\exists n <= Sk_{2} : \\pi(n) - Li(n) <= 0 \\text{(without RH)} \\\\" +
      
        "Sk_{1} \\leq e^{e^{e^{79}}} \\approx 10^{10^{10^{34}}} \\text{(Skewes,1933)}\\\\" +
        "Sk_{1} \\leq \(s) \\cdot 10^{\(pow)} \\text{(under RH) (Demichel, 2005)}  \\\\" +
        "Li(x) := \\int_{2}^{x} \\frac{dt}{ln(t)} \\\\" +
        "\\pi(n) = |\\{x \\leq n : x \\in \\mathbb{P} \\}|"
        return latexskewes

    }
    public init() {}
    
}
public class GrahamNumberTester : NumTester, TestDescriber {
    
    public init() {}
    
   static let graham = "2425950695064738395657479136519351798334535362521430035401260267716226721604198106522631693551887803881448314065252616878509555264605107117200099709291249544378887496062882911725063001303622934916080254594614945788714278323508292421020918258967535604308699380168924988926809951016905591995119502788717830837018340236474548882222161573228010132974509273445945043433009010969280253527518332898844615089404248265018193851562535796399618993967905496638003222348723967018485186439059104575627262464195387"

	public func isSpecial(n: BigUInt, cancel : CalcCancelProt?) -> Bool? {
        if GrahamNumberTester.graham.hasSuffix(String(n)) {
            return true
        }
        return false
	}
	
	public func getLatex(n: BigUInt) -> String? {
//        if n == 79 || n == 10101034 || n == 101010963 {
//            let latexskewes = "Sk_{1} = e^{e^{e^{79}}} \\approx 10^{10^{10^{34}}} \\\\" +
//            "Sk_{2} = 10^{10^{10^{963}}} \\\\" +
//            "\\exists n <= Sk_{1} : \\pi(n) - Li(n) <= 0 \\text{(under RH)} \\\\" +
//            "\\exists n <= Sk_{2} : \\pi(n) - Li(n) <= 0 \\text{(without RH)} \\\\" +
//            "Li(x) := \\int_{2}^{x} \\frac{dt}{ln(t)} \\\\" +
//            "\\pi(n) = |\\{x \\leq n : x \\in \\mathbb{P}|"
//            return latexskewes
//        }
//        if n == 10100 || n == 1010100 {
//            let latexgoogol = "googol = 10^{100}  \\\\"
//            let latexggogolplex = "googolplex = 10^{10^{100}}  \\\\"
//            let latexggogolplexian = "googolplexian = 10^{10^{10^{100}}}  \\\\"
//
//            return latexgoogol + latexggogolplex + latexggogolplexian
//        }
        
        if GrahamNumberTester.graham.hasSuffix(String(n)) {
            let glatex = "G = g_{64}, \\text{Graham's number} \\\\ g_{1} = 3 \\uparrow \\uparrow \\uparrow \\uparrow 3,  \\\\"
            let glatex2 = "g_{n} = 3 \\uparrow^{g_{n-1}} 3 \\\\"
            let glatex3 = "a \\uparrow^{n} b := \\begin{cases}" +
                "a^{b} & n = 1 \\\\" +
            "1 & b = 0 \\\\" +
                "a \\uparrow^{n} b := a \\uparrow^{n-1} (a \\uparrow ^{n} (b-1)) & \\text{otherwise} \\\\" +
            "\\end{cases} \\\\"
            
            let glatexval = "G = ..." + String(n)
            
            return glatex + glatex2 + glatex3 + glatexval
        }
       
        return ""
	}
    
    public func Desc(n: BigUInt) -> String {
        guard let root = RootIndex(n: n) else { return "" }
        let desc = String(n) + " are the last \(root+1) digits of Grahams number"
        return desc
    }
	
	public func property() -> String {
		return "Graham Number"
	}
//    public func subtester() -> [NumTester]? {
//        return [ZeroTester(),OneTester()]
//    }
	public func issubTester() -> Bool {
		return false
	}
	
}

