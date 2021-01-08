//
//  CalculationsWorker.swift
//  MathQuestionEngine
//
//  Created by Adam on 07/01/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol ICalculationsWorker: class {
    func evaluateStatement(selectedOperator: Int, firstOperand: Float, secondOperand: Float) -> Float
    func checkPrecedenceOrder(_ tempOperatorsArray: [String], _ operatorIndexInArray: inout Int?) -> Int
    func evaluateExpression(operators: [String], operands: [String], time: Double)-> Float 
}

class CalculationsWorker: ICalculationsWorker {
    
    var currentOperator : Int!
    func evaluateStatement(selectedOperator: Int, firstOperand: Float, secondOperand: Float) -> Float {
        switch selectedOperator {
        case 4:
            return firstOperand / secondOperand
        case 3:
            return firstOperand * secondOperand
        case 2:
            return firstOperand + secondOperand
        case 1:
            return firstOperand - secondOperand
        default:
            print("Unknown operator : " + String(selectedOperator))
            return .nan
        }
    }
    func checkPrecedenceOrder(_ tempOperatorsArray: [String], _ operatorIndexInArray: inout Int?) -> Int {
        if (tempOperatorsArray.firstIndex(of: "/") != nil) {
            operatorIndexInArray = tempOperatorsArray.firstIndex(of: "/")!
            return 4
        }
        else if (tempOperatorsArray.firstIndex(of: "x") != nil) {
            operatorIndexInArray = tempOperatorsArray.firstIndex(of: "x")!
            return 3
        }
        else if (tempOperatorsArray.firstIndex(of: "+") != nil) {
            operatorIndexInArray = tempOperatorsArray.firstIndex(of: "+")!
            return 2
        }
        else if (tempOperatorsArray.firstIndex(of: "-") != nil) {
            operatorIndexInArray = tempOperatorsArray.firstIndex(of: "-")!
            return 1
        }
        return -1
    }
    
    func evaluateExpression(operators: [String], operands: [String], time: Double)-> Float  {
        var firstOperand : Float
        var secondOperand : Float
        var result : Float
        var operatorIndexInArray : Int!
        var tempOperatorsArray = operators
        var tempOperandsArray = operands
        currentOperator = checkPrecedenceOrder(tempOperatorsArray, &operatorIndexInArray)
        firstOperand = Float(tempOperandsArray[operatorIndexInArray])!
        secondOperand = Float(tempOperandsArray[operatorIndexInArray + 1])!
        result = (evaluateStatement(selectedOperator: currentOperator, firstOperand: firstOperand, secondOperand: secondOperand))
        if (result.isInfinite || result.isNaN) {
            return result
        }
        if (tempOperandsArray.count >= 2) {
            tempOperatorsArray.remove(at: operatorIndexInArray)
            tempOperandsArray.replaceSubrange(Range(operatorIndexInArray...operatorIndexInArray.advanced(by: 1)), with: [String(result)])
        }
        if (tempOperandsArray.count >= 2) {
            result = evaluateExpression(operators: tempOperatorsArray, operands: tempOperandsArray, time: time)
        }
        return   result
    }
}
