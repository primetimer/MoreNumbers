//
//  ViewController.swift
//  MoreNumbersInput
//
//  Created by Stephan Jancar on 30.09.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import BigInt
import PrimeFactors
import MoreNumbers
import iosMath

class ViewController: UIViewController {
    
    var uiinput : UITextField!
    var uimath : MTMathUILabel!
    
    private func testSchizophrenic() {
        let t = SchizophrenicTester()
        let n = SchizophrenicTester.fn[27]
        
        let latex = t.getLatex(n: n)
        print(latex)
        uimath.latex = latex
    }
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        
        super.viewDidLoad()
        
        uiinput = UITextField()
        view.addSubview(uiinput)
        uiinput.text = "Hallo x Welt"
        //uiinput.isUserInteractionEnabled = true
        uiinput.frame = CGRect(x: 20, y: 0, width: view.frame.width, height: 100)
        
        #if true
        uimath = MTMathUILabel()
        view.addSubview(uimath)
        uimath.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height-100)
        #endif

        test227()
        
       // testSchizophrenic()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = .white
        super.viewDidAppear(animated)
    }
    
    private func test227() {
        let t = RationalApproxTester(.pi)
        let n = BigUInt(355) // BigUInt(355)
        let special = t.isSpecial(n: n, cancel: nil)
        let latex = t.getLatex(n: n)
        print(latex)
        uimath.latex = latex
    }

    
    
}
