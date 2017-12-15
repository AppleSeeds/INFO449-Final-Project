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
    var restList = [Restaurant]()
    var restSelected = [String]()
    var restFullList = [Restaurant]()
    var restListStringLike = [String]()
    var restListStringHate = [String]()
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
        
        scrollViewResDont.layer.borderColor = UIColor.black.cgColor
        scrollViewResDont.layer.borderWidth = 1.0
        scrollViewResLike.layer.borderColor = UIColor.black.cgColor
        scrollViewResLike.layer.borderWidth = 1.0
        scrollViewfoodDont.layer.borderColor = UIColor.black.cgColor
        scrollViewfoodDont.layer.borderWidth = 1.0
        scrollViewFoodLike.layer.borderColor = UIColor.black.cgColor
        scrollViewFoodLike.layer.borderWidth = 1.0
        
        let tbvc = tabBarController as! tabBarController
        self.userSelf = tbvc.userSelf
        
        setupLogOutNavicationItem()
        setupSubmitNavicationItem()
        setupWelcomeText()
        
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
    
    private func setupWelcomeText(){
        welcomeText = "Hi! "+LoginViewController.GlobalVariable.myFirstName
        welcomeLabel.text = welcomeText
    }
    
    @objc func logOut(){
        GIDSignIn.sharedInstance().signOut()
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let logOutNextScreen = storyboard.instantiateViewController(withIdentifier: "loginVC")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = logOutNextScreen
    }
    
    //function executed when submit button clicked
    @objc func patchInfo(){
        userData()
        let param = [
            "id": "XN2WrDf3qKrzNzC",
            "preference": [
                    [
                        "categories": [
                            ["cat_like": [
                                "New"
                                ],
                             "cat_dislike": [""]
                            ]
                        ],
                        "restaurants":[
                            ["res_like": [""],
                             "res_like_id": [
                                ""
                                ],
                             "res_dislike": [""],
                             "res_dislike_id": [
                                ""
                                ]
                            ]
                        ]
                    ]
            ]
        ] as [String: Any]
        let userUrl = "https://info449.com/users-info449"
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
    
    //global variables
    struct PersonalPreferenceSettings {
        static var whichButton = String()
        static var setSelectedFood = [String]()
        static var setSelectedFoodHate = [String]()
        static var setSelectedRest = [String]()
        static var setSelectedRestHate = [String]()
    }
    
    func userData(){
        userSelf?.foodLiked = PersonalPreferenceSettings.setSelectedFood
        userSelf?.foodHated = PersonalPreferenceSettings.setSelectedFoodHate
        restListStringLike = PersonalPreferenceSettings.setSelectedRest
        restListStringHate = PersonalPreferenceSettings.setSelectedRestHate
        userSelf?.restLiked = stringListToRestList(stringList: restListStringLike)
        userSelf?.restHated = stringListToRestList(stringList: restListStringHate)
        
    }
    
    private func stringListToRestList(stringList: [String]) -> [Restaurant] {
        restList = (userSelf?.getRestList())!
        var result = [Restaurant]()
        for item in stringList {
            for restInFull in restList {
                if (item == restInFull.name) {
                    result.append(restInFull)
                }
            }
        }
        return result
    }
}
