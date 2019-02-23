//
//  HCNTester.swift
//  Numbers
//
//  Created by Stephan Jancar on 30.12.17.
//  Copyright © 2017 Stephan Jancar. All rights reserved.
//

import Foundation
import BigInt
import PrimeFactors

extension BigInt {
    
    func NumOfDigits(base : UInt64 = 10 ) -> UInt64 {
        var test = self
        var count : UInt64 = 0
        while test != 0 {
            count = count + 1
            test = test / BigInt(base)
        }
        return count
    }
}

enum NarcisticMode {
    case narcisstic
    case narcisstic12
    case constantbase
    case munchhausen
    case factorion
}

extension BigUInt {
    func getDigits(base : Int = 10) -> [Int] {
        var stellen = self
        var ans : [Int] = []
        while stellen > 0 {
            let digit = Int(stellen % BigUInt(base))
            ans.insert(digit, at: 0)
            stellen /= BigUInt(base)
        }
        return ans
    }
}

class SDRepresentation {
    
    let faktors = ["a-a","","(a+a)/a","(a+a+a)/a","(a+a+a+a)/a","(aa-a)/(a+a)","(aa+a)/(a+a)","(aa-a-a-a-a)/a","(aa-a-a-a)/a","(aa-a-a)/a"]
    
    private func Replace(instr: String, what: String = "a" , with: String) -> String {
        let newString = instr.replacingOccurrences(of: what, with: with, options: .literal, range: nil)
        return newString
    }
    
    func Koefficients(n: BigInt) -> [Int] {
        if n == 0 { return [] }
        let digits = n.magnitude.getDigits().reversed()
        var sum = BigInt(0)
        let count = digits.count
        var f : [BigInt] = Array(repeating: BigInt(1), count: count+1)
        var p : [BigInt] = Array(repeating: BigInt(1), count: count+1)
        var koeff : [Int] = Array(repeating: 0, count: count+1)
        for i in (0..<count).reversed() {
            p[i] = p[i+1] * BigInt(10)
            f[i] = f[i+1] + p[i]
        }

        for l in 0...digits.count {
            let k = (n-sum) / f[l]
            koeff[l] = Int(k)
            sum = sum + k * f[l]
        }
        return koeff.reversed()
    }
    
    func Base111(pos : Int) -> BigInt {
        var ans = BigInt(1)
        let ten = BigInt(10)
        if pos == 0 { return ans }
        for _ in 0..<pos {
            ans = ans * ten + BigInt(1)
        }
        return ans
    }
    
    private func FaktorPresentation(x : Int, digit: Int,latexform : Bool = false) -> String {
        let faktors = ["1-1","","(1+1)/1","(1+1+1)/1","(1+1+1+1)/1","(11-1)/(1+1)","(11+1)/(1+1)","(11-1-1-1-1)/1","(11-1-1-1)/1","(11-1-1)/1","(11-1)/1"]
        let latexfaktors = ["(1-1)","","\\frac{1+1}{1}","\\frac{1+1+1}{1}","\\frac{1+1+1+1}{1}","\\frac{11-1}{1+1}","\\frac{11+1}{1+1}","\\frac{11-1-1-1-1}{1}","\\frac{11-1-1-1}{1}","\\frac{11-1-1}{1}","\\frac{11-1}{1}"]

        let f = latexform ? latexfaktors[x] : faktors[x]
        let ans = f.replacingOccurrences(of: "1", with: String(digit), options: .literal, range: nil)
        return ans
    }
    
    #if true
    func Present(n: BigInt,digit : Int, latexform : Bool = false) -> String {
        if n == 0 {
            return FaktorPresentation(x: 0, digit: digit)
        }
        let koeff = Koefficients(n: n)
        var ans = ""
        for (pos,k) in koeff.enumerated() {
            if k == 0 { continue }
            if ans.count>0 { ans = ans + "+" }
            let x111 = Base111(pos: pos) * BigInt(digit)
            let fstr = FaktorPresentation(x: k, digit: digit, latexform : latexform)
            if fstr.count > 0  {
               
                ans = ans + fstr
            }
            if (x111 > BigInt(digit)) || (fstr.count == 0) {
                let mul = latexform == false ? "*" : "\\cdot"
                if fstr.count > 0 { ans = ans + mul }
                if latexform {
                    ans = ans + "\\frac{" + String(x111) + "}{" + String(digit) + "}"
                } else {
                    ans = ans + String(x111) + "/" + String(digit)
                }
            }
        }
        return ans
    }
    func PresentLatex(n: BigInt,digit : Int) -> String {
        let ans = Present(n: n, digit: digit, latexform: true)
        return ans
        //        ans = Replace(instr: ans, with: String(digit))
        //        ans = Replace(instr: ans, what: "d", with: "frac")
        //        ans = Replace(instr: ans, what: "*", with: " \\cdot ")
        return ans
    }
    #endif
    
