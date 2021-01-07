//
//  ViewController.swift
//  MathQuestionEngine
//
//  Created by Adam on 03/01/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // Change
            self.navigate(type: .modal, module: ModulesRoute.calculations, completion: nil)
        }
        
    }


}

