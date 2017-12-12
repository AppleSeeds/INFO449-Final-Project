//
//  SelfMode.swift
//  EatWithFriends
//
//  Created by 徐 翰洋 on 11/12/2017.
//  Copyright © 2017 iGuest. All rights reserved.
//

import Foundation

class SelfMode {
    private var allUsers = [User]()
    private var name: String?
    private var id: String?
    
    private var fetchedFriend = [User]()
    private var fetchedFriendString = [String]()
    
    private var foodLiked = [String]()
    private var foodHated = [String]()
    private var restLiked = [String]()
    private var restHated = [String]()
    
    private var isRegistered = false

    init(url: String) {
        self.name = LoginViewController.GlobalVariable.myFirstName
        self.id = LoginViewController.GlobalVariable.myUserId
        
        let A = User(name: "A", foodLiked: [], foodHated: [], restLiked: [], restHated: [])
        let B = User(name: "B", foodLiked: [], foodHated: [], restLiked: [], restHated: [])
        let C = User(name: "C", foodLiked: [], foodHated: [], restLiked: [], restHated: [])
        let D = User(name: "D", foodLiked: [], foodHated: [], restLiked: [], restHated: [])
        
        self.makeGetRequest(url: url)
        fetchedFriend.append(A)
        fetchedFriend.append(B)
        fetchedFriend.append(C)
        fetchedFriend.append(D)
    }
    
    func getFetchedFriend() -> [User]{
        return self.fetchedFriend
    }
    
    func getFoodLiked() -> [String] {
        return self.foodLiked
    }
    
    func getFoodHated() -> [String] {
        return self.foodHated
    }
    
    func getRestLiked() -> [String] {
        return self.restLiked
    }
    
    func getRestHated() -> [String] {
        return self.restHated
    }
    
////////////////////////////////// Http connection
    func makeGetRequest(url: String) {
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                if (!Reachability.isConnectedToNetwork() || error != nil) {
                    if (error != nil) {
                        print(error ?? "Somthing wrong")
                    }
                } else{
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!) as! [AnyObject]
                        // print(json)
                        self.buildSelf(json: json)
                        print(self.name)
                        print(self.id)
                        print(self)
                    } catch {
                        print (error)
                    }
                }
        }
        task.resume()
    }
    
    private func buildSelf(json: [AnyObject]) {
        for obj in json {
            let user = obj as? [String:AnyObject]
            let userName = user!["fullName"] as! String!
            let userId = user!["userId"] as! String!
            let userEmail = user!["email"] as! String!
            let userFriendListString = user!["friend_list"] as! [String]!
            
            var userCategoriesLiked = [String]()
            var userCategoriesHated = [String]()
            var userRestLiked = [String]()
            var userRestHated = [String]()
            
            let preference = user!["preference"] as! [AnyObject]!
            
            for prefObj in preference! {
                let pref = prefObj as? [String:AnyObject]
                let categoriesObj = pref!["categories"] as! [AnyObject]!
                let restObj = pref!["restaurants"] as! [AnyObject]!
                
                for categories in categoriesObj! {
                    userCategoriesLiked = categories["cat_like"] as! [String]!
                    userCategoriesHated = categories["cat_dislike"] as! [String]!
                }
                
                for rest in restObj! {
                    userRestLiked = rest["res_like"] as! [String]!
                    userRestHated = rest["res_dislike"] as! [String]!
                }
            }
            
            let userObj = User(name: userName!, id:userId!, email: userEmail!, foodLiked: userCategoriesLiked, foodHated: userCategoriesHated, restLiked: userRestLiked, restHated: userRestHated, friends: userFriendListString!)
            allUsers.append(userObj)
            
            if (userName == self.name && userId == self.id) {
                isRegistered = true
                self.fetchedFriendString = userFriendListString!
                self.foodLiked = userCategoriesLiked
                self.foodHated = userCategoriesHated
                self.restLiked = userRestLiked
                self.restHated = userRestHated
            }
        }
        if (isRegistered) {
            self.fetchedFriend = findFriend(friendString: fetchedFriendString)
        } else {
            self.fetchedFriendString = [String]()
            self.foodLiked = [String]()
            self.foodHated = [String]()
            self.restLiked = [String]()
            self.restHated = [String]()
            self.fetchedFriend = [User]()
        }
    }
    
    func findFriend(friendString: [String]) -> [User] {
        var result = [User]()
        for friend in friendString {
            for user in allUsers {
                if (friend == (user.name)) {
                    result.append(user)
                }
            }
        }
        return result
    }
    
    func makePostRequest() {
        
    }
////////////////////////////////////////////////////////////////////////////////////////////////////
}
