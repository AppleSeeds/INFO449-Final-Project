//
//  SearchFoodVC.swift
//  EatWithFriends
//
//  Created by 徐 翰洋 on 10/12/2017.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit

protocol SearchFoodViewControllerDelegate {
    func appendFoodSelected(foodList : [String])
}

class SearchFoodVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let foodList = ["f1", "f2", "f3"]
    var foodSelected = [String]()
    var delegate: SearchFoodViewControllerDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func finish(_ sender: Any) {
        self.delegate?.appendFoodSelected(foodList: foodSelected)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as? FoodCell else {
            fatalError("The de-queued cell is not an instance of FoodCell.")
        }
        cell.foodName.adjustsFontSizeToFitWidth = true
        cell.foodName.text = foodList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            if !foodSelected.contains(foodList[indexPath.row]) {
                foodSelected.append(foodList[indexPath.row])
            }
            let currentCell = tableView.cellForRow(at: indexPath) as! FoodCell
            currentCell.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        }
    }
    
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
