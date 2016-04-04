//
//  ViewController.swift
//  Calculator
//
//  Created by Richard Hsu on 4/3/16.
//  Copyright (c) 2016 Richard Hsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTypingNumber: Bool = false
    
    
    @IBAction func appendDigit(sender: UIButton) {
        
        // unwrap the optional with !
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingNumber
        {
            display.text = display.text! + digit
        }
        else
        {
            display.text = digit
            userIsInTheMiddleOfTypingNumber = true
        }
        
        // optional: unset (nil), and value
        // type: What type is it set to? - optional String. 
        // optional that can be a string
        print("digit = \(digit)")
        

        
    }
    
    

}

