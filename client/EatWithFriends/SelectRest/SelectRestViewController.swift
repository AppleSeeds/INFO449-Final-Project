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
    var locationManager: CLLocationManager?
    var userLocation: CLLocation?
    @IBOutlet weak var tableView: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preparedRestList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectRestCell", for: indexPath) as! SelectRestCell
        cell.name.text = preparedRestList?[indexPath.row].name
        cell.category.text = preparedRestList?[indexPath.row].categories.joined(separator: ", ")
        cell.rating.text = "\(String(describing: preparedRestList?[indexPath.row].rating))"
        cell.cost.text = preparedRestList?[indexPath.row].price
        cell.address.text = preparedRestList?[indexPath.row].address
        cell.phone.text = preparedRestList?[indexPath.row].phone
        let latitude = preparedRestList?[indexPath.row].latitude
        let longitude = preparedRestList?[indexPath.row].longitude
        let restLoc = CLLocation(latitude: latitude!, longitude: longitude!)
        let distance = restLoc.distance(from: userLocation!)
        cell.distance.text = String(distance)
        if let url = URL(string: (preparedRestList?[indexPath.row].image_url)!) {
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
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        determineMyCurrentLocation()
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager!.startUpdatingLocation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation!.coordinate.latitude)")
        print("user longitude = \(userLocation!.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }

    
}
