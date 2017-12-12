//
//  RestaurantModel.swift
//  EatWithFriends
//
//  Created by 徐 翰洋 on 11/12/2017.
//  Copyright © 2017 iGuest. All rights reserved.
//

import Foundation

struct Restaurant {
    var name: String
    var image_url: String
    var categories: [String]
    var rating: Double
    var price: String
    var address: String
    var phone: String
    var distance: Double
    
    init(name: String, image_url: String, categories: [String], rating: Double, price: String, address: String, phone: String, distance: Double) {
        self.name = name
        self.image_url = image_url
        self.categories = categories
        self.rating = rating
        self.price = price
        self.address = address
        self.phone = phone
        self.distance = distance
    }
}
