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
    var foodLiked = [String]()
    var foodHated = [String]()
    var restLiked = [String]()
    var restHated = [String]()
    
    init(name: String, foodLiked: [String],foodHated: [String], restLiked: [String],restHated: [String] ) {
        self.name = name
        self.foodLiked = foodLiked
        self.foodHated = foodHated
        self.restLiked = restLiked
        self.restHated = restHated
    }
}
