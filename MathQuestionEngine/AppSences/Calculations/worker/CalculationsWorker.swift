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
}

class CalculationsWorker: ICalculationsWorker {
    
    
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
}
