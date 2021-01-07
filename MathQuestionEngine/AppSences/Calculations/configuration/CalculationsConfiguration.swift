//
//  CalculationsConfiguration.swift
//  MathQuestionEngine
//
//  Created by Adam on 07/01/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class CalculationsConfiguration {
    static func setup(parameters: [String: String] = [:]) -> UIViewController {
        let controller = CalculationsViewController()
        let router = CalculationsRouter(view: controller)
        let presenter = CalculationsPresenter(view: controller)
        let worker = CalculationsWorker()
        let interactor = CalculationsInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
