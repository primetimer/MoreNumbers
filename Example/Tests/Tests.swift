import XCTest
import MoreNumbers
import BigInt

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPiRational() {
        let t = MathConstantTester()
        
        guard let (type,digits) = t.FindConst(n: 314) else { XCTAssert(false); return }
        XCTAssert(type == MathConstantType.pi)
        let (oeis_n_nr,oeis_d_nr,_) = type.OEISRational()!
        let seqn = OEIS.shared.GetSequence(oeisnr: oeis_n_nr)!
        let seqd = OEIS.shared.GetSequence(oeisnr: oeis_d_nr)!
//                for i in 0..<seqn.count {
//                    print("Gamma \(i) = \(seqn[i]) / \(seqd[i])")
//                }
        let frac = ContinuedFractions.shared.ValueRationalDigits(numerator: seqn[1], denominator: seqd[1],precision :5)
        XCTAssert(frac == "3.14285")
    }

    
    func testGammaRational() {
        let t = MathConstantTester()
        
        guard let (type,digits) = t.FindConst(n: 577) else { XCTAssert(false); return }
        XCTAssert(type == MathConstantType.gamma)
        let (oeis_n_nr,oeis_d_nr,_) = type.OEISRational()!
        let seqn = OEIS.shared.GetSequence(oeisnr: oeis_n_nr)!
        let seqd = OEIS.shared.GetSequence(oeisnr: oeis_d_nr)!
//        for i in 0..<seqn.count {
//            print("Gamma \(i) = \(seqn[i]) / \(seqd[i])")
//        }
        let frac = ContinuedFractions.shared.ValueRationalDigits(numerator: seqn[8], denominator: seqd[8],precision :4)
        print(frac)
    }
    
    func testPhiPow() {
        let t = MathConstantTester()
        
        var phi = MathConstant().ValueStr(type: .phi)
        phi = phi.replacingOccurrences(of: ".", with: "")
        phi.truncate(length: 100)
        let nphi = BigUInt(phi)!
        
        var pow10 = BigUInt(1)
        for _ in 1...100 {
            pow10 = pow10 * BigUInt(10)
        }
        
        var phipow = nphi
        for _ in 2...19 {
            phipow = phipow * nphi / pow10
            
        }
        print(String(phipow))
        
       
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
