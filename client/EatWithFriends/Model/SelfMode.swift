//
//  SelfMode.swift
//  EatWithFriends
//
//  Created by 徐 翰洋 on 11/12/2017.
//  Copyright © 2017 iGuest. All rights reserved.
//

import Foundation

class SelfMode {
    var allUsers: [User]
    var name: String
    var id: String

    var fetchedFriend: [User]
    var fetchedFriendString: [String]

    var foodLiked: [String]
    var foodHated: [String]
    var restLiked: [Restaurant]
    var restHated: [Restaurant]
    var restList: [Restaurant]
    var isRegistered: Bool

    let semaphore = DispatchSemaphore(value: 0)
    let semaphore2 = DispatchSemaphore(value: 0)

    init() {
        self.name = LoginViewController.GlobalVariable.myFirstName
        self.id = LoginViewController.GlobalVariable.myUserId

        self.allUsers = []
        self.fetchedFriend = []
        self.fetchedFriendString = []
        self.foodLiked = []
        self.foodHated = []
        self.restLiked = []
        self.restHated = []
        self.restList = []
        self.isRegistered = false

        makeGetRestaurantRequest(url: "https://info449.com/uw-restaurants-info449")
        makeGetUserRequest(url: "https://info449.com/users-info449")

    }

    func getFetchedFriend() -> [User] {
        return self.fetchedFriend
    }

    func getFoodLiked() -> [String] {
        return self.foodLiked
    }

    func getFoodHated() -> [String] {
        return self.foodHated
    }

    func getRestLiked() -> [Restaurant] {
        return self.restLiked
    }

    func getRestHated() -> [Restaurant] {
        return self.restHated
    }

    func getRestList() -> [Restaurant] {
        return self.restList
    }

    func getAllUser() -> [User] {
        return self.allUsers
    }

////////////////////////////////// Http connection
    func makeGetUserRequest(url: String) {
        guard let URL = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: URL) { (data, response, error) in
            if (!Reachability.isConnectedToNetwork() || error != nil) {
                if (error != nil) {
                    print(error ?? "Somthing wrong")
                }
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! [AnyObject]
                    self.buildSelf(json: json, url: url)
                } catch {
                    print (error)
                }

            }
            self.semaphore2.signal()
        }
        task.resume()
        self.semaphore2.wait()
    }

    private func buildSelf(json: [AnyObject], url: String) {
        for obj in json {
            let user = obj as? [String: AnyObject]
            let userName = user!["fullName"] as! String!
            let userEmail = user!["email"] as! String!
            let userId = user!["id"] as! String! // id might need to change
            let userFriendListString = user!["friend_list"] as! [String]!

            var userCategoriesLiked = [String]()
            var userCategoriesHated = [String]()
            var userRestLikedString = [String]()
            var userRestHatedString = [String]()

            let preference = user!["preference"] as! [[String: [Any]]]!
            let prefObj = preference![0] as! [String: [Any]]

            let resObj = prefObj["restaurants"] as! [Any]
            let catObj = prefObj["categories"] as! [Any]

            let restDic = resObj[0] as! [String: [String]]
            let catDic = catObj[0] as! [String: [String]]

            userRestLikedString = restDic["res_like"] as! [String]
            userRestHatedString = restDic["res_dislike"] as! [String]
            userCategoriesLiked = catDic["cat_like"] as! [String]
            userCategoriesHated = catDic["cat_dislike"] as! [String]
            
            let userRestLiked = findRest(restString: userRestLikedString)
            let userRestHated = findRest(restString: userRestHatedString)

            let userObj = User(name: userName!, id: userId!, email: userEmail!, foodLiked: userCategoriesLiked, foodHated: userCategoriesHated, restLiked: userRestLiked, restHated: userRestHated, friends: userFriendListString!)
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
            self.restLiked = [Restaurant]()
            self.restHated = [Restaurant]()
            self.fetchedFriend = [User]()
            makePostRequest(url: url)
        }
    }

    private func findFriend(friendString: [String]) -> [User] {
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

    private func findRest(restString: [String]) -> [Restaurant] {
        var result = [Restaurant]()
        for rest in restString {
            for restObj in restList {
                if (rest == restObj.name) {
                    result.append(restObj)
                }
            }
        }
        return result
    }

    // get all the resuaurant information
    func makeGetRestaurantRequest(url: String) {
        let uRL = URL(string: url)
        let task = URLSession.shared.dataTask(with: uRL!) { (data, response, error) in
            if (!Reachability.isConnectedToNetwork() || error != nil) {
                if (error != nil) {
                    print(error)
                }
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! [AnyObject]
                    self.buildRest(json: json)
                } catch {
                    print (error)
                }
            }
            self.semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }

    func buildRest(json: [AnyObject]) {
        for obj in json {
            let rest = obj as? [String: AnyObject]

            let restName = rest!["name"] as! String
            let image_url = rest!["image_url"] as! String
            let categories = rest!["categories"] as! [AnyObject]!
            var categoryList = [String]()

            for subCateObj in categories! {
                let subCates = subCateObj as? [String: String]
                let subCate = subCates!["title"] as String!
                categoryList.append(subCate!)
            }

            let rating = rest!["rating"] as! Double
            let price = rest!["price"] as! String
            let addressObj = rest!["location"] as? [String: AnyObject]
            let addressDisplay = addressObj!["display_address"] as! [String]
            var address = ""
            for addressIndex in addressDisplay {
                address += (addressIndex + " ")
            }

            let phone = rest!["phone"] as! String
            let longitude = rest!["coordinates"]!["longitude"] as! Double
            let latitude = rest!["coordinates"]!["latitude"] as! Double

            self.restList.append(Restaurant(name: restName, image_url: image_url, categories: categoryList, rating: rating, price: price, address: address, phone: phone, latitude: latitude, longitude: longitude))
        }
    }

    // Post a new user
    func makePostRequest(url: String) {
        let param = ["fullName": self.name,
            "givenName": "",
            "familyName": "",
            "email": "",
            "id": self.id,
            "friend_list": [
                ""
            ],
            "preference": [
                [
                    "categories": [
                        ["cat_like": [
                            ""
                            ],
                            "cat_dislike": [
                                ""
                            ]]
                    ],
                    "restaurants": [
                        ["res_like": [
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
                ]]
        ] as [String: Any]

        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
}
