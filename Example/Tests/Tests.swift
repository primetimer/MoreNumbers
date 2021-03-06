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
        
        guard let (type,_) = t.FindConst(n: 314) else { XCTAssert(false); return }
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
        
        guard let (type,_) = t.FindConst(n: 577) else { XCTAssert(false); return }
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
        _ = MathConstantTester()
        
        var phi = MathConstant().ValueStr(type: .phi)
        phi = phi.replacingOccurrences(of: ".", with: "")
        _ = phi.truncate(length: 100)
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
    
    func test2Squares() {
        let n = BigUInt(529)
        let t = SumOfTwoSquaresTester()
        
        _ = t.Desc(n: n)
        let (a,b) = t.Express(n: n, cancel: nil)!
        print(a,b)
    }
    
    func testHurwitz() {
        for n in 1...100 {
//            print("Factorize : \(n)")
            guard let harr = HurwitzInt.FactorHurwitz(n: BigUInt(n)) else {
                XCTAssert(false)
                break
            }
            var prod = HurwitzInt(1)
            for h in harr {
                for _ in 0..<h.pow {
                    prod = prod * h.0
                }
//                print(h,prod)
            }
            XCTAssert(prod.a[0] == BigInt(n))
            for i in 1 ... 3 { XCTAssert(prod.a[i] == 0) }
        }
    }
    
    func testAbundance() {
//        let n = BigUInt(18)
        // 18 = 2*3*3
        // 1 +2 + 6 + 9 + 18 
        let t = AbundanceTester()
        do {
            let special = t.isSpecial(n: 18, cancel: nil)
            XCTAssert(special == true)
        }
        
        do {
            let special = t.isSpecial(n: 6, cancel: nil)
            XCTAssert(special == false)
        }
        
        
    }
    
    func testPadicRoot() {
        let x = padic(2, base: 7)
        let r = x.squareRoot()!
        let r2 = r*r
        print(r)
        XCTAssert(r2.value == 2)
    }
    
    func testGoldbach() {
        let g = [5, 7, 10, 16, 36, 210]
        let t = GoldbachTester()
        for n in 4...360 {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if g.contains(n) {
                XCTAssert(special)
            } else {
                XCTAssert(!special)
            }
            let latex = t.getLatex(n: BigUInt(n)) ?? ""
            if latex.isEmpty {
                print("Goldbacherror\(n)" )
            }
            XCTAssert(!latex.isEmpty)
            
            print("\(n): \(special) - \(latex)")
            
        }
    }
    
    func testEisensteinPrime() {
        let t = PrimeTester()
        let f = EisensteinInt.FactorPrime(p: 7)
        print(f!)
        let latex = t.getLatex(n: 7)
        print(latex!)
        
        
    }

    
}
