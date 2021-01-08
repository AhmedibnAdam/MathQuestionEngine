//
//  LocationPresenter.swift
//  MathQuestionEngine
//
//  Created by Adam on 08/01/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ILocationPresenter: class {
	// do someting...
}

class LocationPresenter: ILocationPresenter {	
	weak var view: ILocationViewController?
	
	init(view: ILocationViewController?) {
		self.view = view
	}
}
