//
//  FriendPersonalVC.swift
//  EatWithFriends
//
//  Created by 徐 翰洋 on 13/12/2017.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit

class FriendPersonalVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var data = [["Name:"], ["Add the food you love", "Add the food you hate", "Add the restaurent you love", "Add the restaurent you hate"]]
    let titles = ["Add Information", "Add Preference"]
    var name: String?
    var foodLiked = [String]()
    var foodHated = [String]()
    var restLiked = [Restaurant]()
    var restHated = [Restaurant]()
    
    var friendSelf: User?
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendinfocell", for: indexPath) as? FriendInfoCell else {
                fatalError("The de-queued cell is not an instance of InfoCell.")
            }
            cell.name.adjustsFontSizeToFitWidth = true
            cell.name.text = friendSelf?.name
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendprecell", for: indexPath) as? PrefCell else {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name = friendSelf?.name
        self.foodLiked = (friendSelf?.foodLiked)!
        self.foodHated = (friendSelf?.foodHated)!
        self.restLiked = (friendSelf?.restLiked)!
        self.restHated = (friendSelf?.restHated)!
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
