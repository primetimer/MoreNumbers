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


public class FactorialTester : NumTester {
    //A000142
    public init() {}
    let fac : [BigUInt] = [1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800, 39916800, BigUInt("479001600"), BigUInt("6227020800"), BigUInt("87178291200"), BigUInt("1307674368000"), BigUInt("20922789888000") , BigUInt("3556874280960002"), BigUInt("6402373705728000")]
    public func isSpecial(n: BigUInt, cancel: CalcCancelProt?) -> Bool? {
        if fac.contains(n) { return true }
        return false
    }
    
    public func property() -> String {
        return "factorial"
    }
    
    public func getLatex(n: BigUInt) -> String? {
        var latex = ""
        guard let special = isSpecial(n: n, cancel: TimeOut()) else { return nil }
        if !special { return nil }
        let v = "\(String(n))"
        if n == 0 { return nil }
        
        for i in 0..<fac.count {
            if fac[i] > n { break }
            latex = "\(v) = \(String(i)) ! "
            var prod1 : String {
                switch i {
                case 2:
                    return "1 \\cdot 2"
                case 3:
                    return "1 \\cdot 2 \\cdot 3"
                case 4:
                    return "1 \\cdot 2 \\cdot 3 \\cdot 4"
                case 5:
                    return "1 \\cdot 2 \\cdot 3 \\cdot 4 \\cdot 5"
                case 6:
                    return "1 \\cdot 2 \\cdot 3 \\cdot 4 \\cdot 5 \\cdot 6"
                default:
                    return ""
                }
            }
            if prod1.count > 0 { latex = latex + "=" + prod1 }
            var prod2 = ""
            prod2 = prod2 + "= \\prod_{i=1}^{\(String(i))} i "
            latex = latex + prod2
        }
        return latex
    }
}

public class FactorialPrimeTester : NumTester {
    //A088054
    public init() {}
    let fac : [BigUInt] = [1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800, 39916800, BigUInt("479001600"), BigUInt("6227020800"), BigUInt("87178291200"), BigUInt("1307674368000"), BigUInt("20922789888000") , BigUInt("3556874280960002"), BigUInt("6402373705728000")]
    let pfac : [BigUInt] = [2, 3, 5, 7, 23, 719, 5039, 39916801, 479001599, BigUInt("87178291199"), BigUInt("10888869450418352160768000001")]
    public func isSpecial(n: BigUInt, cancel: CalcCancelProt?) -> Bool? {
        if pfac.contains(n) { return true }
        return false
    }
    
    public func property() -> String {
        return "factorial prime"
    }
    
    public func getLatex(n: BigUInt) -> String? {
        var latex = ""
        guard let special = isSpecial(n: n, cancel: TimeOut()) else { return nil }
        if !special { return nil }
        let v = "\(String(n))"
        if n == 0 { return nil }
        
        for i in 0..<fac.count {
            var add = ""
            if fac[i]-1 == n { add = "+1" }
            if fac[i]+1 == n { add = "-1" }
            if fac[i] > n+2 { break }
            if add.isEmpty { continue }
            
            latex = "\(v) \(add) = \(String(i)) ! "
            var prod1 : String {
                switch i {
                case 2:
                    return "1 \\cdot 2"
                case 3:
                    return "1 \\cdot 2 \\cdot 3"
                case 4:
                    return "1 \\cdot 2 \\cdot 3 \\cdot 4"
                case 5:
                    return "1 \\cdot 2 \\cdot 3 \\cdot 4 \\cdot 5"
                case 6:
                     return "1 \\cdot 2 \\cdot 3 \\cdot 4 \\cdot 5 \\cdot 6"
                default:
                    return ""
                }
            }
            if prod1.count > 0 { latex = latex + "=" + prod1 }
            var prod2 = ""
            prod2 = prod2 + "= \\prod_{i=1}^{\(String(i))} i "
            latex = latex + prod2
        }
        return latex
    }

}
public class PrimorialTester : NumTester {
    
    public init() {}
    //A002110
        let p : [BigUInt] = [1,2,3,5,7,11,13,17,19,23,29,31,37,41,43]
     let phash : [BigUInt] = [1, 2, 6, 30, 210, 2310, 30030, 510510, 9699690, 223092870, 6469693230, 200560490130, BigUInt("7420738134810"), BigUInt("304250263527210"), BigUInt("13082761331670030")]
    public func isSpecial(n: BigUInt, cancel: CalcCancelProt?) -> Bool? {
        if phash.contains(n) { return true }
        return false
    }
    
    public func property() -> String {
        return "primorial"
    }
    
    public func getLatex(n: BigUInt) -> String? {
        var latex = ""
        let v = "\(String(n))"
        if n == 0 { return nil }
        
        for i in 0..<phash.count {
             if phash[i] > n { break }
            
            latex = "\(v) = \(String(p[i])) \\# "
            var prod1 : String {
                switch i {
                case 2:
                    return "2 \\cdot 3"
                case 3:
                    return "2 \\cdot 3 \\cdot 5"
                case 4:
                    return "2 \\cdot 3 \\cdot 5 \\cdot 7"
                case 5:
                    return "2 \\cdot 3 \\cdot 5 \\cdot 7 \\cdot 11"
                default:
                    return ""
                }
            }
            if prod1.count > 0 { latex = latex + "=" + prod1 }
            var prod2 = ""
            prod2 = prod2 + "= \\prod_{i=1}^{\\pi(\(String(p[i])))} p_{i}"
            latex = latex + prod2
        }
        return latex
    }
}

public class PrimorialPrimeTester : NumTester {
    
    public init() {}
    //A228486
    
    let p : [BigUInt] = [1,2,3,5,7,11,13,17,19,23,29,31,37,41,43]
    let phash : [BigUInt] = [1, 2, 6, 30, 210, 2310, 30030, 510510, 9699690, 223092870, 6469693230, 200560490130, BigUInt("7420738134810"), BigUInt("304250263527210"), BigUInt("13082761331670030")]

    let pn : [BigUInt] = [2, 3, 5, 7, 29, 31, 211, 2309, 2311, 30029, BigUInt("200560490131"), BigUInt("304250263527209"), BigUInt("23768741896345550770650537601358309")]
    public func isSpecial(n: BigUInt, cancel: CalcCancelProt?) -> Bool? {
        if pn.contains(n) { return true }
        return false
    }
    
    public func property() -> String {
        return "primorial prime"
    }
    
    public func getLatex(n: BigUInt) -> String? {
        var latex = ""
        let v = "\(String(n))"
        if n == 0 { return nil }
        
        for i in 0..<phash.count {
            var add = ""
            if phash[i]-1 == n { add = "+1" }
            if phash[i]+1 == n { add = "-1" }
            if phash[i] > n+2 { break }
            if add.isEmpty { continue }
            
            latex = "\(v) \(add) = \(String(p[i])) \\# "
            var prod1 : String {
                switch i {
                case 2:
                    return "2 \\cdot 3"
                case 3:
                    return "2 \\cdot 3 \\cdot 5"
                case 4:
                    return "2 \\cdot 3 \\cdot 5 \\cdot 7"
                case 5:
                    return "2 \\cdot 3 \\cdot 5 \\cdot 7 \\cdot 11"
                default:
                    return ""
                }
            }
            if prod1.count > 0 { latex = latex + "=" + prod1 }
            var prod2 = ""
            prod2 = prod2 + "= \\prod_{i=1}^{\\pi(\(String(p[i])))} p_{i}"
            latex = latex + prod2
        }
        return latex
    }
}

