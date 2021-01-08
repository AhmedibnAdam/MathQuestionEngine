//
//  CalculationsViewController.swift
//  MathQuestionEngine
//
//  Created by Adam on 07/01/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ICalculationsViewController: class {
    var router: ICalculationsRouter? { get set }
    func showResult(result: Float)
}

class CalculationsViewController: UIViewController {
    var interactor: ICalculationsInteractor?
    var router: ICalculationsRouter?
    
    //MARK:- Outlets
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var resultDisplayField: UILabel!
    
    var equationArr = [String]()
    var fullEquation = ""
    //MARK:- variables
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    var list = ["5", "10", "15" , "20" ,"25", "30"]
    var selectedTime = 0.0
    var isInInitialState = true
    var wasLastButtonClickedAnOperator = false
    var currentOperator : Int!
    var currentOperand : String = "0"
    var operands = [String]()
    var operators = [String]()
    var equations = [String]()
    var results = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableCell()
    }
    //MARK:- Actions
    @IBAction func onNumberClicked(_ sender: UIButton) {
        
        if (isInInitialState) {
            if (sender.currentTitle == "0") {
                return
            }
            if (resultDisplayField.text == "-") {
                currentOperand = (resultDisplayField.text?.appending(sender.currentTitle!))!
            } else {
                currentOperand = sender.currentTitle!
            }
            isInInitialState = false
            resultDisplayField.text = currentOperand
            
        } else {
            if (sender.currentTitle == "0" && resultDisplayField.text == "0") {
                return
            }
            if (wasLastButtonClickedAnOperator) {
                currentOperand = sender.currentTitle!
            } else {
                currentOperand = (resultDisplayField.text?.appending(sender.currentTitle!))!
            }
            resultDisplayField.text = currentOperand
        }
        wasLastButtonClickedAnOperator = false
    }
    
    @IBAction func onOperatorClicked(_ sender: UIButton) {
        if (wasLastButtonClickedAnOperator) {
            if (sender.currentTitle! == "-") {
                currentOperand = "0"
                currentOperand = "-".appending(currentOperand)
                resultDisplayField.text = "-"
                wasLastButtonClickedAnOperator = false
            } else if (operators.count > 0) {
                operators[operators.count - 1] = sender.currentTitle!
            }
        } else {
            if (sender.currentTitle == "-" && currentOperand == "0") {
                currentOperand = "-".appending(currentOperand)
                resultDisplayField.text = "-"
                wasLastButtonClickedAnOperator = false
            } else {
                operands.append(currentOperand)
                fullEquation.append(currentOperand)
                if (operands.count > 1) {
                    let isCurrentOperatorOfHigherPrecedence : Bool =
                        ((getOperatorPrecedence(paramOperator: sender.currentTitle!)) > (getOperatorPrecedence(paramOperator: operators.last!)))
                    if (!isCurrentOperatorOfHigherPrecedence) {
                        caluclatNotHigherPrec(operands: operands , operators: operators, fullEquation: fullEquation)
                    }
                }
                operators.append(sender.currentTitle!)
                fullEquation.append(sender.currentTitle!)
                resetCurrentOperandToZero()
                wasLastButtonClickedAnOperator = true
            }
        }
    }
    
    func caluclatNotHigherPrec(operands: [String] , operators:[String] , fullEquation: String){
        interactor?.calculateOperation(operands: operands , operators: operators, fullEquation: fullEquation, time: selectedTime)
        
    }
    
    @IBAction func showLocation(_ sender: UIButton) {
        router?.showLocation()
    }
    @IBAction func onEqualsButtonClicked(_ sender: UIButton) {
        if (operators.isEmpty) {
            return
        }
        operands.append(currentOperand)
        fullEquation.append(currentOperand)
        equations.append(fullEquation)
        fullEquation = ""
        

        interactor?.calculateOperation(operands: operands , operators: operators, fullEquation: fullEquation, time: selectedTime)
        resetData()
        reloadTable()
    }
    
    @IBAction func onResetButtonClicked(_ sender: UIButton) {
        resultDisplayField.text = "0"
        resetData()
    }
    
    func getOperatorPrecedence(paramOperator: String) -> Int {
        switch paramOperator {
        case "-":
            return 1
        case "+":
            return 2
        case "x":
            return 3
        case "/":
            return 4
        default:
            print(" unknown operator  " )
            return -1
        }
    }

    func handleError(result: Float) {
        if (result.isInfinite) {
            resultDisplayField.text = "Infinity"
        } else if (result.isNaN) {
            resultDisplayField.text = "Bad Expression"
        }
        resetData()
    }
    
    func resetData () {
        isInInitialState = true
        resetCurrentOperandToZero()
        operators.removeAll()
        operands.removeAll()
    }
    
    func resetCurrentOperandToZero() {
        currentOperand = "0"
    }
    
    fileprivate func reloadTable() {
        self.tableView.reloadData()
        self.tableView.isHidden = false
        self.resultTableView.reloadData()
        self.resultTableView.isHidden = false
    }
}

extension CalculationsViewController: ICalculationsViewController {
    func showResult(result: Float) {
        print(result)
        if (result.isInfinite || result.isNaN) {
            handleError(result: result)
        } else {
            if (floor(result) == result) {
                resultDisplayField.text = String(Int(result))
            } else {
                resultDisplayField.text = String(result)
            }
            self.operands.removeAll()
            self.operands.append(String(result))
            results.append(String(result))
            reloadTable()
            if (operators.count > 1) {
                operators.removeSubrange(Range(0...(operators.count - 2)))
            }
        }
        wasLastButtonClickedAnOperator = true
        resetData ()
        DispatchQueue.main.async { [self] in
            reloadTable()
        }
    }
}
