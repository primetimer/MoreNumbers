import XCTest
import MoreNumbers
import BigInt


class TestPalindromSum2: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    private func Palindrom2(s: [Int], b: Int = 10) -> ([Int],[Int])? {
        
        if s.count == 0 { return nil }
        var x = Array(repeating: 0, count: s.count)
        var y = Array(repeating: 0, count: s.count)
        var z = Array(repeating: 0, count: s.count)
        let c = s.count - 1
        
        //Leading zero possible?
        if s[0] == 1 {
            var s0 = Array(repeating: 0, count: s.count-1)
            for i in 0...c-1 {
                s0[i] = s[i+1]
            }
            s0[0] += b
            if let ans = Palindrom2(s: s0) {
                for i in 0...s.count-2 {
                    x[i+1] = ans.0[i]
                    y[i+1] = ans.1[i]
                }
                return (x,y)
            }
        }
        for x0 in 0...b-1 {
            x[0] = x0
            x[c] = x0
            //Case 1 ohne Uebertrag
            
            y[0] = s[0] - x[0]
            if y[0] < 0 { y[0] = 0 }
            if y[0] >= b { y[0] = b-1 }
            y[c] = y[0]
            
            if x[c]+y[c] == s[c] {
                if s.count == 1 { return (x,y) }
                var s1 = Array(repeating: 0, count: s.count-1)
                for i in 0..<s.count-1 { s1[i] = s[i+1] }
                if let ans = Palindrom2(s: s1) {
                    for i in 0...s.count-2 {
                        x[i+1] = ans.0[i]
                        y[i+1] = ans.1[i]
                    }
                    return (x,y)
                }
            }
            
            //Case 2 2 mit Uebertrag vorher
            y[0] = max(s[0] - x[0] - 1,0)
            z[0] = 1
            x[c] = x[0]
            y[c] = y[0]
            
            if x[0]+y[0]+z[0] == s[0] && (x[c] + y[c] + 1) % b == s[c] && s.count > 1 {
                var s2 = Array(repeating: 0, count: s.count-1)
                s2[0] = 10 + s[1]
                for i in 1..<s.count-1 { s2[i] = s2[i+1] }
                if let ans = Palindrom2(s: s2) {
                    for i in 0...s.count-2 {
                        x[i+1] = ans.0[i]
                        y[i+1] = ans.1[i]
                    }
                    return (x,y)
                }
            }
        }
        return nil
    }
    
    func test2() {
        let n = BigUInt(100)
        let b = 10
        
        
        let s : [Int] = n.getDigits(base: b).reversed()
        let ans = Palindrom2(s: s)
        print(ans)
        
    }
}
