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
    var friendVC: FriendsVC?
    
    @IBOutlet weak var textField: UITextField!
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func add(_ sender: Any) {
        var name = textField.text
        var isInUser = false
        var allUser = userSelf?.getAllUser()
        var addedFriend = userSelf?.getFetchedFriend()
        
        for friend in addedFriend! {
            if name == friend.name {
                let alert = UIAlertController(title: "Friend already added", message: "", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        for user in (userSelf?.getAllUser())! {
            if (name == user.name) {
                isInUser = true
                userSelf?.fetchedFriend.append(user)
            }
        }
        
        if (!isInUser) {
            let alert = UIAlertController(title: "User does not exist", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            let friendString = friendListToStringList(friendList: (self.userSelf?.fetchedFriend)!)
            let param = [
                "id": userSelf?.id,
                "friend_list": friendString
                ] as [String: Any]
            let userUrl = "https://info449.com/users-info449" + "/" + (userSelf?.id)!
            guard let url = URL(string: userUrl) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: param) else { return }
            request.httpBody = httpBody
            
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
        self.friendVC?.friends = userSelf?.fetchedFriend
        self.friendVC?.reloadData()
        print("dismissed")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    private func friendListToStringList(friendList: [User]) -> [String] {
        var result = [String]()
        for friend in friendList {
            result.append(friend.name)
        }
        return result
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
