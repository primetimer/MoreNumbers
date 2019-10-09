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
        
        view.backgroundColor = .blue
        
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

        
        testSchizophrenic()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = .blue
        super.viewDidAppear(animated)
    }
    
    
}
