//
//  searchRestVC.swift
//  EatWithFriends
//
//  Created by 徐 翰洋 on 10/12/2017.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit

protocol SearchRestViewControllerDelegate {
    func appendRestSelected(restList : [Restaurant])
}

class SearchRestVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var restList: [Restaurant]?
    var delegate: SearchRestViewControllerDelegate?
    
    var restListString: [String]?
    var restSelected = [String]()
    
    var isSearching = false
    var fileredList = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finish(_ sender: Any) {
        self.delegate?.appendRestSelected(restList: stringListToRestList(stringList: restSelected))
        dismiss(animated: true, completion: nil)
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return fileredList.count
        }
        return restList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { 
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestCell", for: indexPath) as? RestaurantCell else {
            fatalError("The de-queued cell is not an instance of FoodCell.")
        }
        cell.label.adjustsFontSizeToFitWidth = true
        if isSearching {
            cell.label.text = fileredList[indexPath.row]
        } else {
            cell.label.text = restListString![indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let currentCell = tableView.cellForRow(at: indexPath) as! RestaurantCell
            if !restSelected.contains(currentCell.label.text!) {
                restSelected.append(currentCell.label.text!)
            }
            
            
            
            currentCell.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
        } else {
            isSearching = true
            fileredList = restListString!.filter({$0 == searchBar.text})
        }
        tableView.reloadData()
    }
    
    private func restListToStringList(restList: [Restaurant]) -> [String] {
        var result = [String]()
        for rest in restList {
            result.append(rest.name)
        }
        return result
    }
    
    private func stringListToRestList(stringList: [String]) -> [Restaurant] {
        var result = [Restaurant]()
        for restString in restSelected {
            for rest in restList! {
                if (restString == rest.name) {
                    result.append(rest)
                }
            }
        }
        return result
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        restListString = restListToStringList(restList: restList!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
