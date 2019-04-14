import Foundation
import BigInt

public enum padicErrors : Error {
    /// Input cannot be converted
    case invalidString
}

extension UInt {
    func pow_p(_ base : UInt) -> BigUInt {
        var result = BigUInt(1)
        if self == 0 { return result }
        for _ in 1...self {
            result = result * BigUInt(base)
        }
        return result
    }
}

public struct padic : CustomStringConvertible , Equatable {
    public var description: String {
        return String(self)
        //        let pow = self.order.pow_p(self.base)
        //        let ipart = value / pow
        //        let fpart = value % pow
        //        var ans = String(ipart,radix: self.base)
        //        if fpart > 0 {
        //            ans = ans + "." + String(fpart,radix: self.base)
        //        }
        //        return ans
        
    }
    
    private static var internaldigits = 80
    private static var precdigits = 56
    
    public var maxinternal : BigUInt {
        let t = BigUInt(base)
        let result = t.power(padic.internaldigits)
        return result
        
    }
    public var maxprec : BigUInt {
        let t = BigUInt(base)
        let result = t.power(padic.precdigits)
        return result
    }
    
    
    public var minusone : BigUInt {
        let t = maxinternal - BigUInt(1)
        return t
    }
    
    public private(set) var value : BigUInt!
    public private(set) var base : UInt = 10
    public private(set) var order : UInt!
    
    private var pfactors : [BigUInt] = []
    
    mutating func InitPfactors() {
        
        let psmall : [UInt] = [2,3,5,7,11,13,17,19,23,29,31,37,41]
        if BigUInt(base).isPrime() {
            pfactors = [BigUInt(base)]
            return
        }
        var b = base
        for p in psmall {
            if b % p == 0 {
                pfactors.append(BigUInt(p))
                b = b / p
            }
        }
    }
    // MARK: Instance Properties
    
    public init() {
        value = 0
        base = 10
        order = 0
        InitPfactors()
    }
    
    public init(_ source: padic) {
        self.value = source.value
        self.base = source.base
        self.order = source.order
        InitPfactors()
    }
    
    public init(_ source : Int, base : UInt = 10) {
        self.base = base
        self.order = 0
        self.value = BigUInt(source.magnitude)
        InitPfactors()
        if source < 0 {
            self.chs()
        }
    }
    
    /// Initialize a UInt128 value from a string.
    ///
    /// - parameter source: the string that will be converted into a
    ///   UInt128 value. Defaults to being analyzed as a base10 number,
    ///   but can be prefixed with `0b` for base2, `0o` for base8
    ///   or `0x` for base16.
    public init(_ source: String, base : UInt = 10 ) throws {
        guard let result = BigInt(source, radix: Int(base)) else {
            throw padicErrors.invalidString
        }
        self.value = result.magnitude
        self.base = base
        self.order = 0
        InitPfactors()
        if result < 0 {
            self.chs()
        }
    }
    
    public mutating func normalize() {
        if order == 0 { return }
        while self.order > 0 {
            if self.value % BigUInt(base) != 0 {
                return
            }
            self.order = order - 1
            self.value = self.value / BigUInt(base)
        }
    }
    
    public init(_ source: BigInt, base : UInt = 10, order : UInt = 0) {
        self.value = source.magnitude
        self.base = base
        self.order = order
        InitPfactors()
        if source < 0 {
            self.chs()
        }
        normalize()
    }
    
    public init(_ source: BigUInt, base : UInt = 10, order : UInt = 0) {
        self.value = source
        self.base = base
        self.order = order
        InitPfactors()
        normalize()
    }
}


// MARK: - Numeric Conformance
extension padic {
    
    public static func +(_ lhs: padic, _ rhs: padic) -> padic {
        precondition(lhs.base == rhs.base, "Not the same base")
        let neworder = max(lhs.order,rhs.order)
        let l = lhs.value * neworder.pow_p(lhs.base)
        let r = rhs.value * neworder.pow_p(rhs.base)
        let lr = BigInt(l + r)
        
        let result = padic(lr, base: lhs.base, order: neworder)
        return result
    }
    
    public mutating func chs() {
        self.value = maxinternal - self.value
    }
    
    public static func -(_ lhs: padic, _ rhs: padic) -> padic {
        precondition(lhs.base == rhs.base, "Not the same base")
        var t = rhs
        t.chs()
        let result = lhs + t
        return result
    }
    
    public static func *(_ lhs: padic, _ rhs: padic) -> padic {
        precondition(lhs.base == rhs.base, "Not the same base")
        let lr = (lhs.value * rhs.value) % lhs.maxinternal
        let neworder = lhs.order + rhs.order
        let result = padic(lr, base: lhs.base, order: neworder)
        return result
    }
    
    public static func /(_ lhs: padic, _ rhs: padic) -> padic {
        precondition(lhs.base == rhs.base, "Not the same base")
        let rinv = rhs.inv
        var lr = lhs * rinv
        lr.normalize()
        return lr
    }
    
    public static func == (lhs: padic, rhs: padic) -> Bool {
        var l = lhs
        var r = rhs
        l.normalize()
        r.normalize()
        if (l.value % l.maxprec == r.value % r.maxprec) && (l.order == r.order) {
            return true
        }
        return false
    }
    
    // 10 = 2
    // 1 / 10 = 1 , order = 1
    
    // n = a*b^k --> 1/n = 1/a * b^-k
    public var inv : padic {
        var ans = padic(self)
        ans.invert()
        return ans
    }
    
    mutating func invert() {
        self.normalize()
        while order > 0 {
            self.order = order - 1
            self.value = self.value * BigUInt(base)
        }
        
        var invfaktor = padic(BigUInt(1), base: self.base, order: 0)
        for p in pfactors {
            while self.value % BigUInt(p) == 0 {
                invfaktor.value = invfaktor.value * BigUInt(base) / BigUInt(p)
                invfaktor.order = invfaktor.order + 1
                self.value = self.value / BigUInt(p)
            }
        }
        
        //        while self.value % BigUInt(self.base) == 0 {
        //            self.value = self.value / BigUInt(self.base)
        //            self.order = self.order + 1
        //        }
        
        let mod = maxinternal
        if let inv = self.value.inverse(mod) {
            self.value = inv
            self = self * invfaktor
            return
        }
        assert(false)
        
    }
}

extension String {
    public init(_ v: padic, digits: UInt = 0) {
        let pow = v.order.pow_p(v.base)
        let pmax = digits >= 3 ? digits.pow_p(v.base) : v.maxprec
        
        let value = v.value % pmax
        let ipart = value / pow
        var fpart = value % pow
        
        var ans = ""
        var overflow = false
        if v.value > pmax {
            ans = "..."
            overflow = true
        }
        ans = ans + String(ipart, radix:Int(v.base))
        if fpart > 0 {
            var fstr = ""
            for _ in 1...v.order {
                fstr = String(fpart % BigUInt(v.base)) + fstr
                fpart = fpart / BigUInt(v.base)
            }
            ans = ans + "." + fstr
        }
        
       
        self.init(ans)
    }
}
