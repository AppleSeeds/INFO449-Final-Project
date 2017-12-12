//
//  PersonalVC.swift
//  EatWithFriends
//
//  Created by ​ on 12/4/17.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit
import GoogleSignIn
class PersonalVC: UIViewController{
    var welcomeText = ""
    
    // Important! Check out SelfModel
    var userSelf: SelfMode?  // get user data from this!!!!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    


    

    override func viewDidLoad() {
        super.viewDidLoad()
        let globelSelf = self.tabBarController as! tabBarController
        self.userSelf = globelSelf.userSelf // assign the gobel model: userself
        // you can get all data about user from here
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(PersonalVC.logOut))
        
        welcomeText = LoginViewController.GlobalVariable.myFirstName
        welcomeLabel.text = welcomeText
        
        
    }

    @objc func logOut(){
        GIDSignIn.sharedInstance().signOut()
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let logOutNextScreen = storyboard.instantiateViewController(withIdentifier: "loginVC")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = logOutNextScreen
    }
    


}
