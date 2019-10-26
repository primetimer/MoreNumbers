import XCTest
import MoreNumbers
import BigInt

class TestsAmicable: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_220() {
        let t = AmicableTester()
        let n = BigUInt(220)
        let special = t.isSpecial(n: n, cancel: nil)
        let latex = t.getLatex(n: n)
        print(latex!)
        XCTAssert(special == true)
    }
    
    func testSocial6() {
         let t = SocialTester()
         let n = BigUInt(6)
         let special = t.isSpecial(n: n, cancel: nil)
         XCTAssert(special == false)
     }
    func testSocial220() {
        let t = SocialTester()
         let n = BigUInt(220)
         let special = t.isSpecial(n: n, cancel: nil)
         XCTAssert(special == false)

    }
    func testSocial() {
        let t = SocialTester()
        let n = BigUInt(1264460)
        let special = t.isSpecial(n: n, cancel: nil)
        let latex = t.getLatex(n: n)
        print(latex!)
        XCTAssert(special == true)

    }
    
    func testSocialBig() {
        let t = SocialTester()
        let n = BigUInt(1799281330)
        let special = t.isSpecial(n: n, cancel: nil)
        let latex = t.getLatex(n: n)
        print(latex!)
        XCTAssert(special == true)
    }
}
