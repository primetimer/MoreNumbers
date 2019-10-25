//
//  ViewController.swift
//  MoreNumbers
//
//  Created by primetimer on 02/23/2019.
//  Copyright (c) 2019 primetimer. All rights reserved.
//

import UIKit
import BigInt
import iosMath
import PrimeFactors
import MoreNumbers

//class ViewController: UIViewController {
//
//    var uiinput : UITextField!
//
//    override func viewDidLoad() {
//
//       view.backgroundColor = .blue
//
//    super.viewDidLoad()
//
//
//        uiinput = UITextField()
//        view.addSubview(uiinput)
//        uiinput.text = "Hallo x Welt"
//        //uiinput.isUserInteractionEnabled = true
//        uiinput.frame = CGRect(x: 20, y: 0, width: view.frame.width, height: 100)
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        view.backgroundColor = .blue
//        super.viewDidAppear(animated)
//    }
//
//
//}

#if true
class ViewController: UIViewController {

    var uimath : MTMathUILabel!
    var uilabel : UILabel!
    var uiinput : UITextField!
//
    
   
    
    private func testPIN() {
            let pcalc = PrimeCalculator()
            let pitable = PiTable(pcalc: pcalc, tableupto: 100000)
            let ml = PiMeisselLehmer(pcalc: pcalc, pitable: pitable)
          
            let n = BigUInt(100000*100000/10)
            let pin = ml.Pin(n: UInt64(n))
        
            let pintester = PinTester10n()
            print("Pin:",pin)
    }
    
    private func testSheldon() {
            let ptester = SheldonNumberTester()
            let n = BigUInt(73)
            let special = ptester.isSpecial(n: n, cancel: nil)
            let latex = ptester.getLatex(n: n)
            print(special,latex)
        uimath.latex = latex
    }
    
    private func testCongruent() {
            let ptester = CongruentTester()
           // let n = BigUInt(318)
        let n = BigUInt(5088)
            let special = ptester.isSpecial(n: n, cancel: nil)
            let latex = ptester.getLatex(n: n)
            print(special,latex)
        uimath.latex = latex
    }
    
    private func testSchizophrenic() {
        let t = SchizophrenicTester()
        let n = SchizophrenicTester.fn[27]

        let latex = t.getLatex(n: n)
        print(latex)
        uimath.latex = latex
    }
    
    private func testGelfond() {
        let t = MathConstantTester()
        let n = BigUInt(231)
        
        let latex = t.getLatex(n: n)
        print(latex)
        uimath.latex = latex
    }
    
    private func testGompertz() {
        let t = RationalApproxTester(.gompertz)
        let n = BigUInt(124)
        
        let latex = t.getLatex(n: n)
        print(latex)
        uimath.latex = latex
        
        let desc = t.Desc(n: n)
        print(desc)
    }
    
    private func testPadovan() {
        let t = PadovanTester()
        let n = PadovanTester.Nth(n: 13)
        let latex = t.getLatex(n: n)
        print(latex)
        uimath.latex = latex
    }
    private func testViswanath() {
        let t = MathConstantTester()
        let n = BigUInt(113)
        
        let latex = t.getLatex(n: n)
        print(latex)
        uimath.latex = latex
    }
    
    private func testAmicable() {
           let t = AmicableTester()
          // let n = BigUInt(220)
        let n = BigUInt(9363584)
        guard let special = t.isSpecial(n: n, cancel: TimeOut()) else { return }
        if special {
           let latex = t.getLatex(n: n)
           print(latex)
           uimath.latex = latex
        }
       }
    
    private func testSocial() {
              let t = SocialTester()
             // let n = BigUInt(220)
           let n = BigUInt(12496)
           guard let special = t.isSpecial(n: n, cancel: TimeOut()) else { return }
           if special {
              let latex = t.getLatex(n: n)
              print(latex)
              uimath.latex = latex
           }
          }
    private func testCarefree() {
        let t = MathConstantTester()
        let n = BigUInt(428)
        
        let latex = t.getLatex(n: n)
        print(latex)
        uimath.latex = latex
    }
    
    private func testMultiplicativePersistence() {
        let t = MultiplicativePersistenceTester()
        let n = BigUInt(428)
        
        let latex = t.getLatex(n: n)
        print(latex)
        uimath.latex = latex
    }
    
    private func testPrimorial() {
        let t = PrimorialPrimeTester()
        let t2 = PrimorialTester()
        let n = BigUInt(30)
        //let n = BigUInt("304250263527210")
        let latex = t2.getLatex(n: n)
        print(latex)
        uimath.latex = latex
    }
    
    private func testFactorial() {
        let t = FactorialPrimeTester()
        let tf = FactorialTester()
        //let n = BigUInt(30029)
        let n = BigUInt("120")*BigUInt(6)*BigUInt(7)
        let latex = tf.getLatex(n: n)
        print(latex)
        uimath.latex = latex
    }
    
