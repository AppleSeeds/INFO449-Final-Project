//
//  LoginViewController.swift
//  EatWithFriends
//
//  Created by YuanShaochen on 2017/12/8.
//  Copyright © 2017年 iGuest. All rights reserved.
//

import UIKit
import GoogleSignIn
//import Google
//protocol DataSentDelegate {
//    func userDidLogin(data: String)
//}

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate{
    //var delegate: DataSentDelegate? = nil
    @IBOutlet weak var emailLabel: UILabel!
    //    let inputsContainerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.white
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = 5
//        view.layer.masksToBounds = true
//        return view
//    }()
//
//    let loginRegisterButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255, alpha: 1)
//        button.setTitle("Register", for: [])
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var error: NSError?
        if error != nil{
            print(error ?? "google error")
            return
        }
        let clientID = "316572482051-46gf7rla0pe1acil60122dta9eoee4f9.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().clientID = clientID
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        let signInButton = GIDSignInButton()
        signInButton.center = view.center
        view.addSubview(signInButton)
        view.backgroundColor = UIColor.white
        //view.addSubview(inputsContainerView)
        //view.addSubview(loginRegisterButton)
        //setupInputsContainerView()
        //setupLoginRegisterButton()
        //constraints
        
    }
    
//    func setupInputsContainerView(){
//        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
//        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
//    }
//    func signIn(signIn:GIDSignIn! ,didSignInForUser user:GIDGoogleUser!, withError error: NSError! ){
//        print(user.profile.email)
//    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        //when login successfully, get the user's firstname and go to next screen
          if(error == nil){
          let userId = user.userID;
//        let idToken = user.authentication.idToken;
          let firstName = user.profile.givenName;
//        let email = user.profile.email
          let lastName = user.profile.familyName;
            
            GlobalVariable.myFirstName = firstName!
            GlobalVariable.myUserId = userId!
            GlobalVariable.myLastName = lastName!
//        emailLabel.text = "Welcome! "+firstName!
            let storyboard = UIStoryboard(name:"Main", bundle:nil)
            let logInNextScreen = storyboard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = logInNextScreen
            //performSegue(withIdentifier: "loginToTabBarVCSegue", sender: self)
        }else{
            print(error!.localizedDescription)
            return
        }

    }
    struct GlobalVariable {
        static var myFirstName = String()
        static var myUserId = String()
        static var myLastName = String()
        
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        var personalVC = segue.destination as! PersonalVC
//        personalVC.welcomeText = emailLabel.text!
//    }
    
    func setupLoginRegisterButton(){
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

  
}

