//
//  ViewController.swift
//  Calculator
//
//  Created by Li An on 2/22/15.
//  Copyright (c) 2015 LA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false


    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            display.text = display.text! + digit
        }else{
            display.text =  digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
}

