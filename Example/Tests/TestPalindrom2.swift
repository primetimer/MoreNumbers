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
    
    private func Palindrom2(n: BigUInt, b: Int = 10) -> (BigUInt,BigUInt)? {
        
        func reflect(_ p: BigUInt, m: Int, mid : Bool, base : Int) -> BigUInt {
            var s = p.getDigits(base: b)
            while s.count < m { s.insert(0, at: 0) }
            let r = s
            
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

    
    #if false //NUR FUER DETAILTESTS
    func test2_2() {
        
        var counter = 0
        for n0 in 0 ... 20001 {
            //if n0 == 201 { continue }
            let n = BigUInt(n0)
            let b = 10
            if let ans = Palindromic2Tester.Pali2(n: n, b: b, cancel: nil) {
                XCTAssert(ans.0 + ans.1 == n)
                XCTAssert(ans.0.isPalindromic(base: 10))
                XCTAssert(ans.1.isPalindromic(base: 10))
                //print(n0,":",ans)
            } else {
                counter += 1
                //print("No sum: \(counter):\(n0)")
            }
        }
        XCTAssert(counter == 3006)
    }
    

    
    
    func test2_nosum() {
        self.measure {
            for n0 in [  /* 200000000001 ,*/ 6849,103748,104292,104294,87218,37283] {
                let n = BigUInt(n0)
                let b = 10
                if Palindromic2Tester.Pali2(n: n, b: b,cancel : nil) != nil {
                    XCTAssert(false)
                    //print(n0,":",ans)
                } else {
                    //print("No sum: \(n0)")
                }
            }
        }
    }
    
    func test2_3600() {
        self.measure {
            for n0 in 0...3600 {
                let n = BigUInt(n0)
                let b = 10
                let ans = Palindromic2Tester.Pali2(n: n, b: b,cancel : nil)
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
                if let ans = Palindromic2Tester.Pali2(n: n, b: b,cancel : nil) {
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
    
#endif
}
