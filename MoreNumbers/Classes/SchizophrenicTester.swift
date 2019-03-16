

import Foundation
import BigInt
import PrimeFactors

extension StringProtocol where Index == String.Index {
    func index(of string: Self, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    func endIndex(of string: Self, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    func indexes(of string: Self, options: String.CompareOptions = []) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while start < endIndex,
            let range = self[start..<endIndex].range(of: string, options: options) {
                result.append(range.lowerBound)
                start = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    func ranges(of string: Self, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while start < endIndex,
            let range = self[start..<endIndex].range(of: string, options: options) {
                result.append(range)
                start = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}

public class SchizophrenicTester : NumTester {
    
    static public var fn : [BigUInt] = [BigUInt(0)]
    static private let maxn = 51
    public init() {
        if SchizophrenicTester.fn.count == 1 {
            for n in 1...SchizophrenicTester.maxn {
                let fval = BigUInt(10) * SchizophrenicTester.fn[n-1] + BigUInt(n)
                SchizophrenicTester.fn.append(fval)
                //print(n,":",String(fval))
            }
        }
    }
    
    public func GetIndex(n: BigUInt) -> Int? {
        for i in 0..<SchizophrenicTester.fn.count {
            if i % 2 == 0 { continue }
            if n == SchizophrenicTester.fn[i] {
                return i
            }
            if SchizophrenicTester.fn[i] > n {
                return nil
            }
        }
        return nil
    }
    public func isSpecial(n: BigUInt, cancel: CalcCancelProt?) -> Bool? {
        if GetIndex(n: n) == nil {
            return false
        }
        return true
    }
    
    public func property() -> String {
        return "schizophrenic"
    }
    
    public func getSchizoString(idx: Int, precision : Int = 100 ) -> (ipart: String, fpart: String)? {
         let fn = SchizophrenicTester.fn[idx]
        
        let p10 : BigUInt = {
            var ans = BigUInt(1)
            for _ in 1...precision {
                ans = ans * BigUInt(10)
            }
            return ans
        }()
        
        let r = fn.squareRoot()
        let fnp = fn * p10*p10
       // let fnr = fn - r*r
        let rp = fnp.squareRoot()
        let dif = rp - p10*r
        let frac = String(dif)
        
        return (String(r),frac)
    }
    
    #if false
    private func Splitter(number: String) -> [String] {
        var f = Array(number)
        var result : [String] = []
        var temp = String(f[0])
        for i in 1..<f.count {
            if f[i-1] == f[i] {
                temp = temp + String(f[i])
            } else {
                result.append(temp)
                temp = String(f[i])
            }
        }
        return result
    }
    #endif
    #if true
    private func Splitter(number: String) -> [String] {
        var f = Array(number)
        var result : [String] = []
        var n = 0
        while true {
            var temp = ""
            for _ in 0..<20 {
                if n >= f.count { break }
                temp = temp + String(f[n])
                n = n + 1
            }
            result.append(temp)
            if n >= f.count {break}
        }
        return result
    }
    #endif
    
    public func getLatex(n: BigUInt) -> String? {
        guard let idx = GetIndex(n: n) else { return nil }
        guard let (ipart,fpart) = getSchizoString(idx: idx) else { return nil }
        let fval = SchizophrenicTester.fn[idx]
        var latex = "\\sqrt{ \(String(fval)) } = \\\\ \(ipart) ."
        //latex = latex + "+ 0."
        let splitter = Splitter(number: fpart)
        for s in splitter {
            
            if s.count > 1 { latex = latex + "\\\\" }
            latex = latex + s
        }
        latex = latex + "..."
        return latex
    }
    
//    public func getLatex(n: BigUInt) -> String? {
//        guard let idx = GetIndex(n: n) else { return nil }
//        guard let (ipart,fpart) = getSchizoString(idx: idx) else { return nil }
//        let fval = SchizophrenicTester.fn[idx]
//        var latex = "\\sqrt{ \(String(fval)) } = \(ipart) + \\\\"
//        latex = latex + "+ 0. \(fpart) ..."
//        return latex
//    }
}


