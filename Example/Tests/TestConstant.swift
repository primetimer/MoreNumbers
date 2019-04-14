import XCTest
import MoreNumbers
import BigInt

class TestGelfond: XCTestCase {
    
    func testGelfond() {
        let t = MathConstantTester()
        let n = BigUInt(231)
        
        let digits = t.CheckConstDigits(n: n, type: .gelfond)
        XCTAssert(digits == 3)
        let special = t.isSpecial(n: n, cancel: nil)
        XCTAssert(special == true)
        
        guard let (type,_) = t.FindConst(n: n) else { XCTAssert(false); return }
        XCTAssert(type == .gelfond)
        
        guard let (oeis_n_nr,oeis_d_nr,_) = type.OEISRational() else { XCTAssert(false); return }
        //if !OEIS.shared.ContainsNumber(oeisnr: oeis_n_nr, n: n) { continue }
        guard let seqn = OEIS.shared.GetSequence(oeisnr: oeis_n_nr) else { XCTAssert(false); return }
        guard let seqd = OEIS.shared.GetSequence(oeisnr: oeis_d_nr) else { XCTAssert(false); return }
        for i in 0...5 {
            print("Gelfond",seqn[i],seqd[i])
        }
        XCTAssert(Int(seqn[1]) == 162)
        XCTAssert(Int(seqd[1]) == 7)
    }
}

class TestGompertz: XCTestCase {
    
    func testGompertz() {
        let t = SpecialConstantTester(.gompertz)
        let n = BigUInt(596)
        
        let digits = t.CheckConstDigits(n: n, type: .gompertz)
        XCTAssert(digits == 3)
        let special = t.isSpecial(n: n, cancel: nil)
        XCTAssert(special == true)
        
        guard let (type,_) = t.FindConst(n: n) else { XCTAssert(false); return }
        XCTAssert(type == .gompertz)
        
        guard let (oeis_n_nr,oeis_d_nr,_) = type.OEISRational() else { XCTAssert(false); return }
        //if !OEIS.shared.ContainsNumber(oeisnr: oeis_n_nr, n: n) { continue }
        guard let seqn = OEIS.shared.GetSequence(oeisnr: oeis_n_nr) else { XCTAssert(false); return }
        guard let seqd = OEIS.shared.GetSequence(oeisnr: oeis_d_nr) else { XCTAssert(false); return }
        for i in 0...5 {
            print("Gompertz",seqn[i],seqd[i])
        }
        XCTAssert(Int(seqn[2]) == 4)
        XCTAssert(Int(seqd[2]) == 7)
    }
    
    func testRational() {
        let t = RationalApproxTester(.gompertz)
        let n = BigUInt(124)
        
        guard let special = t.isSpecial(n: n, cancel: nil) else {
            XCTAssert((false))
            return
        }
        XCTAssert(special == true)
        
    }
    
    func testSumming() {
        var prod = BigInt(2)
        var sum = BigInt(2)
        for k in 2...20 {
            if k % 2 == 1 { continue }
            prod = prod * BigInt(k+1)
            sum = sum - prod
            prod = prod * BigInt(k+2)
            sum = sum + prod
            
            let s = String(sum,radix: 7)
            print(s)
            
        }
    }
}

