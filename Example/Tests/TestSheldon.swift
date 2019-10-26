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


class SheldonTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAsinOEIS() {
        let t = SheldonPrimeTester()
        let seq = [2, 17, 73, 89, 2475989]
        
        for n in 0...100 {
            if let special = t.isSpecial(n: BigUInt(n), cancel: nil) {
                if special {
                    print("Sheldon:\(n)")
                    XCTAssert(seq.contains(n))
                } else {
                    XCTAssert(!seq.contains(n))
                }
            }
        }
        for n in seq {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            XCTAssert(special)
        }
        
       
        
//        for n in 100000...1000000 {
//            if let special = t.isSpecial(n: BigUInt(n), cancel: nil) {
//                if special {
//                    print("Sheldon:\(n)")
//                    XCTAssert(false)
//                }
//            }
//        }
        
    }
    
    
   // 2,475,989 -> 181,440
    
//    func testall() {
//        let t = SheldonNumberTester()
//        for n in 2...1000 //1000000 //Check 1199
//        {
//            if let info = t.Info(n: BigUInt(n)) {
//                print(n,":",info)
//            } else {
//                print(n, "No Solution")
//            }
//        }
//    }
//
//    func test73() {
//       
//        let x = BigUInt(73)
//        let t = SheldonReverseNumberTester() //What is that?
//        
//        for n in 1...100
//        {
//            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
////            if special {
////                let pin = PinTester10n.ml.Pin(n: UInt64(n))
////                let latex = t.getLatex(n: BigUInt(n))
////                //print(n,pin,latex)
////                //XCTAssert(n == 73 || n == 17)
////            }
//        }
//    }
    
    
    //
    //Tabelle der π(rev(n) = rev(π(n))
    //Eigenkreation
    func testpinreverse() {
        let t = SheldonNumberTester()
        var s = ""
        for n in 0...1000 //1000000
        {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
                if !s.isEmpty { s = s + "," }
                s = s + String(n)
                print(String(n))
                let pin = PinTester10n.ml.Pin(n: UInt64(n))
                let rev = t.reverse(n: BigUInt(n), base: 10)
                let revpin = PinTester10n.ml.Pin(n: UInt64(rev))
                print("Pin: \(pin)")
                print("rev: \(String(rev))")
                print("Rpin:\(revpin)")
                
                let test = t.reverse(n: BigUInt(pin),base :10)
                XCTAssert(revpin == test)
                
            }
        }
        print(s)
    }
}
