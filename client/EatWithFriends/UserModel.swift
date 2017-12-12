//
//  UserModel.swift
//  EatWithFriends
//
//  Created by 徐 翰洋 on 10/12/2017.
//  Copyright © 2017 iGuest. All rights reserved.
//

import Foundation

struct User {
    var name: String
    var id: String
    var email: String
    var foodLiked = [String]()
    var foodHated = [String]()
    var restLiked = [Restaurant]()
    var restHated = [Restaurant]()
    var friendList = [String]()
    
    init(name: String, foodLiked: [String],foodHated: [String], restLiked: [Restaurant],restHated: [Restaurant]) {
        self.name = name
        self.foodLiked = foodLiked
        self.foodHated = foodHated
        self.restLiked = restLiked
        self.restHated = restHated
        self.friendList = [String]()
        self.email = ""
        self.id = ""
    }
    
    init(name: String, id: String, email:String, foodLiked: [String], foodHated: [String], restLiked: [Restaurant],restHated: [Restaurant], friends: [String] ) {
        self.init(name: name, foodLiked: foodLiked, foodHated: foodHated, restLiked: restLiked, restHated: restHated)
        self.email = email
        self.friendList = friends
        self.id = id
    }
}
