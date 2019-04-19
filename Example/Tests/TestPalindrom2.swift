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
    
    private func Pali2(n: BigUInt, b: Int = 10) -> (BigUInt,BigUInt)? {
        let d = n.getDigits(base: b)
        let m = d.count / 2
        
        if n.isPalindromic(base: b) {
            return (n,0)
        }
        
        for r in 0...1 {
            
            var p = Array(repeating: 0, count: d.count)
            var q = Array(repeating: 0, count: d.count)
            
            var loopcount = b
            for _ in 0...m {
                loopcount = loopcount * b
            }
            for _ in 0...loopcount - 1 {
                
                var j = 0
                repeat {
                    p[j] = p[j] + 1
                    p[d.count-j-1-r] = p[j]
                    if p[j] == b {
                        p[j] = 0
                        p[d.count-j-1] = p[j]
                        j = j + 1
                    } else {
                        break
                    }
                    
                } while j <= m
                
                if p[0] == 0 {
                    continue
                }
                if j > m {
                    continue //r-loop
                }
                
                //Reflect
                //            for r in 0..<m {
                //                p[d.count-1-r] = p[r]
                //            }
                
                var carry = 0
                for k in 0..<d.count {
                    q[k] = d[k] - p[k] - carry
                    if q[k] < 0 {
                        carry = 1
                        q[k] = q[k] + b
                    } else {
                        carry = 0
                    }
                }
                if carry>0 {
                    continue
                }
                
                //sum
                var start = d.count
                repeat {
                    start = start - 1
                } while q[start] == 0 && start > 0
                
                var ispalindrom = true
                for l in 0...start {
                    if q[start-l] != q[l] {
                        ispalindrom = false
                        break
                    }
                }
                
                if ispalindrom {
                    var ansp : BigUInt = 0
                    var ansq : BigUInt = 0
                    for i in 0..<p.count {
                        ansp = ansp * BigUInt(b) + BigUInt(p[d.count-i-1])
                        ansq = ansq * BigUInt(b) + BigUInt(q[d.count-i-1])
                    }
                    return (ansp,ansq)
                }
            }
        }
        return nil
    }
    
    func test2_2() {
        for n0 in 100 ... 1108 {
            //if n0 == 201 { continue }
            let n = BigUInt(n0)
            let b = 10
            if let ans = Pali2(n: n, b: b) {
                XCTAssert(ans.0 + ans.1 == n)
                print(n0,":",ans)
            } else {
                print("No sum: \(n0)")
            }
        }
    }
    private func Palindrom2(n: BigUInt, b: Int = 10) -> (BigUInt,BigUInt)? {
        
        func reflect(_ p: BigUInt, m: Int, mid : Bool, base : Int) -> BigUInt {
            var s = p.getDigits(base: b)
            while s.count < m { s.insert(0, at: 0) }
            var r = s
            
            if mid { s.removeFirst() }
            for d in  r {
                s.insert(d, at: 0)
            }
            
            var ans = BigUInt(0)
            for d in s {
                ans = ans * BigUInt(b) + BigUInt(d)
            }
            return ans
        }
        
        if n.isPalindromic(base: b) {
            return (n,0)
        }
        
        let m : Int = {
            let s = n.getDigits(base: b)
            let count = s.count
            let m = count % 2 == 0 ? count / 2 : count / 2 + 1
            return m
        }()
        
        
        let n2 = BigUInt(b).power(m)
        for p2 in 1 ..< n2 {
            do {
                let p = reflect(p2,m: m, mid: true, base: b)
                if p <= n {
                    let q = n-p
                    if q.isPalindromic(base: b) {
                        assert(p.isPalindromic(base: b))
                        return (p,q)
                    }
                }
            }
            do {
                let p = reflect(p2,m: m-1, mid: false, base: b)
                if p <= n {
                    let q = n-p
                    if q.isPalindromic(base: b) {
                        assert(p.isPalindromic(base: b))
                        return (p,q)
                    }
                }
            }
        }
        return nil
        
        
    }
    
    
    
    func test2() {
        
        for n0 in 100 ... 999 {
            if n0 == 201 { continue }
            let n = BigUInt(n0)
            let b = 10
            if let ans = Palindrom2(n: n, b: b) {
                XCTAssert(ans.0 + ans.1 == n)
                print(n0,":",ans)
            } else {
                print("No sum: \(n0)")
            }
        }
        
    }
    
    func test2_1000() {
        for n0 in 1000 ... 1108 {
            if n0 == 201 { continue }
            let n = BigUInt(n0)
            let b = 10
            if let ans = Palindrom2(n: n, b: b) {
                XCTAssert(ans.0 + ans.1 == n)
                //print(n0,":",ans)
            } else {
                print("No sum: \(n0)")
            }
        }
    }
    
    func test2_nosum() {
        self.measure {
            
        
        for n0 in [ 200000000001, 6849,103748,104294,87218] {
            let n = BigUInt(n0)
            let b = 10
            if let ans = Pali2(n: n, b: b) {
                XCTAssert(false)
                //print(n0,":",ans)
            } else {
                print("No sum: \(n0)")
            }
        }
        }
    }
    
    func test2_issum() {
        for n0 in [100000000,6849-1,103748-1,104294-1,87218-1] {
            let n = BigUInt(n0)
            let b = 10
            if let ans = Palindrom2(n: n, b: b) {
                XCTAssert(ans.0 + ans.1 == n)
                //print(n0,":",ans)
            } else {
                XCTAssert(false)
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            for n0 in 1000 ... 1108 {
                if n0 == 201 { continue }
                let n = BigUInt(n0)
                let b = 10
                if let ans = Palindrom2(n: n, b: b) {
                    XCTAssert(ans.0 + ans.1 == n)
                    //print(n0,":",ans)
                } else {
                    //print("No sum: \(n0)")
                }
            }// Put the code you want to measure the time of here.
        }
    }
    
    
    func testPerformanceExampleCompare() {
        // This is an example of a performance test case.
        self.measure {
            for n0 in 1000 ... 1108 {
                if n0 == 201 { continue }
                let n = BigUInt(n0)
                let b = 10
                if let ans = Pali2(n: n, b: b) {
                    XCTAssert(ans.0 + ans.1 == n)
                    //print(n0,":",ans)
                } else {
                    //print("No sum: \(n0)")
                }
            }// Put the code you want to measure the time of here.
        }
    }
    func testPerformanceExample2() {
        // This is an example of a performance test case.
        self.measure {
            for n0 in 1000 ... 1108 {
                
                let n = BigUInt(n0)
                let isp = n.isPrime()
                
            }// Put the code you want to measure the time of here.
        }
    }
}
