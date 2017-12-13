//
//  AddFriendViewController.swift
//  EatWithFriends
//
//  Created by 徐 翰洋 on 12/12/2017.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController {
    var userSelf: SelfMode?
    
    @IBOutlet weak var textField: UITextField!
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func add(_ sender: Any) {
        var name = textField.text
        var isInUser = false
        var allUser = userSelf?.getAllUser()
        var addedFriend = userSelf?.getFetchedFriend()
        for user in (userSelf?.getAllUser())! {
            if (name == user.name) {
                isInUser = true
            }
            for friend in addedFriend! {
                if  (name == user.name && name != friend.name) {
                    
                } else if (name == user.name && name == friend.name) {
                    // Alter already add
                }
            }
        }
        if (!isInUser) {
            // Alter not a user
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
