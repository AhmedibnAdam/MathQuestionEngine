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
    var selectedTimeArr = [Double]()
    var responseArrange = [Int]()
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
                        ((interactor?.getOperatorPrecedence(paramOperator: sender.currentTitle!))! > (interactor?.getOperatorPrecedence(paramOperator: operators.last!))!)
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
        
        var operators = operators
        guard let result : Float = interactor?.evaluateExpression(operators: operators, operands: operands, time: selectedTime) else {
            return
        }
        
        if (result.isInfinite || result.isNaN) {
            handleError(result: result)
        } else {
            if (floor(result) == result) {
                //                resultDisplayField.text = String(Int(result))
            } else {
                //                resultDisplayField.text = String(result)
            }
        }
    }
    
    
    @IBAction func onEqualsButtonClicked(_ sender: UIButton) {
        if (operators.isEmpty) {
            return
        }
        operands.append(currentOperand)
        
        fullEquation.append(currentOperand)
        equations.append(fullEquation)
        fullEquation = ""
        calculateOperation(operands: operands , operators: operators, fullEquation: fullEquation)
        resetData()
        reloadTable()
    }
    
    
    fileprivate func calculateOperation(operands: [String] , operators:[String] , fullEquation: String) {
        //MARK:- background scheduled tasks.
        var operators = operators
        let when = DispatchTime.now() + selectedTime
        DispatchQueue.main.asyncAfter(deadline: when) { [self] in
            if let result : Float = interactor?.evaluateExpression(operators: operators, operands: operands, time: selectedTime)  {
                
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
                DispatchQueue.main.async { [self] in
                    reloadTable()
                }
                
            }
            wasLastButtonClickedAnOperator = true
            resetData ()
        }
    }
    
    @IBAction func onResetButtonClicked(_ sender: UIButton) {
        resultDisplayField.text = "0"
        resetData()
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
    }
}
