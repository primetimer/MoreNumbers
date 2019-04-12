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
    
    func testTetrahedral() {
        let t = TetrahedralTester()
        var sum = 0
        for k in 1...100 {
            sum = sum + k * (k+1) / 2
            let isspecial = t.isSpecial(n: BigUInt(sum), cancel: nil)
            if isspecial == false {
                print("Error")
            }
            XCTAssert(isspecial == true)
            
        }
    }
    
    func testPyramidal() {
        let t = PyramidalTester()
        var sum = 0
        for k in 1...100 {
            sum = sum + k * k
            let isspecial = t.isSpecial(n: BigUInt(sum), cancel: nil)
            if isspecial == false {
                print("Error")
            }
            XCTAssert(isspecial == true)
            
        }
    }
    
    func test4squares() {
        
        func countnonzero(sq: [BigInt]) -> Int {
            var ans = 0
            for f in sq {
                if f != 0 { ans = ans + 1 }
            }
            return ans
        }
        let t4 = SumOf4SquaresTester()
        
        for p in 0...1000 {
            let n = BigUInt(p)
            //if !n.isPrime() { continue }
            
            
            guard let ans = t4.squareTerms(n: n, cancel: nil) else { XCTAssert(false); return}
            let sum = ans[0]*ans[0] + ans[1]*ans[1] + ans[2]*ans[2] + ans[3]*ans[3]

//            print("\(p): \(sum) - \(ans) ")
            let special = t4.isSpecial(n: n, cancel: nil)  ?? false
            let count = countnonzero(sq: ans)
            if special {
                print(p)
                XCTAssert(count == 4)
            }
            

            if sum != n {
                print("Error at \(p)")
            }
            XCTAssert(sum == p)
        }
    }
    
    func test3squares() {
        
      let t3 = SumOf3SquaresTester()
        
        for p in 0...1000 {
            let n = BigUInt(p)
            let special = t3.isSpecial(n: n, cancel: nil)  ?? false
            if special {
                print("3-Squares \(p)")
            
                guard let ans = t3.squareTerms(n: n, cancel: nil)
                    else { XCTAssert(false); return}
                let sum = ans[0]*ans[0] + ans[1]*ans[1] + ans[2]*ans[2]

            
                if sum != n {
                    print("Error at \(p)")
                }
                XCTAssert(sum == p)
            }
        }
    }
    
}
