//
//  ViewController.swift
//  Calculator
//
//  Created by Richard Hsu on 4/3/16.
//  Copyright (c) 2016 Richard Hsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    // ! vs. ?
    // usage - implicitly unwrapped
    
    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTypingNumber: Bool = false
    
    // need to create a calculatorBrain
    var brain = CalculatorBrain()
    
    
    @IBAction func appendDigit(sender: UIButton) {
        
        // unwrap the optional with !
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingNumber
        {
            display.text = display.text! + digit
        }
            
        // reset the whole disply without 0
        else
        {
            display.text = digit
            userIsInTheMiddleOfTypingNumber = true
        }
        
        // optional: unset (nil), and value
        // type: What type is it set to? - optional String. 
        // optional that can be a string
        //print("digit = \(digit)")
        

        
    }
    
    
    
    @IBAction func operate(sender: UIButton) {
        
        // figure out which operation was sent
        //let operation = sender.currentTitle!
        
        
        if userIsInTheMiddleOfTypingNumber
        {
            enter()
        }
        
        // switch on the string
        if let operation = sender.currentTitle
        {
//            switch operation
//            {
//                // calling the multiply function
//                case "*": performOperation { $0 * $1 }
//                case "/": performOperation { $1 / $0 }
//                case "+": performOperation { $0 + $1 }
//                case "-": performOperation { $1 - $0 }
//                
//                // need a functon that takes 1 argument
//                case "SQRT": performOperationSingle{ sqrt($0) }
//                    
//                default: break
//                
//            }
            
            if let result = brain.performOperation(operation)
            {
                displayValue = result
            }
            else
            {
                displayValue = 0
            }
        }
    }
    
    // takes a Function that takes two doubles and returns a double
//    func performOperation(operation: (Double, Double) -> Double)
//    {
//        if operandStack.count >= 2
//        {
//            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
//            enter()
//        }
//    }

//        func performOperationSingle(operation: Double -> Double)
//        {
//            // check that there's only one element on the stack
//            if operandStack.count >= 1
//            {
//                displayValue = operation(operandStack.removeLast())
//                enter()
//            }
//        }

    
    
    // need stack for different values
    // () is an initial value of an empty array
    
    // putting a type can be omitted - it is inferred
    //var operandStack: Array<Double> = Array<Double>()
    //var operandStack = Array<Double>()
    
    
    @IBAction func enter() {
        // once user hits enter, he or she is no longer entering numbers
        userIsInTheMiddleOfTypingNumber = false
        
        // need to convert optional String to a Double
        //operandStack.append(displayValue)
        //print("operandStack = \(operandStack)", terminator: "")
        
        
        // NEED TO PUSH OPERAND ONTO STACK
        //brain.pushOperand(displayValue)
        
        // UPDATE DISPLAY
        if let result = brain.pushOperand(displayValue)
        {
            displayValue = result
        }
            
        // what if it's nil
        // displayValue returned an optional
        else
        {
            displayValue = 0
        }
        
    }
    
    // make a computed property
    var displayValue: Double
    {
        get
        {
           return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set
        {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingNumber = false
        }
    }
}

