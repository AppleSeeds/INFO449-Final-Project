//
//  SelectRestViewController.swift
//  EatWithFriends
//
//  Created by 徐 翰洋 on 12/12/2017.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit

class SelectRestViewController: UIViewController {
    var userSelf : SelfMode?
    var addedFriend : [User]?
    
    var foodCate = ["Acai Bowls", "Afghan", "African", "American (New)", "American (Traditional)", "Argentine", "Art Classes", "Asian Fusion", "Australian", "Bakeries", "Barbeque", "Bars", "Basque", "Beer Bar", "Beer Gardens", "Beer,  Wine & Spirits", "Belgian", "Bike Repair/Maintenance", "Bookstores", "Brasseries", "Brazilian", "Breakfast & Brunch", "Breweries", "British", "Bubble Tea", "Buffets", "Burgers", "Butcher", "Cabaret", "Cafes", "Cajun/Creole", "Cambodian", "Cantonese", "Caribbean", "Catalan", "Caterers", "Champagne Bars", "Cheese Shops", "Cheesesteaks", "Chicken Shop", "Chicken Wings", "Chinese", "Cocktail Bars", "Coffee & Tea", "Colombian", "Comfort Food", "Community Centers", "Community Service/Non-Profit", "Convenience Stores", "Conveyor Belt Sushi", "Creperies", "Cuban", "Dance Clubs", "Delis", "Desserts", "Dim Sum", "Diners", "Dinner Theater", "Dive Bars", "Donuts", "Egyptian", "Empanadas", "Ethiopian", "Falafel", "Fast Food", "Filipino", "Fish & Chips", "Florists", "Food Court", "Food Delivery Services", "Food Stands", "Food Trucks", "French", "Gastropubs", "Gay Bars", "Gelato", "German", "Gluten-Free", "Greek", "Grocery", "Halal", "Hawaiian", "Himalayan/Nepalese", "Honduran", "Hong Kong Style Cafe", "Hot Dogs", "Hot Pot", "Ice Cream & Frozen Yogurt", "Indian", "Indonesian", "Irish", "Irish Pub", "Italian", "Izakaya", "Japanese", "Japanese Curry", "Jazz & Blues", "Juice Bars & Smoothies", "Karaoke", "Korean", "Laotian", "Latin American", "Lebanese", "Live/Raw Food", "Lounges", "Malaysian", "Meat Shops", "Mediterranean", "Mexican", "Middle Eastern", "Modern European", "Moroccan", "Music Venues", "New Mexican Cuisine", "Noodles", "Outdoor Gear", "Pan Asian", "Pasta Shops", "Patisserie/Cake Shop", "Performing Arts", "Peruvian", "Pizza", "Poke", "Polish", "Pool Halls", "Portuguese", "Pretzels", "Pubs", "Puerto Rican", "Ramen", "Restaurants", "Russian", "Salad", "Salvadoran", "Sandwiches", "Scandinavian", "Scottish", "Seafood", "Seafood Markets", "Senegalese", "Shanghainese", "Shaved Ice", "Soul Food", "Soup", "South African", "Southern", "Spanish", "Speakeasies", "Specialty Food", "Sports Bars", "Steakhouses", "Street Vendors", "Sushi Bars", "Syrian", "Szechuan", "Tacos", "Taiwanese", "Tapas Bars", "Tapas/Small Plates", "Teppanyaki", "Tex-Mex", "Thai", "Themed Cafes", "Trinidadian", "Turkish", "Tuscan", "Ukrainian", "Vegan", "Vegetarian", "Venezuelan", "Venues & Event Spaces", "Vietnamese", "Waffles", "Whiskey Bars", "Wine Bars", "Wraps"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
