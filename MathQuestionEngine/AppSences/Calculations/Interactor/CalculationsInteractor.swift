//
//  CalculationsInteractor.swift
//  MathQuestionEngine
//
//  Created by Adam on 07/01/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ICalculationsInteractor: class {
    var parameters: [String: String]? { get set }
    
    func evaluateExpression(operators: [String], operands: [String], time: Double) -> Float
    func getOperatorPrecedence(paramOperator: String) -> Int
}

class CalculationsInteractor: ICalculationsInteractor {
    var presenter: ICalculationsPresenter?
    var worker: ICalculationsWorker?
    var parameters: [String: String]?
    var currentOperator : Int!
    
    init(presenter: ICalculationsPresenter, worker: ICalculationsWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func getOperatorPrecedence(paramOperator: String) -> Int {
        switch paramOperator {
        case "-":
            return 1
        case "+":
            return 2
        case "x":
            return 3
        case "/":
            return 4
        default:
            print(" unknown operator  " )
            return -1
        }
    }
    
    func evaluateExpression(operators: [String], operands: [String], time: Double) -> Float {
        var firstOperand : Float
        var secondOperand : Float
        var result : Float
        var operatorIndexInArray : Int!
        var tempOperatorsArray = operators
        var tempOperandsArray = operands
        
        checkPrecedenceOrder(tempOperatorsArray, &operatorIndexInArray)
        firstOperand = Float(tempOperandsArray[operatorIndexInArray])!
        secondOperand = Float(tempOperandsArray[operatorIndexInArray + 1])!
        
        result = (worker?.evaluateStatement(selectedOperator: currentOperator, firstOperand: firstOperand, secondOperand: secondOperand))!
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
        return result
    }
    
    func checkPrecedenceOrder(_ tempOperatorsArray: [String], _ operatorIndexInArray: inout Int?) {
        
        currentOperator =  worker?.checkPrecedenceOrder(tempOperatorsArray, &operatorIndexInArray)
    }
}




