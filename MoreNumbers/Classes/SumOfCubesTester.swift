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

public class TaxiCabTester : SumOfTwoCubesTester {
    
    override public func property() -> String {
        return "Taxicab"
    }
    
    override public func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool? {
        guard let iscube = CubeTester().isSpecial(n: n, cancel: cancel) else { return nil }
        if iscube { return false }
        guard let issum = SumOfTwoCubesTester().isSpecial(n: n,cancel: cancel) else { return nil }
        if !issum { return false }
        return OEIS.shared.ContainsNumber(key: self.property(), n: n)
    }
    
    override public func getLatex(n: BigUInt) -> String? {
        guard let special = isSpecial(n: n,cancel: nil) else { return nil }
        if !special { return nil }
        if let (a,b,c,d) = Express2(n: n) {
            let (stra,strb,strc,strd) = (String(a),String(b),String(c),String(d))
            let latex = String(n) + "=" + stra + "^3 + " + strb + "^3" + " = " + strc + "^3 + " + strd
            return latex
        }
        return nil
    }
    
    public func Express2(n: BigUInt) -> (BigUInt,BigUInt,BigUInt,BigUInt)? {
        var (n0,cube) = (n,BigUInt(1))
        if n > 1000000000 {
            (n0,cube) = RemoveCubes(n: n)
        }
        guard let (c,d) = super.Express(n: n0) else { return nil }
        var a = d - 1
        while a > c {
            let a3 = a * a * a
            let b3 = n0 - a3
            let r3 = b3.iroot3()
            if r3 * r3 * r3 == b3 {
                return (a:a*cube, b: r3*cube,c:c*cube,d:d*cube)
            }
            a = a - 1
        }
        return nil
    }
    
    
}

public class SumOfTwoCubesTester : NumTester {
    
    public init() {}
    public func getLatex(n: BigUInt) -> String? {
        guard let special = isSpecial(n: n,cancel: TimeOut()) else { return nil }
        if !special { return nil }
        
        if let (a,b) = Express(n: n) {
            let stra = String(a)
            let strb = String(b)
            let latex = String(n) + "=" + stra + "^3 + " + strb + "^3"
            return latex
        }
        return nil
    }
    public func property() -> String {
        return "sum of two cubes"
    }
    private let r63 = [3,4,5,6,10,11,12,13,14,15,17,18,21, 22, 23, 24, 25, 30, 31, 32, 33, 38, 39, 40,
                       41, 42, 45, 46, 48, 49, 50, 51, 52, 53, 57,
                       58, 59, 60]
    public func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool? {
        if n <= 1 { return false }
        if n == 2 { return true }
        
        do {
            let n7 = Int(n % 7)
            if n7 == 3 || n7 == 4  { return false }
        }
        do {
            let n9 = Int(n % 9)
            if n9 >= 3 && n9<=6 { return false }
        }
        do {
            let n63 = Int(n%63)
            if r63.contains(n63) { return false }
        }
        
        var (n0,_) = (n,BigUInt(1))
        if n > 1000000000 {
            (n0,_) = RemoveCubes(n: n)
        }
        
        let r3 = n0.iroot3()
        let r4 = (n0*4).iroot3()
        let divisors = FactorCache.shared.Divisors(p: n0,cancel: cancel)
        if cancel?.IsCancelled() ?? false { return nil }
        for m in divisors.sorted() {
            if m < r3 { continue }
            if m > r4 { return false }
            if m*m < n0/m { continue }
            let temp =  (m*m-n0/m) * 4
            if temp % 3 != 0 { continue }
            if m*m < temp / 3  { return false }
            let temp2 = m*m - temp / 3
            let rtemp2 = temp2.squareRoot()
            if rtemp2 * rtemp2 == temp2 {
                return true
            }
        }
        return false
    }
    
    internal func RemoveCubes(n:BigUInt) -> (n:BigUInt,cube: BigUInt) {
        if n.isPrime() {
            return (n:n,cube:1)
        }
        var cube : BigUInt = 1
        let factors = FactorsWithPot(n: n, cancel: TimeOut())
        for f in factors.factors {
            if f.e >= 3 {
                cube = cube * f.f.power(f.e - f.e % 3)
            }
        }
        return (n: n/cube, cube:cube.iroot3())
    }
    
