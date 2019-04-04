import XCTest
import MoreNumbers
import BigInt

class TestOEISConsistency: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConstructible() {
        let t = ConstructibleTester()
        for n in 0...100 {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
                print(String(n))
            }
        }
    }
    
    func testNarcissticList() {
        let t = NarcisticTester()
        for n in 0...400 {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
                print(String(n))
            }
        }
    }
    
     func testSumOfTwoSuares() {
        let t = SumOfTwoSquaresTester()
        for n in 0...400 {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
                print(String(n))
            }
        }
    }
    
    func testSumOfTwoCubes() {
        let t = SumOfTwoCubesTester()
        for n in 0...400 {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
                print(String(n))
            }
        }
    }
    
    func testSierpinksi() {
        let t = SierpinskiTester()
        for n in 0...400 {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
                print(String(n))
            }
        }
    }
    
    func testConsitency() {
        let n = BigUInt(22)
        for t in Tester.shared.completetesters {
            let oeis = t.OEISNr()
            //print(t.property(),oeis)
            if oeis == nil {
                 print(t.property(),oeis)
                let debug = t.OEISNr()
            }
        }
    }

    
   
    
    
}
