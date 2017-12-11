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


class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate{

    
    
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
        //GGLContext.sharedInstance().configureWithError(&error)
        GIDSignIn.sharedInstance().clientID = clientID
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        let signInButton = GIDSignInButton()
        signInButton.center = view.center
        view.addSubview(signInButton)
        
        print("signInButton setup finished!")
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
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email

        emailLabel.text = email
        print(userId)
        print(idToken)
        print(fullName)
    }
    
    func setupLoginRegisterButton(){
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

  
}

