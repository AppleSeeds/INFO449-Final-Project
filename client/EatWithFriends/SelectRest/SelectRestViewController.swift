//
//  SelectRestViewController.swift
//  EatWithFriends
//
//  Created by 徐 翰洋 on 12/12/2017.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit
import CoreLocation

class SelectRestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    var userSelf : SelfMode?
    var addedFriend : [User]?
    var preparedRestList: [Restaurant]?
    var specRestList = [Restaurant]()
//    let locationManager = CLLocationManager()
//    var userLocation: CLLocation?
    @IBOutlet weak var tableView: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specRestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectRestCell", for: indexPath) as! SelectRestCell
        cell.name.text = specRestList[indexPath.row].name
        cell.category.text = specRestList[indexPath.row].categories.joined(separator: ", ")
        let rating = specRestList[indexPath.row].rating
        cell.rating.text = "\(rating)"
        cell.cost.text = specRestList[indexPath.row].price
        cell.address.text = specRestList[indexPath.row].address
        cell.phone.text = specRestList[indexPath.row].phone
//        let latitude = preparedRestList?[indexPath.row].latitude
//        let longitude = preparedRestList?[indexPath.row].longitude
//        let restLoc = CLLocation(latitude: latitude!, longitude: longitude!)
//        let distance = restLoc.distance(from: userLocation!)
//        cell.distance.text = String(distance)
        if let url = URL(string: (specRestList[indexPath.row].image_url)) {
            getDataFromUrl(url: url) { data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                DispatchQueue.main.async() {
                    cell.picView.image = UIImage(data: data)
                }
            }
        }
        return cell
    }

    var foodCate = ["Acai Bowls", "Afghan", "African", "American (New)", "American (Traditional)", "Argentine", "Art Classes", "Asian Fusion", "Australian", "Bakeries", "Barbeque", "Bars", "Basque", "Beer Bar", "Beer Gardens", "Beer,  Wine & Spirits", "Belgian", "Bike Repair/Maintenance", "Bookstores", "Brasseries", "Brazilian", "Breakfast & Brunch", "Breweries", "British", "Bubble Tea", "Buffets", "Burgers", "Butcher", "Cabaret", "Cafes", "Cajun/Creole", "Cambodian", "Cantonese", "Caribbean", "Catalan", "Caterers", "Champagne Bars", "Cheese Shops", "Cheesesteaks", "Chicken Shop", "Chicken Wings", "Chinese", "Cocktail Bars", "Coffee & Tea", "Colombian", "Comfort Food", "Community Centers", "Community Service/Non-Profit", "Convenience Stores", "Conveyor Belt Sushi", "Creperies", "Cuban", "Dance Clubs", "Delis", "Desserts", "Dim Sum", "Diners", "Dinner Theater", "Dive Bars", "Donuts", "Egyptian", "Empanadas", "Ethiopian", "Falafel", "Fast Food", "Filipino", "Fish & Chips", "Florists", "Food Court", "Food Delivery Services", "Food Stands", "Food Trucks", "French", "Gastropubs", "Gay Bars", "Gelato", "German", "Gluten-Free", "Greek", "Grocery", "Halal", "Hawaiian", "Himalayan/Nepalese", "Honduran", "Hong Kong Style Cafe", "Hot Dogs", "Hot Pot", "Ice Cream & Frozen Yogurt", "Indian", "Indonesian", "Irish", "Irish Pub", "Italian", "Izakaya", "Japanese", "Japanese Curry", "Jazz & Blues", "Juice Bars & Smoothies", "Karaoke", "Korean", "Laotian", "Latin American", "Lebanese", "Live/Raw Food", "Lounges", "Malaysian", "Meat Shops", "Mediterranean", "Mexican", "Middle Eastern", "Modern European", "Moroccan", "Music Venues", "New Mexican Cuisine", "Noodles", "Outdoor Gear", "Pan Asian", "Pasta Shops", "Patisserie/Cake Shop", "Performing Arts", "Peruvian", "Pizza", "Poke", "Polish", "Pool Halls", "Portuguese", "Pretzels", "Pubs", "Puerto Rican", "Ramen", "Restaurants", "Russian", "Salad", "Salvadoran", "Sandwiches", "Scandinavian", "Scottish", "Seafood", "Seafood Markets", "Senegalese", "Shanghainese", "Shaved Ice", "Soul Food", "Soup", "South African", "Southern", "Spanish", "Speakeasies", "Specialty Food", "Sports Bars", "Steakhouses", "Street Vendors", "Sushi Bars", "Syrian", "Szechuan", "Tacos", "Taiwanese", "Tapas Bars", "Tapas/Small Plates", "Teppanyaki", "Tex-Mex", "Thai", "Themed Cafes", "Trinidadian", "Turkish", "Tuscan", "Ukrainian", "Vegan", "Vegetarian", "Venezuelan", "Venues & Event Spaces", "Vietnamese", "Waffles", "Whiskey Bars", "Wine Bars", "Wraps"]

    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preparedRestList = userSelf?.getRestList()
        generateSpecRest()
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        locationManager.requestAlwaysAuthorization()
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.startUpdatingLocation()
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateSpecRest() {
        var likeRestList = [String]()
        var likeFlavorList = [String]()
        var dislikeRestList = [String]()
        var dislikeFlavorList = [String]()
        
        if let addedFriends = addedFriend {
            for friend in addedFriends {
                for restLike in friend.restLiked {
                    if !dislikeRestList.contains(restLike.name) {
                       likeRestList.append(restLike.name)
                    }
                }
                for restHated in friend.restHated {
                    dislikeRestList.append(restHated.name)
                }
                for foodHated in friend.foodHated {
                    dislikeFlavorList.append(foodHated)
                }
                for foodLike in friend.foodLiked {
                    if !dislikeFlavorList.contains(foodLike) {
                        likeFlavorList.append(foodLike)
                    }
                }
            }
        }
        if let userSelf = userSelf {
            for foodHated in userSelf.foodHated {
                dislikeFlavorList.append(foodHated)
            }
            for restHated in userSelf.restHated {
                dislikeRestList.append(restHated.name)
            }
            for foodLike in userSelf.foodLiked {
                if !dislikeFlavorList.contains(foodLike) {
                    likeFlavorList.append(foodLike)
                }
            }
            for restLike in userSelf.restLiked {
                if !dislikeRestList.contains(restLike.name) {
                    likeRestList.append(restLike.name)
                }
            }
        }
        if let restList = preparedRestList {
            if likeFlavorList.count == 0 && likeRestList.count == 0 {
                for rest in restList {
                    if !dislikeRestList.contains(rest.name) {
                        for cato in rest.categories {
                            if !dislikeFlavorList.contains(cato) {
                                specRestList.append(rest)
                            }
                        }
                    }
                }
            } else {
                for rest in restList {
                    if likeRestList.contains(rest.name) {
                        specRestList.append(rest)
                    } else {
                        for cato in rest.categories {
                            if likeFlavorList.contains(cato) {
                                specRestList.append(rest)
                            }
                        }
                    }
                }
            }
        }
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            userLocation = location
//            print(location.coordinate)
//        }
//    }
    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
//    {
//        print("Error \(error)")
//    }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if(status == CLAuthorizationStatus.denied) {
//            showLocationDisabledPopUp()
//        }
//    }
    
    @IBAction func randomSelectForUser(_ sender: UIButton) {
        if let restList = preparedRestList {
            if restList.count == 1 {
                let alert = UIAlertController(title: "Wanna change to another restaurant?", message: "You have to go where we chose for u.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Fine.", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                let rand = Int(arc4random_uniform(UInt32(restList.count)))
                let chosenOne = restList[rand]
                preparedRestList = [chosenOne]
                tableView.reloadData()
            }
        }
    }
    
    // Show the popup to the user if we have been deined access
//    func showLocationDisabledPopUp() {
//        let alertController = UIAlertController(title: "Background Location Access Disabled",
//                                                message: "In order for later usage we need your location",
//                                                preferredStyle: .alert)
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//
//        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
//            if let url = URL(string: UIApplicationOpenSettingsURLString) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            }
//        }
//        alertController.addAction(openAction)
//
//        self.present(alertController, animated: true, completion: nil)
//    }
//
}
