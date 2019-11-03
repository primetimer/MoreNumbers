//
//  Platonictester.swift
//  Numbers
//
//  Created by Stephan Jancar on 11.12.17.
//  Copyright © 2017 Stephan Jancar. All rights reserved.
//

import Foundation
import BigInt
import PrimeFactors

public class PowerTowerTester : NumTester {
	
    public init() {}
    
    func testPower(n: BigUInt) -> Int? {
        var k = 1
        while true {
            let test = BigUInt(k).power(k)
            if n == test {
                return k
            }
            if test > n {
                return nil
            }
            k = k + 1
        }
    }
    public func isSpecial(n: BigUInt,cancel: CalcCancelProt?) -> Bool? {
        guard let _ = testPower(n: n) else { return false }
        return true
    }
	
    public func getLatex(n: BigUInt) -> String? {
        guard let ptow = testPower(n: n) else { return nil }
        
        var latex = "\(String(n)) = \(ptow)^\(ptow)"
        
        if n == 256 {
            latex = latex + "=(2^2)^{(2^2)} = \\square(2)"
            latex = latex + "\\\\ \\triangle(2) = 2^2" // = M(2,1,3)"
            latex = latex + "\\\\ \\square(2) = \\triangle(\\triangle(2))"
            latex = latex + "\\\\ \\circ(2) = \\square(\\square(2)) = (((256^{256})^{256^{256}))^{256^{256}}}..."
//            latex = latex + "\\\\ \\circ(2) > 3\\cdot 10^{316}"
//            latex = latex + "\\\\ \\circ(2) = f^{(256)}(256), f(x) = x^{x}"
            latex = latex + "\\\\ \\circ(2) = M(256,256,3), with"
            latex = latex + "\\\\ M(n,1,3) = n^n,"
            latex = latex + "\\\\ M(n,1,p+1) = M(n,n,p),"
            latex = latex + "\\\\ M(n,m+1,p) = M(M(n,1,p),m,p)"
            latex = latex + "\\\\ \\circ(2) = ...93539660742656"
            latex = latex + "\\\\ moser := M(2,1,\\circ(2)) = ...1056"
            latex = latex + "\\\\ moser \\gg g_{64}"
            
        }
        return latex
    }

    public func property() -> String {
		return "power tower"
	}
	public func propertyString() -> String {
		return "power tower"
	}
}
