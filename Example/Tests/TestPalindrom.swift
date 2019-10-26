import XCTest
import BigInt
import MoreNumbers

//
//  PalindromeTests.swift
//  PalindromeTests
//
//  Created by Stephan Jancar on 22.09.18.
//  Copyright © 2018 Stephan Jancar. All rights reserved.
//


class PalindromeTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private func isPalindrom(p: BigUInt, base: Int = 10) -> Bool {
        let dummy = PalindromeSplitter(p: p,base:base)
        dummy.Calc()
        
        
        let c = dummy.d.count
        for i in 0..<c {
            if dummy.d[i] != dummy.d[c-i-1] {
                //                XCTAssert(dummy.d[i] == dummy.d[c-i-1])
                print("Not a palindrom:",String(p,radix: base))
                XCTAssert(false)
                return false
            }
        }
        return true
    }
    
    private func PalindromeTest(splitter: PalindromeSplitter) {
        
        let sum = splitter.p1 + splitter.p2 + splitter.p3
        if sum != splitter.x {
            print(splitter.description)
            print("Sum Error \(sum)")
        }
        XCTAssert(sum == splitter.x)
        if !isPalindrom(p: splitter.p1,base: splitter.base) {
            print(splitter.description)
        }
        if !isPalindrom(p: splitter.p2,base: splitter.base) {
            print(splitter.description)
        }
        if !isPalindrom(p: splitter.p3,base: splitter.base) {
            print(splitter.description)
        }
    }
    
    private func Check(_ n: Int) {
        let psplit = PalindromeSplitter(p: BigUInt(n),base : 10)
        //        let sampler = PalindromSampler(ndigits: psplit.x.digitsCount(base: psplit.base), base: psplit.base)
        //        psplit.sampler = sampler
        psplit.Calc()
        //        print(sampler.description)
        PalindromeTest(splitter: psplit)
        
        #if false
        let psplit9 = PalindromeSplitter(p: BigUInt(n),base : 9)
        psplit9.Calc()
        PalindromeTest(splitter: psplit9)
        #endif
    }
    
    func test2() {
        for x in 1...99 {
            Check(x)
            do {
                let split = PalindromeSplitter(p: BigUInt(x))
                split.Calc()
                print(split)
            }
            
        }
    }
    func test3() {
        for x in 100...999 {
            Check(x)
            do {
                let split = PalindromeSplitter(p: BigUInt(x))
                split.Calc()
                print(split)
            }
        }
    }
    func test4() {
        Check(1011)
        for x in 1000...9999 {
            Check(x)
        }
    }
    func test5() {
        Check(11002)
        Check(12009)
        Check(10011)
        #if false
        for xsplit in 10000...99999 {
            Check(xsplit)
        }
        #endif
    }
    
    func test6Leading1() {
        Check(100108)
        Check(100000)
        Check(100008)
        #if true
        for x in 0...999 {
            print("Running:",x)
            Check(x + 100000)
        }
        #endif
    }
    
    func test6() {
        Check(537321)
        Check(531562)
        Check(200019)
        Check(200108)
        Check(200000)
        Check(200008)
        
        for i in 0...999 {
            let x = Int(arc4random_uniform(999999))
            print("running random6 \(i)  - \(x):")
            Check(x)
        }
    }
    
    func testIII() {
        let x = BigUInt("120205690315959428539")!
        let psplit = PalindromeSplitter(p: x)
        psplit.Calc()
        PalindromeTest(splitter: psplit)
        print(psplit.description)
        
    }
    
    func testV() {
        do {
            let psplit = PalindromeSplitter(p: BigUInt("12267420107203532444")!)
            psplit.Calc()
            print("\(psplit.algorithm) : \(psplit.description)")
            PalindromeTest(splitter: psplit)
        }
        do {
            let psplit = PalindromeSplitter(p: BigUInt("119344680970704967")!)
            psplit.Calc()
            print("\(psplit.algorithm) : \(psplit.description)")
            PalindromeTest(splitter: psplit)
        }
        
    }
    
    func testIV() {
        Check(114745905976)
        do {
            let psplit = PalindromeSplitter(p: BigUInt("119344679870704967")!)
            psplit.Calc()
            print("\(psplit.algorithm) : \(psplit.description)")
            PalindromeTest(splitter: psplit)
        }
        
        do {
            let psplit = PalindromeSplitter(p: BigUInt("1057232968050192")!)
            psplit.Calc()
            print("\(psplit.algorithm) : \(psplit.description)")
            PalindromeTest(splitter: psplit)
        }
    }
    
    private func BigRand() -> BigUInt {
        let ndigits = Int.random(in: 1...20)
        var r = BigUInt(0)
        for _ in 0...ndigits {
            let d = Int.random(in: 0 ..< 10)
            r = r * BigUInt(10) + BigUInt(d)
        }
        return r
    }
    
    func test104() {
        Check(10402344)
        Check(10420275)
        Check(1043361810814)
        
    }
    
    func testB7() {
        Check(1130003)    //Not really B7
    }
    
    func testcountTypes() {
        
        var count : [Int] = Array(repeating: 0, count: NumType.allCases.count)
        for _ in 0...10000 {
            let x = BigRand()
            let split = PalindromeSplitter(p: x)
            split.Calc()
            PalindromeTest(splitter: split)
            if let index = split.type?.rawValue {
                count[index] = count[index] + 1
            }
            
        }
        print(count)
        
    }
    
    func testTypes() {
        
        for type in NumType.allCases {
            if type == .B7 { break }
            print("Looking for \(type)")
            while true {
                let r = BigRand()
                let psplit = PalindromeSplitter(p: r)
                psplit.Calc()
                PalindromeTest(splitter: psplit)
                if psplit.type == type { break }
            }
        }
    }
    
    /*
     func testbase2error() {
     let x = BigUInt(67)
     let split = PalindromeSplitter(x: x, base: 2)
     print(split.description)
     
     for i in 1...400 {
     
     let x = 1 + 2*i
     let split = PalindromeSplitter(x: BigUInt(x), base: 2)
     print(split.description)
     PalindromeTest(splitter: split)
     }
     }
     */
    
    func testSingle() {
        Check(12256004)
        Check(12380373)
        Check(10406830)
        let x = BigUInt(10406830)
        let psplit = PalindromeSplitter(p:x,base : 10)
        psplit.Calc()
        PalindromeTest(splitter: psplit)
        //        print(psplit)
        
        
    }
    func test103() {
        Check(10380344)
        Check(10398275)
        Check(10300003)
        Check(10307293)
        
        Check(10307283)
        Check(103072930000)
        Check(10296293)
        
        let x = BigUInt("10350502730293692993")!
        let psplit = PalindromeSplitter(p:x,base : 10)
        psplit.Calc()
        PalindromeTest(splitter: psplit)
        
    }
    
    func testRandom() {
        var testalgorithms = [false,false,false,false,false,false]
        for _ in 1...1000 {
            let ndigits = Int.random(in: 1...20)
            var r = BigUInt(0)
            for _ in 0...ndigits {
                let d = Int.random(in: 0 ..< 10)
                r = r * BigUInt(10) + BigUInt(d)
            }
            let psplit = PalindromeSplitter(p: r)
            psplit.Calc()
            //print("\(psplit.algorithm) : \(psplit.description)")
            PalindromeTest(splitter: psplit)
            testalgorithms[psplit.algorithm] = true
        }
        let completed = testalgorithms[0] && testalgorithms[1] && testalgorithms[2] && testalgorithms[3] && testalgorithms[4] && testalgorithms[5]
        XCTAssert(completed == true)
    }
    
    func testExample() {
        Check(1001)
        Check(11640299)
        Check(12742510)
        Check(11755711)
        Check(6201111026)
        Check(6751968672)
        
        Check(13000031)
        Check(9)
        Check(10)
        Check(57)
        Check(75)
        Check(77)
        Check(100)
        Check(201)
        Check(301)
        Check(789)
        Check(1000)
        
        Check(1002)
        Check(1009)
        Check(2000)
        Check(7234)
        
    }
    
    func testHex() {
        
        let x = 7730
        let split = PalindromeSplitter(p: BigUInt(x), base: 16)
        split.Calc()
        
        let src = String(split.x, radix : 16)
        let p1 = String(split.p1, radix : 16)
        let p2 = String(split.p2, radix : 16)
        let p3 = String(split.p3, radix : 16)
        print(src,p1,p2,p3)
        XCTAssert(p2 == "e2e")
    }
    
    
    
    
}
