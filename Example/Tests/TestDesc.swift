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
                let desc = TesterDescriber.Desc(n: BigUInt(n),tester : t)
                
                print(desc)
            }
            
        }
    }
    
    func testDesc() {
//        XCTAssert(false)
        for t in Tester.shared.completetesters {
            
            if t is CompositeTester {
                print("CompositeTester")
            }
            if t is RationalApproxTester {
                print("Rational Constant Tester")
            } else {
                if t is MathConstantTester {
                    print("Math Constant Tester \(t.property())")
                }
            }
            
            var first = true
            
            for n in 0...314 {
                let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
                if special {
                    let desc = TesterDescriber.Desc(n: BigUInt(n),tester: t)
                    if desc.isEmpty {
                        print("Error Describer \(t.property())")
                    }
                    XCTAssert(desc != "")
                    
                    if first {
                        print("\(n) \(t.property()) : \(desc)")
                        first = false
                        let again = TesterDescriber.Desc(n: BigUInt(n),tester: t)
                    }
                    
                }
                
            }
        }
    }
    
}
