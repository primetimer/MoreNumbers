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
