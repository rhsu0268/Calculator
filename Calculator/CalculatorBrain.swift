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
    
    
    // specify operation
    func performOperation(symbol: String) -> Double?
    {
        // look up symbol
        // type of operation: Optional - possible that it's not there - look up something in dictionary - always optinoal
        if let operation = knownOps[symbol]
        {
            opStack.append(operation)
        }
        return evaluate()
    }
    
    // evaluate the stack - Return a result and tuple
    // implicit let in all things that you pass - readonly array can't be mutated
    // if we use var, we have a mutable array. It's still a copy. 
    //
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op])
    {
        // removes last thing from array
        // ops is immutable - you cannot change it
        // why. when you pass arguments into functions, unless it's a class, the thing you pass is copied
        // pass by value
        // arrays and dictionary are not classes. They are structs. 
        // classes vs. structs
        // structs are passed by value. Classes are passed by reference
        // Structs are used for basic components.
        if !ops.isEmpty
        {
            
            // we will create variable for ops - copies it
            // mutable since it is var
            var remainingOps = ops
            let op = remainingOps.removeLast()
            // get the value
            // pull values out of enums
        
            switch op
            {
                // inside the case, operand will have the associated value
                case .Operand(let operand):
                    return (operand, remainingOps)
                
                // _ - I don't care about this
                case .UnaryOperation(_, let operation):
                    
                    // get the operand
                    let operandEvaluation = evaluate(remainingOps)
                    
                    // get the operand out
                    if let operand = operandEvaluation.result
                    {
                        return (operation(operand), operandEvaluation.remainingOps)
                    }
                
                case .BinaryOperation(_, let operation):
                
                    let op1Evaluation = evaluate(remainingOps)
                    if let operand1 = op1Evaluation.result
                    {
                        let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                        if let operand2 = op2Evaluation.result
                        {
                            return (operation(operand1, operand2), op2Evaluation.remainingOps)
                        }
                    }
            }
        }
        return (nil, ops)
    }
    
    // call the function
    func evaluate() -> Double?
    {
        // let a tuple equal the result
        let (result, _) = evaluate(opStack)
        return result
    
    }
    
    // how do we put things into Op
    // put an operand on it and operation
    func pushOperand(operand: Double) -> Double?
    {
        // create enum to put it on
        opStack.append(Op.Operand(operand))
        
        return evaluate()
    }

    

}