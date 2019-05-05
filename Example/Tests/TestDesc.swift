import XCTest
import MoreNumbers
import BigInt

class TestDesc: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testComposite() {
        let t = CompositeTester()
        for n in 0...100 {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
                let desc = t.Desc(n: BigUInt(n))
                print(desc)
            }
            
        }
    }
    
    func testDesc() {
//        XCTAssert(false)
        for t in Tester.shared.completetesters {
            for n in 0...100 {
                if t is CompositeTester {
                    print("CompositeTester")
                }
                let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
                if special {
                    let desc = t.Desc(n: BigUInt(n))
                    print(desc)
                }
                
            }
        }
    }
    
}
