//
//  FriendsVC.swift
//  EatWithFriends
//
//  Created by ​ on 12/4/17.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit

class FriendsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate, UISearchBarDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var tbvc: tabBarController?
    var isSearching = false
    var fileredList = [String]()
    var friendNameList = [String]()

    var userSelf: SelfMode?
    var selectedRow: Int?
    var friends: [User]?
    
    @IBAction func AddFriend(_ sender: UIButton) {
        let score = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newfriendvc") as! AddFriendViewController
        score.modalPresentationStyle = .popover
        score.userSelf = self.userSelf
        score.friendVC = self
        if let pop = score.popoverPresentationController {
            pop.delegate = self
            pop.permittedArrowDirections = .up
            pop.sourceView = sender
            pop.sourceRect = sender.frame
        }
        self.present(score, animated: true) { }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    func reloadData() {
        self.friendNameList = []
        getNames(users: self.friends!)
        tbvc?.userSelf = self.userSelf!
        tableView.reloadData()
    }
    
    // Not implemented yet
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return fileredList.count
        }
        return friendNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as? FriendsCell else {
            fatalError("The de-queued cell is not an instance of SearchFriendCell.")
        }
        cell.name.adjustsFontSizeToFitWidth = true
        if isSearching {
            cell.name.text = fileredList[indexPath.row]
        } else {
            cell.name.text = friendNameList[indexPath.row]
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            // selectedRow = indexPath.row
            let currentCell = tableView.cellForRow(at: indexPath) as! FriendsCell
            let score = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "fpvc") as! FriendPersonalVC
            score.modalPresentationStyle = .popover
            score.friendSelf = findFriendByName(name: currentCell.name.text!)
            if let pop = score.popoverPresentationController {
                pop.delegate = self
                pop.permittedArrowDirections = .up
                pop.sourceView = currentCell
                pop.sourceRect = currentCell.bounds
            }
            self.present(score, animated: true) { }
        }
    }
    
    private func findFriendByName(name: String) -> User {
        for friend in self.friends! {
            if (friend.name == name) {
                return friend
            }
        }
        return User(name: "false", id: "", email: "", foodLiked: [], foodHated: [], restLiked: [], restHated: [], friends: [])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text == nil || searchBar.text == "") {
            isSearching = false
            view.endEditing(true)
        } else {
            isSearching = true
            fileredList = friendNameList.filter({$0.starts(with: searchText)})
        }
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tbvc = tabBarController as! tabBarController
        self.userSelf = tbvc?.userSelf
        self.friends = self.userSelf?.fetchedFriend
        getNames(users: self.friends!)
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        // Do any additional setup after loading the view.
    }
    
    private func getNames(users: [User]) {
        for user in users {
            friendNameList.append(user.name)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
