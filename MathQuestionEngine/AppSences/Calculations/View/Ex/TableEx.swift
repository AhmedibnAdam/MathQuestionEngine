//
//  PickerEx.swift
//  MathQuestionEngine
//
//  Created by Adam on 07/01/2021.
//

import UIKit

extension CalculationsViewController: UITableViewDelegate , UITableViewDataSource {
    
    func registerTableCell() {
        let cell = UINib(nibName: "EqautonsTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "EqautonsTableViewCell")
        resultTableView.register(cell, forCellReuseIdentifier: "EqautonsTableViewCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == resultTableView {
           return results.count
        }
        else {
        return equations.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EqautonsTableViewCell") as! EqautonsTableViewCell
        
        
        if tableView == resultTableView {
            cell.textLabel?.text =   results[indexPath.row]
        }
        else {
            cell.textLabel?.text = equations[indexPath.row]
        }
       
        return cell
    }
}
