//
//  DummyVC.swift
//  EatWithFriends
//
//  Created by ​ on 12/4/17.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit

class DummyVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate, SearchFoodViewControllerDelegate, SearchRestViewControllerDelegate {
    
    var data = [["Name:"], ["Add the food you love", "Add the food you hate", "Add the restaurent you love", "Add the restaurent you hate"]]
    let titles = ["Add Information", "Add Preference"]
    var foodLiked = [String]()
    var foodHated = [String]()
    var restLiked = [Restaurant]()
    var restHated = [Restaurant]()
    var prefRowSelected = -1
    
    var restList = [Restaurant]()
    
    var addedFriend: User!
    
    @IBOutlet weak var tableView: UITableView!
    
    // Update table to display added friend
    @IBAction func goBackToMain(_ sender: Any) {
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! InfoCell
        if (cell.textField.text != nil && cell.textField.text != "") {
            let user = User(name: cell.textField.text!, foodLiked: self.foodLiked, foodHated: self.foodHated, restLiked: self.restLiked, restHated: self.restHated)
            self.addedFriend = user // prepare the user struct to be added in selectionVC
        }
        
        if let destinationViewController = segue.destination as? SearchFoodVC {
            destinationViewController.delegate = self
        }
        
        if let destinationViewController = segue.destination as? SearchRestVC {
            destinationViewController.delegate = self
            destinationViewController.restList = self.restList
        }
    }
    
    // Append selected food preference
    func appendFoodSelected(foodList: [String]) {
        if (prefRowSelected == 0) {
            self.foodLiked = foodList
        } else if (prefRowSelected == 1) {
            self.foodHated = foodList
        }
        tableView.reloadData()
    }
    
    // Append selected restaurant preference
    func appendRestSelected(restList: [Restaurant]) {
        if (prefRowSelected == 2) {
            self.restLiked = restList
        } else if (prefRowSelected == 3) {
            self.restHated = restList
        }
        tableView.reloadData()
    }
    
    // Table display functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell else {
                fatalError("The de-queued cell is not an instance of InfoCell.")
            }
            cell.label.adjustsFontSizeToFitWidth = true
            cell.label.text = data[indexPath.section][indexPath.row]
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PrefCell", for: indexPath) as? PrefCell else {
                fatalError("The de-queued cell is not an instance of PrefCell.")
            }
            cell.label.adjustsFontSizeToFitWidth = true
            cell.label.text = data[indexPath.section][indexPath.row]
            if indexPath.section == 1 {
                if indexPath.row == 0 {
                    cell.itemList.text = String(stringListToString(stringList: foodLiked))
                } else if indexPath.row == 1 {
                    cell.itemList.text = String(stringListToString(stringList: foodHated))
                } else if indexPath.row == 2 {
                    cell.itemList.text = String(restListToString(restList: restLiked))
                } else if indexPath.row == 3 {
                    cell.itemList.text = String(restListToString(restList: restHated))
                }
            }
            return cell
        }
    }
    
    private func stringListToString(stringList: [String]) -> String{
        var result = ""
        for string in stringList {
            result += (string + " ")
        }
        return result
    }
    
    private func restListToString(restList: [Restaurant]) -> String{
        var result = ""
        for rest in restList {
            result += (rest.name + " ")
        }
        return result
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < titles.count {
            return titles[section]
        }
        return nil
    }

    // Popup configuration
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedCell = tableView.cellForRow(at: indexPath)
            let selectedCellRect = selectedCell?.bounds
            if indexPath.section == 1 {
                prefRowSelected = indexPath.row
                if (indexPath.row == 0 || indexPath.row == 1) {
                    let score = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "searchfoodvc") as! SearchFoodVC
                    score.modalPresentationStyle = .popover
                    score.delegate = self
                    if let pop = score.popoverPresentationController {
                        pop.delegate = self
                        pop.permittedArrowDirections = .up
                        pop.sourceView = selectedCell
                        pop.sourceRect = selectedCellRect!
                    }
                    self.present(score, animated: true) { }
                } else if (indexPath.row == 2 || indexPath.row == 3) {
                    let score = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "searchrestvc") as! SearchRestVC
                    score.modalPresentationStyle = .popover
                    score.delegate = self
                    if let pop = score.popoverPresentationController {
                        pop.permittedArrowDirections = .down
                        pop.delegate = self
                        pop.sourceView = selectedCell
                        pop.sourceRect = selectedCellRect!
                    }
                    self.present(score, animated: true) { }
                }
            }
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    // Standard Configuration
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
