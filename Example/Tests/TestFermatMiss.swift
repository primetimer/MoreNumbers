import XCTest
import MoreNumbers
import BigInt

class TestFermatMiss: XCTestCase {
    
    
    func testMiss() {
        
        let t = FermatNearMissTester()
        for n in 12...1000 {
            
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if let (a,b) = t.Miss(n: BigUInt(n)) {
                print("a: \(n) -> \(Int(a)), b: \(Int(b))")
                let n3 = BigUInt(n).power(3)
                XCTAssert(a*a*a+b*b*b == n3+1)
            } else
            {
                XCTAssert(!special)
            }
        }
    }
}

