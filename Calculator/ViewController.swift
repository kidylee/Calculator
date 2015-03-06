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
    
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            if (digit == ".") && (display.text!.rangeOfString(".") != nil) { return }
            display.text = display.text! + digit
        }else{
            if (digit == ".") {
                display.text =  "0\(digit)"
            }else{
                display.text =  digit
            }
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation){
                displayValue = result
                history.text = "\(history.text!) = "
            } else {
                displayValue = 0
            }
        }
    }
    
    
    @IBAction func enter() {
        
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue!){
            displayValue = result
        }else{
            displayValue = 0
        }
    }
    
    @IBAction func clear() {
        brain = CalculatorBrain()
        displayValue = 0
        
    }

    
    @IBAction func delete() {
      let text = display.text!
        if countElements(text) > 1 {
            display.text = dropLast(text)
        }else{
            userIsInTheMiddleOfTypingANumber = false
            display.text = "0"
        }
    }
    
    @IBAction func switchSign(sender: UIButton) {
        let text = display.text!
        if userIsInTheMiddleOfTypingANumber {
            var signed = String(format: "%.0f", -displayValue!)
            display.text = "\(signed)"
        }else{
            
        }
    }
    
    var displayValue: Double? {
        get{
            if let numberValue = NSNumberFormatter().numberFromString(display.text!){
                    return numberValue.doubleValue
            }
            return nil
            
        }
        
        set{
            if let value = newValue  {
                let value = String(format:"%.0f", value)
                display.text = "\(value)"
            }else{
                display.text = "0"
            }
            history.text = brain.description

            userIsInTheMiddleOfTypingANumber = false

        }
    }

    
}

