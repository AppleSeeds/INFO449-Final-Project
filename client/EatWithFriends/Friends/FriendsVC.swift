//
//  FriendsVC.swift
//  EatWithFriends
//
//  Created by ​ on 12/4/17.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit

class FriendsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var userSelf: SelfMode?
    var selectedRow = -1
    var friends: [User]?
    
    @IBAction func AddFriend(_ sender: UIButton) {
        let score = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newfriendvc") as! AddFriendViewController
        score.modalPresentationStyle = .popover
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
    
    // Not implemented yet
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as? FriendsCell else {
            fatalError("The de-queued cell is not an instance of FriendsCell.")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            selectedRow = indexPath.row
            self.performSegue(withIdentifier: "toFriendInfo", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destvc = segue.destination as? FriendPersonalVC {
            destvc.friendSelf = friends?[selectedRow]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tbvc = tabBarController as! tabBarController
        self.userSelf = tbvc.userSelf
        self.friends = self.userSelf?.fetchedFriend
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
