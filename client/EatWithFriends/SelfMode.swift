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
    
    private var restList = [Restaurant]() // All of restaurant
    
    private var isRegistered = false

    init() {
        // self.name = LoginViewController.GlobalVariable.myFirstName
        // self.id = LoginViewController.GlobalVariable.myUserId
        
        self.name = "Chao Ma"
        self.id = "fhqourojkafj0914"
        
        let A = User(name: "A", foodLiked: [], foodHated: [], restLiked: [], restHated: [])
        let B = User(name: "B", foodLiked: [], foodHated: [], restLiked: [], restHated: [])
        let C = User(name: "C", foodLiked: [], foodHated: [], restLiked: [], restHated: [])
        let D = User(name: "D", foodLiked: [], foodHated: [], restLiked: [], restHated: [])
        
        //self.makeGetUserRequest(url: "https://info449.com/users-info449")
        self.makeGetRestaurantRequest(url: "https://info449.com/uw-restaurants-info449")
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
    
    func getAllRest() -> [Restaurant] {
        return self.restList
    }
    
////////////////////////////////// Http connection
    func makeGetUserRequest(url: String) {
        guard let URL = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: URL) {(data, response, error) in
                if (!Reachability.isConnectedToNetwork() || error != nil) {
                    if (error != nil) {
                        print(error ?? "Somthing wrong")
                    }
                } else{
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!) as! [AnyObject]
                        // print(json)
                        self.buildSelf(json: json, url: url)
                        // print(self.name)
                        // print(self.id)
                    } catch {
                        print (error)
                    }
                }
        }
        task.resume()
    }
    
    private func buildSelf(json: [AnyObject], url: String) {
        for obj in json {
            let user = obj as? [String:AnyObject]
            let userName = user!["fullName"] as! String!
            let userEmail = user!["email"] as! String!
            let userId = user!["userId"] as! String!
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
            self.fetchedFriend += findFriend(friendString: fetchedFriendString)
        } else {
            self.fetchedFriendString = [String]()
            self.foodLiked = [String]()
            self.foodHated = [String]()
            self.restLiked = [String]()
            self.restHated = [String]()
            self.fetchedFriend = [User]()
            makePostRequest(url: url)
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
    
    // get all the resuaurant information
    func makeGetRestaurantRequest(url: String) {
        guard let URL = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: URL) {(data, response, error) in
            if (!Reachability.isConnectedToNetwork() || error != nil) {
                if (error != nil) {
                    print(error ?? "Somthing wrong")
                }
            } else{
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! [AnyObject]
                    self.buildRest(json: json)
                } catch {
                    print (error)
                }
            }
        }
        task.resume()
    }
    
    private func buildRest(json: [AnyObject]) {
        for obj in json {
            let rest = obj as? [String:AnyObject]
            let restName = rest!["fullName"] as! String
            let image_url = rest!["image_url"] as! String
            let categories = rest!["categories"] as! [AnyObject]!
            var categoryList = [String]()
            
            for subCateObj in categories! {
                let subCates = subCateObj as? [String:String]
                let subCate = subCates!["title"] as String!
                categoryList.append(subCate!)
            }
            
            let rating = rest!["rating"] as! Double
            let price = rest!["price"] as! String!
            let addressObj = rest!["location"] as? [String: AnyObject]
            let addressDisplay = addressObj!["display_address"]  as! [String]
            var address = ""
            for addressIndex in addressDisplay {
                address += (addressIndex + " ")
            }
            
            let phone = rest!["phone"] as! String
            let distance = rest!["distance"] as! Double
            
            let newRest = Restaurant(name: restName, image_url: image_url, categories: categoryList, rating: rating, price: price!, address: address, phone: phone, distance: distance)
            restList.append(newRest)
        }
    }
    
    // Post a new user
    func makePostRequest(url: String) {
        let param = ["fullName": self.name!,
                     "givenName":"",
                     "familyName":"",
                     "email": "",
                     "userId": self.id!,
                     "friend_list":[
                        ""
                     ],
                     "preference":[
                        "categories":[
                            "cat_like":[
                                ""
                            ],
                            "cat_dislike":[
                                ""
                            ]
                        ],
                        "restaurants":[
                                "res_like": [
                                    ""
                                ],
                                "res_like_id": [
                                    ""
                                ],
                                "res_dislike": [
                                    ""
                                ],
                                "res_dislike_id": [
                                    ""
                                ]
                            ]
                        ]
                    ] as [String : Any]
        
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: param) else {return}
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) {(data, response, error) in
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
    
    // change data of existing user
////////////////////////////////////////////////////////////////////////////////////////////////////
}
