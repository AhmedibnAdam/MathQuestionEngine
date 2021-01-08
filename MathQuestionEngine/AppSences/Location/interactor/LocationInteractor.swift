//
//  LocationInteractor.swift
//  MathQuestionEngine
//
//  Created by Adam on 08/01/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ILocationInteractor: class {
	var parameters: [String: Any]? { get set }
}

class LocationInteractor: ILocationInteractor {
    var presenter: ILocationPresenter?
    var worker: ILocationWorker?
    var parameters: [String: Any]?

    init(presenter: ILocationPresenter, worker: ILocationWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
