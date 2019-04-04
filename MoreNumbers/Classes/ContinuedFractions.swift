import Foundation
import BigInt

extension String {
    /**
     Truncates the string to the specified length number of characters and appends an optional trailing string if longer.
     
     - Parameter length: A `String`.
     - Parameter trailing: A `String` that will be appended after the truncation.
     
     - Returns: A `String` object.
     */
    public func truncate(length: Int, trailing: String = "0") -> String {
        if self.count > length {
            return String(self.prefix(length)) + trailing
        } else {
            return self
        }
    }
}

extension MathConstantType {
    
    public func OEISDigitsSeries() -> String {
        switch self {
        case .pi:
            return "A000796"
        case .e:
            return "A001113"
        case .gamma:
            return "A001620"
        case .bruns:
            return "A065421"
        case .carefree:
            return "A065464"
        case .chaitin:
            return "A100264"
        case .champernowne:
            return "A033307"
        case .conwaylambda:
            return "A014715"
        case .copelanderdos:
            return "A033308"
        case .crt2:
            return "A002580"
        case .feigenbaumalpha:
            return "A006891"
        case .feigenbaumdelta:
            return "A006890"
        case .gauss:
            return "A062539" //Acgtung ist G*pi
        case .gelfond:
            return "A039661"
        case .khinchin:
            return "A087491"
        case .ln2:
            return "A002162"
        case .mill:
            return "A051021"
            
            
            
        case .root2:
            return "A002193"
        case .pisquare:
            return "A002388"
        case .phi:
            return "A001622"
        case .zeta3:
            return "A002117"
        case .silver:
            return "A014176"
        case .plastic:
            return "A060006"
        case .ramanujan:
            return "A064533"
        case .viswanath:
            return "A078416"

        }
        
    }
    public func OEISRational() -> (n: String,d: String,cf: String)? {
        switch self {
        case .pi:
            return ("A046947","A002486","A001203")
        case .e:
            return ("A007676","A007677","A003417")
        case .gamma:
            return ("A046114","A064115","A002852")
        case .bruns:
            return ("A065421","A065421N","A065421D")    //Bruns decimal not Continued Fractions"
        case .pisquare:
            return nil //return ("A096456","A096463")
        case .root2:
            return ("A001333","A000129","A040000")
        case .silver:
            return ("A001333","A000129","A040000")
        case .ln2:
            return ("A016730","A079942","A079943")
        case .phi:
            return ("A000012","A000045+1","A000045+2")
        case .crt2:
            return ("A002945","A002945N","A002945D")
        case .zeta3:
            return ("A013631","A084223","A084224")
        case .conwaylambda:
            return ("A014967","A014967N","A014967D")
        case .mill:
            return nil
            //        case .graham:
        //            return nil
        case .khinchin:
            return ("A127005","A127006","A002211")
        case .plastic:
            return ("A072117","A072117N","A072117D")
        case .gauss:
            return ("A053002","A053002N","A053002D")
        case .chaitin:
            return nil
        case .copelanderdos:
            return ("A072754","A072755","A030168")
        case .champernowne:
            return ("A058069","A058068","A030167")
            
        case .ramanujan:
            return ("A064533N","A064533D","A064533")
        case .feigenbaumdelta:
            return ("A159766N","A159766D","A159766")
        case .feigenbaumalpha:
            return ("A159767N","A159767D","A159767")
        case .gelfond:
            return ("A058287N","A058287D","A058287")
        case .viswanath:
            return ("A115064N","A115064D","A115064")
        case .carefree:
            return nil
            
        }
    }
 
}


public class ContinuedFractions {
    private let uptodefault = 100
    
    public static let shared = ContinuedFractions()
    private init() {
        //CreateOEIS()
    }
    
//    func getSeries(value : BigFloat, upto : Int = 0) -> [BigUInt] {
//        let count = upto == 0 ? uptodefault : upto
//        var a: [BigUInt] = []
//        var (a0,x) = (BigInt(0),value)
//        for _ in 0...count {
//            (a0,x) = x.SplitIntFract()
//
//            a.append(BigUInt(a0))
//            if x == BigFloat(0) {
//                return a
//            }
//            x = BigFloat(1) / x
//        }
//        return a
//    }
    
    public func RationalSequence(seq: [BigInt], count : Int = 0) -> [(n: BigInt,d: BigInt)] {
        var ans : [(n: BigInt,d: BigInt)] = []
        let c = count == 0 ? seq.count : min(count,seq.count)
        var (h1,k1) = (BigInt(1), BigInt(0))
        var (h0,k0) = (BigInt(0), BigInt(1))
        
        for i in 0..<c {
            let a = BigInt(seq[i])
            let (h,k) = (a*h1+h0,a*k1+k0)
            (h0,k0) = (h1,k1)
            (h1,k1) = (h,k)
            
            ans.append((h1,k1))
        }
        return ans
    }
    
    public func ValueRational(seq: [BigUInt], count : Int = 0) -> (numerator: BigUInt,denominator: BigUInt){    //0 is use all terms
        let c = count == 0 ? seq.count : min(count,seq.count)
        var (h1,k1) = (BigUInt(1), BigUInt(0))
        var (h0,k0) = (BigUInt(0), BigUInt(1))
        
        for i in 0..<c {
            let a = BigUInt(seq[i])
            let (h,k) = (a*h1+h0,a*k1+k0)
            (h0,k0) = (h1,k1)
            (h1,k1) = (h,k)
        }
        return (h1,k1)
    }
    
    public func ValueRationalDigits(numerator : BigInt,denominator : BigInt, precision : Int = 10) -> String {
        var numerator = numerator
        if numerator == 0 { return "0" }
        var exponent = 0
        while numerator.magnitude < denominator.magnitude {
                exponent -= 1
                numerator = numerator * BigInt(10)
        }
        
        let p = BigInt(10).power(precision)
        let x = numerator * p // BigFloat(significand: BigInt(numerator), exponent: 0)
        let y = denominator // BigFloat(significand: BigInt(denominator), exponent : 0)
        let xy = x / y
        var digits = String(xy) 
        
        while exponent < 0 {
            digits = "0" + digits
            exponent += 1
        }
        if digits.count == 0 { return "" }
        
        var ans = String(digits.first!)
        digits.removeFirst()
        ans = ans + "." + digits
        return ans
    }
}


