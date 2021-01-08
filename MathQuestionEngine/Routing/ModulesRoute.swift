//
//  ModulesRoute.swift
//  MathQuestionEngine
//
//  Created by Adam on 07/01/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam/

import Foundation
import UIKit

enum ModulesRoute: IRouter {

    case calculations
    case location
}

extension ModulesRoute {
    var module: UIViewController? {
     
         switch self {
         case .calculations:
            return CalculationsConfiguration.setup()
         case .location:
            return LocationConfiguration.setup()
         }
         
        
    }
}
