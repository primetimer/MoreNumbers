import Foundation
import BigInt
import PrimeFactors

public class FibonacciTester : NumTester {
    public init() {}
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
    
    func getLatex(n: BigUInt) -> String? {
        guard let special = isSpecial(n: n, cancel: nil) else { return nil }
        if !special { return nil }
        if n == 1 {
            return nil
        }
        let prev1 = prev(n: n)
        if prev1 == 0 {
            return ""
        }
        let prev2 = n - prev1
        let nth = NIndex(n:n)
        var latex = String(n) + "=" + String(prev2) + "+" + String(prev1) + " = "
        latex = latex + "f_{" + String(nth-2) + "} + f_{" + String(nth-1) + "}"
        return latex
    }
}

public class LucasTester : NumTester {
        public init() {}
    public func property() -> String {
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
    
    func getLatex(n: BigUInt) -> String? {
        guard let special = isSpecial(n: n, cancel: nil) else { return nil }
        if !special { return nil }
        if n <= 2 {    return nil }
        let (l1,l2) = prev(n: n)
        let nth = LucasTester.NIndex(n: n)
        var latex = String(n) + "=" + String(l1) + "+" + String(l2)
        latex = latex + " = L_{" + String(nth-3) + "} + L_{" + String(nth-2) + "}"
        return latex
    }
}

public class PadovanTester : NumTester {
        public init() {}
    public func property() -> String {
        return "Padovan"
    }
    
    public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
        if n == 0 { return false }
        if n <= 4 { return true }
        var (l1,l2,l3,l4) = (BigUInt(2),BigUInt(2),BigUInt(3),BigUInt(4))
        
        while n>l4 {
            l4 = l1 + l2
            l1 = l2
            l2 = l3
            l3 = l4
        }
        if n == l4 {
            return true
        }
        return false
    }
    
    static public func NIndex(n: BigUInt) -> Int {
        switch n {
        case 0:
            return 0
        case 1:
            return 3
        case 2:
            return 5
        case 3:
            return 6
        default:
            break
        }
        
        var index = 7
        var (l1,l2,l3,l4) = (BigUInt(2),BigUInt(2),BigUInt(3),BigUInt(4))
        
        while n>=l4 {
            l4 = l1 + l2
            l1 = l2
            l2 = l3
            l3 = l4
            
            if n == l4 { return index }
            index = index + 1
        }
        return index
    }
    
    static public func Nth(n : Int) -> BigUInt {
        switch n {
        case 0:
            return 0
        case 1,2,3:
            return 1
        default:
            var (l1,l2,l3,l4) = (BigUInt(1),BigUInt(1),BigUInt(1),BigUInt(2))
            for _ in 3..<n {
                l4 = l1 + l2
                l1 = l2
                l2 = l3
                l3 = l4
            }
            return l4
        }
    }
    
    public func getLatex(n: BigUInt) -> String? {
        guard let special = isSpecial(n: n,cancel : nil) else { return nil }
        if !special { return nil }
        
        var latex = "P_{n} = P_{n-2} + P_{n-3}, P_{0} = P_{1} = P_{2} = 1 \\\\"
        let index = PadovanTester.NIndex(n: n)
        let pn2 = PadovanTester.Nth(n: index-2)
        let pn3 = PadovanTester.Nth(n: index-3)
        //latex = "P_{\(index)} = P_{\(index-2)} + P_{\(index-3)}, P_{0} = P_{1} = P_{2} = 1"
        latex = latex + String(n) + " = P_{\(index)} = " + String(pn2) + "+" + String(pn3)
        latex = latex + "\\\\ P_{n} = \\lfloor \\frac{p^{n-1}}{s} \\rceil, p^3-p = 1, s^3-2s^2+23s=23,"
        latex = latex + "\\\\ p \\approx 1.32471... \\text{ (plastic constant) }"
        return latex
    }
    
}



