//
//  LocationRouter.swift
//  MathQuestionEngine
//
//  Created by Adam on 08/01/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ILocationRouter: class {
	// do someting...
}

class LocationRouter: ILocationRouter {	
	weak var view: LocationViewController?
	
	init(view: LocationViewController?) {
		self.view = view
	}
}
