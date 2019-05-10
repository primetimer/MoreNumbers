import XCTest
import MoreNumbers
import BigInt

class TestEisenstein: XCTestCase {
    
    
    func testHurwitz() {
        for n in 1...100 {
//            print("Factorize : \(n)")
            guard let harr = HurwitzInt.FactorHurwitz(n: BigUInt(n)) else {
                XCTAssert(false)
                break
            }
            var prod = HurwitzInt(1)
            for h in harr {
                for k in 0..<h.pow {
                    prod = prod * h.0
                }
//                print(h,prod)
            }
            XCTAssert(prod.a[0] == BigInt(n))
            for i in 1 ... 3 { XCTAssert(prod.a[i] == 0) }
        }
    }
    
    
    func testEisensteinPrime() {
        
        let natural = [2, 5, 11, 17, 23, 29, 41, 47, 53, 59, 71, 83, 89, 101]
        for n in 2...101 {
            
            let p = BigUInt(n)
            if p.isPrime() {
                if let (a,b) = EisensteinInt.FactorPrime(p: p) {
                    if natural.contains(n) {
                        XCTAssert(b == nil)
                    }
                    if b != nil {
                        let prod = a*b!
                        print(n,a,b!,prod)
                        XCTAssert(prod.a == n)
                        XCTAssert(prod.w == 0)
                    }
                }
            }
        }
        
//        let t = PrimeTester()
//        let f = EisensteinInt.FactorEisenstein(n: 106)
//        print(f)
//        let latex = t.getLatex(n: 106)
//        print(latex)
        
        
    }
    
    func testEisensteinFactor() {
        
        for n in 2...101 {
            let p = BigUInt(n)
            guard let factors = EisensteinInt.FactorEisenstein(n: p, cancel: nil) else {
                XCTAssert(false)
                return
            }
            
            var prod = EisensteinInt(1)
            
            for f in factors {
                for e in 1...f.pow {
                    prod = prod * f.h
                }

            }
            XCTAssert(prod.a == p)
        }
    }
    
}
