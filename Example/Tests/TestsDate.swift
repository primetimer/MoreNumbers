import XCTest
import MoreNumbers
import BigInt

class TestDate: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    private func TestNr(t: NumTester, nr: Int) {
        let special = t.isSpecial(n: BigUInt(nr), cancel: nil) ?? false
        if special {
            print("\(nr): \(t.property())")
        }
    }
    
 
    func testDateLoop() {
        for m in 1...12 {
            let days : Int = {
                switch m {
                case 1,3,5,7,8,10,12:
                    return 31
                case 2:
                    return 29
                default:
                    return 30
                }
            }()
            
            for d in 1...days {
                let nr = m*100+d
                 for t in Tester.shared.completetesters {
                    TestNr(t: t, nr: nr)
                }
            }
        }
    }
}
