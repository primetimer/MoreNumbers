import XCTest
import MoreNumbers
import BigInt

class TestFibonacci: XCTestCase {
    
    func testPadovan() {
        let t = PadovanTester()
        let n = BigUInt(114)
        XCTAssert(t.isSpecial(n: 113, cancel: nil) == false)
        XCTAssert(t.isSpecial(n: n, cancel: nil) == true)
    }
}
