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
        testCarefree()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