    private func testSkewes() {
        let t = SkewesTester()
        let n = BigUInt(139)
        let latex = t.getLatex(n: n)
        print(latex)
        uimath.latex = latex
    }
    private func testGraham() {
        let t = GrahamNumberTester()
        let n = BigUInt(387)
        let latex = t.getLatex(n: n)
        print(latex)
        uimath.latex = latex
    }
    
    private func testRational() {
//        let t = RationalApproxTester(.pi)
        let n = BigUInt(22)
        //let n = BigUInt("304250263527210")
//        let latex = t.getLatex(n: n)
//        print(latex)
//        uimath.latex = latex
        
        for r in Tester.shared.completetesters {
            if r is RationalApproxTester {
                if r.isSpecial(n: n, cancel: nil) ?? false {
                    let latex = r.getLatex(n: n)
                    uimath.latex = latex
                }
            }
        }
    }
    
    private func testSquares() {
        let ts : [NumTester] = [SumOfTwoSquaresTester(),SumOf3SquaresTester(),SumOf4SquaresTester()]
      let n = BigUInt(252) // 4 Squares
//        let n = BigUInt(381) // 3 Squares
//        let n = BigUInt(17*29) // 2 Square
//        let n = BigUInt(13) // 2 square prime
        
        for t in ts {
            if t.isSpecial(n: n, cancel: nil) ?? false {
                let latex = t.getLatex(n: n)
                print(latex)
                uimath.latex = latex
            }
        }
    }
    
    private func testPalindromic2() {
        let t = Palindromic2Tester()
        let n = BigUInt(1031)
//        let n = BigUInt(1030)
//        let n = BigUInt(1001) //Nothing
        
        let latex = t.getLatex(n: n)
        print(latex)
        uimath.latex = latex
    }
    
    private func testGoldbach(){
        let t = GoldbachTester()
        let n = BigUInt(210)
        let latex = t.getLatex(n: n)
        print(latex)
        uimath.latex = latex
    }

    
    private func testPadic() {
        let t = DivergentTester()
//        let n = BigUInt(404)
//        let n = BigUInt(334)
//        let n = BigUInt(445) // 1 / 3
//        let n = BigUInt(666)
        let n = BigUInt(999)
        let latex = t.getLatex(n: n)
        print(latex)
        uimath.latex = latex
    }
    
    private func testLookAndSay() {
        let t = LookAndSayTester()
        //        let n = BigUInt(404)
        //        let n = BigUInt(334)
        //        let n = BigUInt(445) // 1 / 3
        //        let n = BigUInt(666)
        let n = BigUInt(1211)
        let latex = t.getLatex(n: n)
        print(latex)
        uimath.latex = latex
    }
    
    private func testLattice() {
        let t = LatticeTester()
        //        let n = BigUInt(404)
        //        let n = BigUInt(334)
        //        let n = BigUInt(445) // 1 / 3
        //        let n = BigUInt(666)
        let n = BigUInt(5)
        let latex = t.getLatex(n: n)
        print(latex)
        uimath.latex = latex
    }
    
    private func testEisenstein() {
        let t = GeneralizedCubanPrimeTester()
        //        let n = BigUInt(404)
        //        let n = BigUInt(334)
        //        let n = BigUInt(445) // 1 / 3
        //        let n = BigUInt(666)
        let n = BigUInt(21)
        let latex = t.getLatex(n: n)
        print(latex)
        uimath.latex = latex
    }
    
    private func testGauss() {
        let t = PythagoreanPrimeTester()
        //        let n = BigUInt(404)
        //        let n = BigUInt(334)
        //        let n = BigUInt(445) // 1 / 3
        //        let n = BigUInt(666)
        let n = BigUInt(2)
        let latex = t.getLatex(n: n)
        print(latex)
        uimath.latex = latex
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //uiinput.becomeFirstResponder()
        print("Will Appear")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        uiinput.becomeFirstResponder()
        print("Did Appear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        #if true
        uimath = MTMathUILabel()
        view.addSubview(uimath)
        uimath.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height-100)
        #endif
        
        
        
        uiinput = UITextField()
        view.addSubview(uiinput)
        uiinput.text = "Hallo x Welt"
        //uiinput.isUserInteractionEnabled = true
        uiinput.frame = CGRect(x: 20, y: 0, width: view.frame.width, height: 100)
     

        //testAmicable()
//        testSocial()
//        testPIN()
//        testSheldon()
        testCongruent()
        
        
//        testPadovan()
//        testViswanath()
//       testCarefree()
//        testMultiplicativePersistence()
//        testPrimorial()
//        testFactorial()
//        testGelfond()
//        testRational()
//        testSkewes()
//        testGraham()
//        testSquares()
//        testGompertz()
//        testPadic()
//        testPalindromic2()
//        testLookAndSay()
//        testLattice()
//        testGoldbach()
    // testEisenstein()
//        testGauss()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

}

#endif

