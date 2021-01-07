//
//  CalculationsPresenter.swift
//  MathQuestionEngine
//
//  Created by Adam on 07/01/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ICalculationsPresenter: class {
    func showResult(result: Float)
}

class CalculationsPresenter: ICalculationsPresenter {

	weak var view: ICalculationsViewController?
	
	init(view: ICalculationsViewController?) {
		self.view = view
	}
    func showResult(result: Float) {
        view?.showResult(result: result)
    }
    
}
