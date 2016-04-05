//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Richard Hsu on 4/5/16.
//  Copyright (c) 2016 Richard Hsu. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    // need to catch operands
    // Op = operand or operation
    // var opStack = [Op]()
    
    
    // create an enum
    private enum Op
    {
        // can have functions
        // can only have computed properties
        // one thing one time and another thing another time
        
        // need the actual operand - associate data with any of the cases in the enum
        case Operand(Double)
        
        // string and Function
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }
    private var opStack = Array<Op>()
    
    
    // known operations
    // dictionary - Key - String and Value - Op
    // perform operation - Look it up in knownOps
    // same declaration
    // var knownOps = [String:Op]()
    private var knownOps =  Dictionary<String, Op>()
    
    // need to initalize knownOps 
    // we will use an initializer
    // curly brace is a function that takes one argument and returns one argument
    // types are inferred
    // another function that takes a double and returns a double
    init()
    {
        knownOps["*"] = Op.BinaryOperation("*") {$0 * $1}
        knownOps["/"] = Op.BinaryOperation("/") {$1 / $0}
        knownOps["+"] = Op.BinaryOperation("+") {$0 + $1}
        knownOps["-"] = Op.BinaryOperation("-") {$1 - $0}
        // knownOps["SQRT"] = Op.UnaryOperation("SQRT") { sqrt }
        knownOps["SQRT"] = Op.UnaryOperation("SQRT") { sqrt($0) }
    }
    
    // how do we put things into Op
    // put an operand on it and operation 
    func pushOperand(operand: Double)
    {
        // create enum to put it on
        opStack.append(Op.Operand(operand))
    }
    
    // specify operation
    func performOperation(symbol: String)
    {
        // look up symbol
        // type of operation: Optional - possible that it's not there - look up something in dictionary - always optinoal
        if let operation = knownOps[symbol]
        {
            opStack.append(operation)
        }
    }
    

}