    #if false
    func Present(n: BigInt,digit : Int) -> String {
        if n == 0 {
            return String(digit) + "-" + String(digit)
        }
        var ans = ""
        if n == 0 { return ans }
        let digits = n.magnitude.getDigits()
        let count = digits.count
        var tempresult : BigInt = 0
        do {
            //            ans = ans + "("
            var temp = ""
            for _ in 1...count {
                temp = temp + "a"
                tempresult = tempresult * 10 + 1
            }
            temp = temp + "/a"
            #if true
            ans = ans + temp
            if faktors[digits[0]] != "" {
                ans = ans + "*" + faktors[digits[0]]
            }
            #else
            for k in 1...digits[0] {
                if k > 1 { ans += "+" }
                ans = ans + temp
            }
            #endif
            tempresult = tempresult * BigInt(digits[0])
            //            ans = ans + ")"
        }
        let dif = n - tempresult
        // print(ans,dif,tempresult)
        if dif > 0 {
            let difstr = self.Present(n: dif,digit: digit)
            ans = ans + "+" + difstr
        }
        if dif < 0 {
            let difstr = self.Present(n: -dif,digit: digit)
            ans = ans + "-(" + difstr + ")"
        }
        
        ans = Replace(instr: ans, with: String(digit))
        //        return "(5/5*(55-5-5-5-5)/5)"
        return ans
        
    }
    #endif
    #if false
    private func PresentLatexHelper(n: BigInt,digit : Int) -> String {
        if n == 0 {
            return String(digit) + "-" + String(digit)
        }
        do {
            var powtest = BigInt(digit) * BigInt(digit)
            var expoonent = 2
            while n >= powtest {
                if n > powtest * BigInt(digit) {
                    powtest = powtest * BigInt(digit)
                    expoonent = expoonent + 1
                } else {
                    let faktor = n / powtest
                    let faktorstr = PresentLatexHelper(n: faktor, digit: digit) + "\\cdot"
                    var ans = faktor > 1 ? faktorstr : ""
                    let expstr = PresentLatexHelper(n: BigInt(expoonent), digit: digit)
                    ans = ans + String(digit) + "^" + "{" + expstr + "}"
                    let dif = n - faktor * powtest
                    if dif > 0 {
                        let difstr = PresentLatexHelper(n: dif, digit: digit)
                        ans = ans + "+" + difstr
                    }
                    return ans
                }
            }
        }
        
        var ans = ""
        let digits = n.magnitude.getDigits()
        let count = digits.count
        var tempresult : BigInt = 0
        do {
            //            ans = ans + "("
            var temp = ""
            var needdot = false
            if (count > 1) || (digits[0] <= 1) {
                temp = "\\frac{"
                for _ in 1...count {
                    temp = temp + String(digit)
                    tempresult = tempresult * 10 + 1
                }
                temp = temp + "}{\(String(digit))}"
                needdot = true
            } else {
                tempresult = 1
                
            }
            ans = ans + temp
            if digits[0] > 1 {
                var lfaktor = latexfaktors[digits[0]]
                lfaktor = Replace(instr: lfaktor, with: String(digit))
                lfaktor = Replace(instr: lfaktor, what: "d", with: "frac")
                if needdot { ans = ans + "\\cdot" }
                ans = ans + lfaktor
            }
            tempresult = tempresult * BigInt(digits[0])
        }
        let dif = n - tempresult
        // print(ans,dif,tempresult)
        if dif > 0 {
            let difstr = self.PresentLatexHelper(n: dif,digit: digit)
            ans = ans + "+" + difstr
        }
        if dif < 0 {
            var difstr = self.PresentLatexHelper(n: -dif,digit: digit)
            if difstr.contains("+") || difstr.contains("-") {
               difstr = "(" + difstr + ")"
            }
            ans = ans + "-" + difstr
        }
        return ans
        
    }
    
