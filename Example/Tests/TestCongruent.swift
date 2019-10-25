import XCTest
import MoreNumbers
import BigInt

class TestCongruent: XCTestCase {
    
    
    func testSeq() {
        
        let t = CongruentTester()
        
        let seq = [5, 6, 7, 13, 14, 15, 20, 21, 22, 23, 24, 28, 29, 30, 31, 34, 37, 38, 39, 41, 45, 46, 47, 52, 53, 54, 55, 56, 60, 61, 62, 63, 65, 69, 70, 71, 77, 78, 79, 80, 84, 85, 86, 87, 88, 92, 93, 94, 95, 96, 101, 102, 103, 109, 110, 111, 112, 116, 117, 118, 119, 120, 124, 125, 126]
        
        for n in 0...126 {
            let p = BigUInt(n)
            let special = t.isSpecial(n: p, cancel: nil) ?? false
            
            if special {
                print(n)
                XCTAssert(seq.contains(n))
            } else {
                print("Missing:",n)
                XCTAssert(!seq.contains(n))
            }
        }
    }
    
    func testTriangle() {
        
        let c = CongruentTester()

        
        for n in 1...400 {
            
            let iscongruent = c.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            
            if let r = c.triangle(n: BigUInt(n), cancel: nil) {
                let area2 = (r.a.0*r.b.0)
                let test = BigUInt(n) * r.a.1 * r.b.1*2
                //print (r)
                print(n,":",area2,"  ", test)
                if area2 != test {
                    print("Fehler")
                }
                XCTAssert(area2 == test)
                XCTAssert(iscongruent)
            } else {
                if (iscongruent) {
                    print("No solution",n)
                }
                XCTAssert(!iscongruent)
            }
            
        }
        
    }
}
