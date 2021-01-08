//
//  LocationConfiguration.swift
//  MathQuestionEngine
//
//  Created by Adam on 08/01/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class LocationConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = LocationViewController()
        let router = LocationRouter(view: controller)
        let presenter = LocationPresenter(view: controller)
        let worker = LocationWorker()
        let interactor = LocationInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
