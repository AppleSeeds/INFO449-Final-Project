//
//  SelectionVC.swift
//  EatWithFriends
//
//  Created by ​ on 12/3/17.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit
import Foundation

class SelectionVC: UIViewController, UITableViewDelegate, UITableViewDataSource,  UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [["Search for Friends", "Add a non-user"], []]
    let titles = ["Add a Friend", "Added Friend"]
    var userSelf: SelfMode?
    
    var addedFriend = [User]()
    var fetchedFriend = [User]()
    
    var backEndFirstName = LoginViewController.GlobalVariable.myFirstName
    var backEndLastName = LoginViewController.GlobalVariable.myLastName
    var backEndId = LoginViewController.GlobalVariable.myUserId
    
    var foodLiked = [String]()
    var foodHated = [String]()
    var restLiked = [String]()
    var restHated = [String]()
    
    var restList = [Restaurant]()
    
    // Append friend to addedFriend list
    @IBAction func unwindFromAddDummyVC(segue: UIStoryboardSegue) {
        let senderVC = segue.source as? DummyVC
        if (senderVC?.addedFriend != nil) {
            addedFriend.append((senderVC?.addedFriend)!)
            data[1] = getNameList(userList: addedFriend)
        }
        tableView.reloadData()
    }
    
    @IBAction func unwindFromSearchFriendVC(segue: UIStoryboardSegue) {
        let senderVC = segue.source as? SearchFriendsVC
        if (senderVC?.addedFriend != nil) {
            for friend in (senderVC?.addedFriend)! {
                if (!isAddedFriend(name: friend.name)) {
                    self.addedFriend.append(friend)
                }
            }
        }
        data[1] = getNameList(userList: addedFriend)
        tableView.reloadData()
    }
    
    private func isAddedFriend(name: String) -> Bool {
        for friend in addedFriend {
            if friend.name == name {
                return true
            }
        }
        return false
    }
    
    // Get all names from the user list
    private func getNameList(userList: [User]) -> [String] {
        var result = [String]()
        for user in userList {
            result.append(user.name)
        }
        return result
    }
    
    // Table View Configureation
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectionCell", for: indexPath) as? SelectionCell else {
                fatalError("The de-queued cell is not an instance of SelectionCell.")
            }
            cell.label.adjustsFontSizeToFitWidth = true
            cell.label.text = data[indexPath.section][indexPath.row]
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedFriendsCell", for: indexPath) as? SelectedFriendsCell else {
                fatalError("The de-queued cell is not an instance of SelectedFriendsCell.")
            }
            cell.name.adjustsFontSizeToFitWidth = true
            cell.name.text = data[indexPath.section][indexPath.row]
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < titles.count {
            return titles[section]
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            // let selectedCell = tableView.cellForRow(at: indexPath)
            // let selectedCellRect = selectedCell?.bounds
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    self.performSegue(withIdentifier: "toAddFriend", sender: nil)
                } else if indexPath.row == 1 {
                    self.performSegue(withIdentifier: "toAddDummy", sender: nil)
                }
            }
        }
    } 

    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? SearchFriendsVC {
            destinationViewController.friendList = self.fetchedFriend
        }
    }
    
    // Get request to server to get all his friend
    func fetchAllFriends(){        
        userSelf = SelfMode()
        let globelSelf = self.tabBarController as! tabBarController
        globelSelf.userSelf = self.userSelf
        self.fetchedFriend = (self.userSelf?.getFetchedFriend())!
        self.foodLiked = (self.userSelf?.getFoodLiked())!
        self.foodHated = (self.userSelf?.getFoodHated())!
        self.restLiked = (self.userSelf?.getRestLiked())!
        self.restHated = (self.userSelf?.getRestHated())!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllFriends()
        //userSelf?.makePostRequest(url: "https://info449.com/users-info449")
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
