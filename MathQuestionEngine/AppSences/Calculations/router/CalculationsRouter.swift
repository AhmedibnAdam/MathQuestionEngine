//
//  CalculationsRouter.swift
//  MathQuestionEngine
//
//  Created by Adam on 07/01/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ICalculationsRouter: class {
	// do someting...
}

class CalculationsRouter: ICalculationsRouter {	
	weak var view: CalculationsViewController?
	
	init(view: CalculationsViewController?) {
		self.view = view
	}
}
