//
//  SearchFriendVC.swift
//  EatWithFriends
//
//  Created by ​ on 12/4/17.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit

class SearchFriendsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var isSearching = false
    var fileredList = [String]()
    
    var friendList: [User]?
    var friendNameList = [String]()
    private func getNames(users: [User]) {
        friendNameList = [String]()
        for user in users {
            friendNameList.append(user.name)
        }
    }
    
    var addedFriend = [User]()
    var addedFriendName = [String]()
    private func findFriendObjectByName(nameList: [String]) {
        for name in nameList {
            for user in friendList! {
                if name == user.name {
                    addedFriend.append(user)
                }
            }
        }
    }
    
    @IBAction func goBackToMain(_ sender: Any) {
        performSegue(withIdentifier: "unwindFromFriendVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        findFriendObjectByName(nameList: addedFriendName)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return fileredList.count
        }
        return friendNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchFriendsCell else {
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
            if !addedFriendName.contains(friendNameList[indexPath.row]) {
                addedFriendName.append(friendNameList[indexPath.row])
            }
            let currentCell = tableView.cellForRow(at: indexPath) as! SearchFriendsCell
            currentCell.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
        } else {
            isSearching = true
            fileredList = friendNameList.filter({$0 == searchBar.text})
        }
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //generateWordsDict()
        getNames(users: friendList!)
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
