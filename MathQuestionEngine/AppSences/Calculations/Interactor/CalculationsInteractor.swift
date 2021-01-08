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
    func calculateOperation(operands: [String] , operators:[String] , fullEquation: String, time: Double)
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

    //MARK:- background scheduled tasks.
     func calculateOperation(operands: [String] , operators:[String] , fullEquation: String, time: Double) {

        let when = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: when) { [self] in
            if let result : Float =  worker?.evaluateExpression(operators: operators, operands: operands, time: time)  {
                presenter?.showResult(result: result)
            }
        }
    }
}




