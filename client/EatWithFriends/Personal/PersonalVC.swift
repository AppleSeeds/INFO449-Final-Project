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
    var userSelf: SelfMode?  // get user data from this!!!! add info to userSelf before it can be patched.
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var flavorLike: UITextView!
    @IBOutlet weak var flavorDontLike: UITextView!
    @IBOutlet weak var restLike: UITextView!
    @IBOutlet weak var scrollViewResLike: UIScrollView!
    @IBOutlet weak var scrollViewfoodDont: UIScrollView!
    @IBOutlet weak var scrollViewFoodLike: UIScrollView!
    @IBOutlet weak var scrollViewResDont: UIScrollView!
    @IBOutlet weak var restDont: UITextView!

    //when update button pressed, save a string into whichButton global variable in order to distinguish which button was clicked so that it directed to the choose food/restaurants screen.
    @IBAction func selectFoodLikeButtonPressed(_ sender: UIButton) {
        PersonalPreferenceSettings.whichButton = "toSelectFoodLike"
        performSegue(withIdentifier: "prefToSelections", sender: self)
    }
    
    @IBAction func selectFoodHateButtonPressed(_ sender: UIButton) {
        PersonalPreferenceSettings.whichButton = "toSelectFoodHate"
        performSegue(withIdentifier: "prefToSelections", sender: self)
    }
    
    @IBAction func selectRestButtonPressed(_ sender: UIButton) {
        PersonalPreferenceSettings.whichButton = "toSelectRestLike"
        performSegue(withIdentifier: "prefToChooseRest", sender: self)
    }
    
    @IBAction func selectRestHateButtonPressed(_ sender: UIButton) {
        PersonalPreferenceSettings.whichButton = "toSelectRestHate"
        performSegue(withIdentifier: "prefToChooseRest", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let globelSelf = self.tabBarController as! tabBarController
        //self.userSelf = globelSelf.userSelf // assign the gobel model: userself
        // you can get all data about user from here
        
        setupLogOutNavicationItem()
        setupSubmitNavicationItem()
        
        welcomeText = "Hi! "+LoginViewController.GlobalVariable.myFirstName
        welcomeLabel.text = welcomeText
        
        //get the user choice result from the global variable, and put all items together as a string, separated by comma, and set the result string to the TextView.
        flavorLike.text = PersonalPreferenceSettings.setSelectedFood.joined(separator: ", ")
        flavorLike.isEditable = false
        scrollViewFoodLike.addSubview(flavorLike)
        
        flavorDontLike.text = PersonalPreferenceSettings.setSelectedFoodHate.joined(separator: ", ")
        flavorDontLike.isEditable = false
        scrollViewfoodDont.addSubview(flavorDontLike)
        
        restLike.text = PersonalPreferenceSettings.setSelectedRest.joined(separator: ", ")
        restLike.isEditable = false
        scrollViewResLike.addSubview(restLike)
        
        restDont.text = PersonalPreferenceSettings.setSelectedRestHate.joined(separator: ", ")
        restDont.isEditable = false
        scrollViewResDont.addSubview(restDont)
    }

    private func setupLogOutNavicationItem(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(PersonalVC.logOut))
    }
    
    private func setupSubmitNavicationItem(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .done, target: self, action: #selector(PersonalVC.patchInfo))
    }
    
    @objc func logOut(){
        GIDSignIn.sharedInstance().signOut()
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let logOutNextScreen = storyboard.instantiateViewController(withIdentifier: "loginVC")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = logOutNextScreen
    }
    
    @objc func patchInfo(){
    }
    
    //global variables
    struct PersonalPreferenceSettings {
        static var whichButton = String()
        static var setSelectedFood = [String]()
        static var setSelectedFoodHate = [String]()
        static var setSelectedRest = [String]()
        static var setSelectedRestHate = [String]()
    }
    

}
