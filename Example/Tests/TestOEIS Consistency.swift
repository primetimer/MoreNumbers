import XCTest
import MoreNumbers
import BigInt

class TestOEISConsistency: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTwin() {
        let t = TwinPrimeTester()
        for n in 0...100 {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
                print(String(n))
            }
        }
    }
    
    func testConstructible() {
        let t = ConstructibleTester()
        for n in 0...100 {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
                print(String(n))
            }
        }
    }
    
    func testNarcissticList() {
        let t = NarcisticTester()
        for n in 0...400 {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
                print(String(n))
            }
        }
    }
    
    func testAmicableList() {
        let t = AmicableTester()

        for n in 0...400 {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
                print(String(n))
            }
        }
        testSeries(tester: t)
    }
    
    func testSocialList() {
           let t = SocialTester()

           for n in 14000...15000 {
               let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
               if special {
                   print(String(n))
               }
           }
           testSeries(tester: t)
       }

    
     func testSumOfTwoSuares() {
        let t = SumOfTwoSquaresTester()
        for n in 0...400 {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
                print(String(n))
            }
            let latex = t.getLatex(n: BigUInt(n))
            XCTAssert(latex != "")
        }
    }
    
    func testSumOfTwoCubes() {
        let t = SumOfTwoCubesTester()
        for n in 0...400 {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
                print(String(n))
            }
        }
    }
    
    func testSierpinksi() {
        let t = SierpinskiTester()
        for n in 0...400 {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
                print(String(n))
            }
        }
    }
    
    func testProth() {
        let t = ProthTester()
        for n in 0...400 {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
                print(String(n))
            }
        }
    }
    
    func testNonTotient() {
        let t = NonTotientTester()
        for n in 0...400 {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
                print(String(n))
            }
        }
    }
    
    func testLattice() {
        let t = LatticeTester()
        for n in 0...400 {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
                print(String(n))
            }
        }
    }
    
    func testLucky() {
        let t = LuckyTester()
        for n in 0...400 {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
                print(String(n))
            }
        }
    }
    
    func testB() {
        let t = BernoulliTester()
        for n in 0...4000 {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
                print(String(n))
            }
        }
    }
    
    func testRationalBruns() {
        let t = RationalApproxTester(.bruns)
        for n in 19...400 {
            let special = t.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
                print(String(n))
            }
        }
    }
    
    func testConsitency() {
       
        for t in Tester.shared.completetesters {
            let oeis = t.OEISNr()
            //print(t.property(),oeis)
            if oeis == nil {
                 print(t.property(),oeis)
                let debug = t.OEISNr()
            }
            
            testSeries(tester: t)
        }
    }
    
    private func testSeries(tester: NumTester) {
        print(tester.property(),tester.OEISNr())
        guard let oeis = tester.OEISNr() else {
            if tester.property() == "p-adic" { return }
            print("No Oeis")
            XCTAssert(false)
            return
        }
        
        let (start,offset) : (Int,Int) = {
            switch tester.property() {
            case "narcissistic","audioactive":
                return (-1,0)
            case "Constructible":
                return (3,2)
            case "palindromic":
                return (-1,0)
            case "rational δ approx":
                return (-1,0)
            case "prime":
                return (2,0)
            case "triangle","Mersenne":
                return (1,1)
            case "pronic","square","cube":
                return (0,1)
            case "Fibonacci":
                return (2,3)
            case "tetrahedral","pentagonal","sum of two squares","sum of two cubes":
                return (2,2)
            case "rational B2 approx":
                return (-1,0)
            default :
                return (0,0)
            }
        }()
        
        if start < 0 {
            return
        }
        
        var rindex = offset
        for n in start...100 {
            let special = tester.isSpecial(n: BigUInt(n), cancel: nil) ?? false
            if special {
//                if tester.property() == "sexy prime" {
//                    print("Debug: \(tester.property())")
//                }
                let root = tester.RootIndex(n: BigUInt(n))
                if root == nil {
                    print("Fehler: \(n)")
                    let rdebug = tester.RootIndex(n: BigUInt(n))
                    XCTAssert(false)
                } else if root! >= 0 {
                    if rindex != root! && rindex != root!+1 && rindex != root!-1 {
                        print("Error:",tester.property(),root,rindex)
                        XCTAssert(false)
                    }
                    
                } else if root == -1 {
                    return
                }
                rindex += 1
            }
            
        }
    }
}