    public func Express(n: BigUInt) -> (a: BigUInt, b:BigUInt)? {
        guard let special = isSpecial(n: n, cancel: nil) else { return nil }
        if !special { return nil }
        //let (n0,cube) = RemoveCubes(n: n)
        var (n0,cube) = (n,BigUInt(1))
        if n > 1000000000 {
            (n0,cube) = RemoveCubes(n: n)
        }
        
        var a : BigUInt = 0
        while true {
            let a3 = a * a * a
            if a3 > n0 { return nil }
            if a3 == n0 { return (a: a*cube, b: 0) }
            let b3 = n0 - a3
            let r3 = b3.iroot3()
            if r3 * r3 * r3 == b3 {
                return (a:a*cube, b: r3*cube)
            }
            a = a + 1
        }
    }
}


public class EulerCounterexampleTester : NumTester {
    
    let counterex = 144
    public init() {}
    public func isSpecial(n: BigUInt, cancel : CalcCancelProt?) -> Bool? {
        if n < BigUInt(counterex) {
            return false
        }
        if n % BigUInt(counterex) == 0 {
            return true
        }
        return false
    }
    public func property() -> String  {
        return "Sum of 4 fifth power"
    } //Name of tested property
    public func invers() -> NumTester? {
        return nil
    }
    public func subtester() -> [NumTester]? { return nil }
    public func issubTester() -> Bool { return false }
    public func getLatex(n: BigUInt) -> String? {
        let special = isSpecial(n: n, cancel: TimeOut()) ?? false
        if !special { return nil }
        
        let faktor = n / BigUInt(counterex)
        
        let a = 27 * faktor
        let b = 84  * faktor
        let c = 110 * faktor
        let d = 133 * faktor
        
        let sum = (a^5)+(b^5)+(c^5)+(d^5)
        let n5 = n^5
        
        let latex = "\(String(n))^5 = \(a)^5 + \(b)^5 +\(c)^5 +\(d)^5 = \(sum)"
        return latex
    }
}


public class FermatNearMissTester : NumTester {
    
    let x = [9, 64, 73, 135, 334, 244, 368, 1033, 1010, 577, 3097, 3753, 1126, 4083, 5856, 3987, 1945, 11161, 13294, 3088, 10876, 16617, 4609, 27238, 5700, 27784, 11767, 26914, 38305, 6562, 49193, 27835, 35131, 7364, 65601, 50313, 9001, 11980, 39892, 20848] //A050792
    let z = [    12, 103, 150, 249, 495, 738, 1544, 1852, 1988, 2316, 4184, 5262, 5640, 8657, 9791, 9953, 11682, 14258, 21279, 21630, 31615, 36620, 36888, 38599, 38823, 40362, 41485, 47584, 57978, 59076, 63086, 73967, 79273, 83711, 83802, 86166, 90030] //A050791
    public init() {}
    public func isSpecial(n: BigUInt, cancel : CalcCancelProt?) -> Bool? {
        
        if !n.isInt64() { return nil }
        if Int(n)>z.max()! { return nil }
        
        if z.contains(Int(n)) {
            return true
        }
        return false
    }
    public func property() -> String  {
        return "Fermat near miss"
    } //Name of tested property
    public func invers() -> NumTester? {
        return nil
    }
    public func subtester() -> [NumTester]? { return nil }
    public func issubTester() -> Bool { return false }
    
    public func Miss(n: BigUInt) -> (a: BigUInt,b: BigUInt)? {
        for (j,zval) in z.enumerated() {
            if zval == Int(n) {
                let xval = BigUInt(x[j])
                let x3 = xval*xval*xval
                let n3 = n*n*n
                let y3 = n3 - x3 + 1
                let yval = y3.iroot3()
                
                return (xval,yval)
            }
        }
        return nil
    }
    
    public func getLatex(n: BigUInt) -> String? {
        let special = isSpecial(n: n, cancel: TimeOut()) ?? false
        if !special { return nil }
        
        guard let (xval,yval) = Miss(n: n) else { return nil }
//        let x3 = xval*xval*xval
//        let y3 = yval*yval*yval
        let latex = "\(String(n))^3+1 = \(String(xval))^3 + \(String(yval))^3"
        return latex
    }
}




