import XCTest
import MoreNumbers
import BigInt

class TestGauss: XCTestCase {
    
    
    func testGaussPrime() {
        
//        let natural = [2, 5, 11, 17, 23, 29, 41, 47, 53, 59, 71, 83, 89, 101]
        let decompose = [2,5, 13, 17, 29, 37, 41, 53, 61, 73, 89, 97, 101, 109, 113, 137]
        for n in 2...101 {
            let p = BigUInt(n)
            if p.isPrime() {
                if let (a,b) = GaussianInt.FactorPrime(p: p) {
                    if !decompose.contains(n) {
                        XCTAssert(b == nil)
                    }
                    if b != nil {
                        let prod = a*b!
                        print(n,a,b,prod)
                        XCTAssert(prod.a == n)
                        XCTAssert(prod.i == 0)
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
                for _ in 1...f.pow {
                    prod = prod * f.h
                }

            }
            XCTAssert(prod.a == p)
        }
    }
    
}
