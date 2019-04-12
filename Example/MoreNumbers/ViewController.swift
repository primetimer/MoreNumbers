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
import MoreNumbers


class ViewController: UIViewController {

    var uimath : MTMathUILabel!
    var uilabel : UILabel!
//
//
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
        let n = BigUInt(252)
        
        for t in ts {
            if t.isSpecial(n: n, cancel: nil) ?? false {
                let latex = t.getLatex(n: n)
                print(latex)
                uimath.latex = latex
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uimath = MTMathUILabel()
        uilabel = UILabel()
        view.addSubview(uimath)
//        view.addSubview(uilabel)
        
        uimath.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        uilabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        uilabel.text = "Hallo Welt"
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
        testSquares()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

}