    func PresentLatex(n: BigInt,digit : Int) -> String {
        
        var ans = PresentLatexHelper(n: n, digit: digit)
//        ans = Replace(instr: ans, with: String(digit))
//        ans = Replace(instr: ans, what: "d", with: "frac")
//        ans = Replace(instr: ans, what: "*", with: " \\cdot ")
        return ans
    }
    #endif
}


class NarcisticTester : NumTester {
    
    private func CheckDigits(n: BigInt, base : UInt64) -> [(d: Int,pow: Int)] {
        var stellen = n
        let digits = Int(n.NumOfDigits(base: base))
        var sum = BigInt(0)
        var ans : [(Int,Int)] = []
        while stellen != 0 {
            let digit = stellen % BigInt(base)
            sum = sum + digit.power(digits)
            if sum > n {
                return []
            }
            ans.insert((Int(digit),digits), at: 0)
            stellen = stellen / BigInt(base)
        }
        if sum != n { return [] }
        return ans
    }
    
    private func CheckMunchhausen(n: BigInt, base : UInt64) -> [(d: Int,pow: Int)] {
        var stellen = n
        //let digits = Int(n.NumOfDigits(base: base))
        var sum = BigInt(0)
        var ans : [(Int,Int)] = []
        while stellen != 0 {
            let digit = stellen % BigInt(base)
            sum = sum + digit.power(Int(digit))
            if sum > n {
                return []
            }
            ans.insert((Int(digit),Int(digit)), at: 0)
            stellen = stellen / BigInt(base)
        }
        if sum != n { return [] }
        return ans
    }
    
    private func CheckConstantBase(n: BigInt) -> [(d: Int,pow: Int)] {
        let base = BigInt(10)
        for m in 1...10 {
            var sum = BigInt(0)
            var ans : [(Int,Int)] = []
            var stellen = n
            while stellen != 0 {
                let digit = Int(stellen % base)
                sum = sum + BigInt(m).power(digit)
                if sum > n {
                    return []
                }
                ans.insert((Int(m),digit), at: 0)
                stellen = stellen / BigInt(base)
            }
            if sum == n {
                return ans
            }
        }
        return []
    }
    
    
    
    func isSpecial(n: BigUInt,cancel : CalcCancelProt?) -> Bool? {
        do {
            let ans = CheckDigits(n: BigInt(n), base: 10)
            if ans.count > 0 { return true }
        }
        do {
            let ans = CheckConstantBase(n: BigInt(n))
            if ans.count > 0 { return true }
        }
        do {
            let ans = CheckMunchhausen(n: BigInt(n), base: 10)
            if ans.count > 0 { return true }
        }
        return false
        
    }
    
    func getDesc(n: BigUInt) -> String? {
        let desc =  WikiLinks.shared.getLink(tester: self, n: n)
        return desc
    }
    
    private func format(n: BigUInt,base : Int = 10, param : [(d: Int,pow: Int)]) -> String {
        var latex = String(n) + "="
        for (i,d) in param.enumerated() {
            if i > 0 { latex = latex + "+" }
            latex = latex + String(d.d) + "^{" + String(d.pow) + "}"
        }
        latex = latex + "\\\\"
        
        return latex
    }
    
    func getLatex(n: BigUInt) -> String? {
        
        var latex = ""
        let p1 = CheckDigits(n: BigInt(n), base: 10)
        if p1.count > 0 {
            latex = latex + format(n: n, param: p1)
        }
        
        let p2 = CheckConstantBase(n: BigInt(n))
        if p2.count > 0  {
            latex = latex + format(n: n, param: p2)
        }
        let p3 = CheckMunchhausen(n: BigInt(n),base: 10)
        if p3.count > 0  {
            latex = latex + format(n: n, param: p3)
        }
        
        #if true //Append single digit presentation
        do {
            let singledigit = SDRepresentation()
            let format = singledigit.PresentLatex(n: BigInt(n), digit: 6)
            latex = latex + String(n) + "=" + format
        }
        #endif
        return latex
    }
    
    func property() -> String {
        return "narcissistic"
    }
}

