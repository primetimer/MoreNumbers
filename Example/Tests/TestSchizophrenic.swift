import XCTest
import MoreNumbers
import BigInt

class TestsSchizo: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    private func f(n: UInt) -> BigUInt {
        if n == 0 { return BigUInt(0) }
        let ans = f(n: n-1) * BigUInt(10) + BigUInt(n)
        return ans
    }
    
    // √fn = r + s --> fn = r^2 + 2rs + s^2 --> fn-r^2 = 2 rs + s^2 = 2s (r+s)
    // √(fn*10^2p) = 10^p (r+s) --> √(fn*10^2p) - 10^pr = 10^p s
    
    func test_Demo49() {
        let t = SchizophrenicTester()
        let n = UInt(49)
        let fn = f(n: n)
        
        let special = t.isSpecial(n: fn, cancel: nil)
        XCTAssert(special == true)
        let idx = t.GetIndex(n: fn)!
        let (ipart,fpart) = t.getSchizoString(idx: idx, precision: 1000)!
        print(ipart,".",fpart)
            let ref = "1111111111111111111111086055555555555555555555555555555555555555555555527305416666666666666666666666666666666666666666602962603472222222222222222222222222222222222222042656394092881944444444444444444444444444444443877555125040117187499999999999999999999999999998082496877114863053385416666666666666666666666659871857386214406386555989583333333333333333333308434604076276082069402770996093749999999999999906422275875559830666394303215874565972222222221863492016791180833081844"
        XCTAssert(fpart.contains(ref))
    }
    func testDemo49() {
        
        let prec = 1000
        let p10 : BigUInt = {
            var ans = BigUInt(1)
            for _ in 1...prec {
                ans = ans * BigUInt(10)
            }
            return ans
        }()
        
        let n = UInt(49)
        let fn = f(n: n)
        let r = fn.squareRoot()
        let fnp = fn * p10*p10
        _ = fn - r*r
        let rp = fnp.squareRoot()
        let dif = rp - p10*r
        let frac = String(dif)
        let ref = "1111111111111111111111086055555555555555555555555555555555555555555555527305416666666666666666666666666666666666666666602962603472222222222222222222222222222222222222042656394092881944444444444444444444444444444443877555125040117187499999999999999999999999999998082496877114863053385416666666666666666666666659871857386214406386555989583333333333333333333308434604076276082069402770996093749999999999999906422275875559830666394303215874565972222222221863492016791180833081844"
        print(frac)
        print(ref)
        print(String(r) + "." + frac)
        XCTAssert(frac.contains(ref))
    }
    
//    func testDemo() {
//        
//        let prec = 100
//        let p10 : BigUInt = {
//            var ans = BigUInt(1)
//            for _ in 1...prec {
//                ans = ans * BigUInt(10)
//            }
//            return ans
//        }()
//        
//        for n : UInt in 0...10 {
//            
//            let fn = f(n: 2*n+1)
//            let r = fn.squareRoot()
//            let fnp = fn * p10*p10
//            let fnr = fn - r*r
//            let rp = fnp.squareRoot()
//            let dif = rp - p10*r
//            let frac = String(dif)
//            print(String(2*n+1) + ":" + String(fn))
//            print(String(2*n+1) + ":" + String(r) + "." + frac)
//        }
//    }
}
