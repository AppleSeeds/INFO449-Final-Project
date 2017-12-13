//
//  PreferenceChooseFoodTableViewController.swift
//  EatWithFriends
//
//  Created by YuanShaochen on 2017/12/11.
//  Copyright © 2017年 iGuest. All rights reserved.
//

import UIKit

class PreferenceChooseFoodTableViewController: UITableViewController {
    
    let food = ["Acai Bowls", "Afghan", "African", "American (New)", "American (Traditional)", "Argentine", "Art Classes", "Asian Fusion", "Australian", "Bakeries", "Barbeque", "Bars", "Basque", "Beer Bar", "Beer Gardens", "Beer,  Wine & Spirits", "Belgian", "Bike Repair/Maintenance", "Bookstores", "Brasseries", "Brazilian", "Breakfast & Brunch", "Breweries", "British", "Bubble Tea", "Buffets", "Burgers", "Butcher", "Cabaret", "Cafes", "Cajun/Creole", "Cambodian", "Cantonese", "Caribbean", "Catalan", "Caterers", "Champagne Bars", "Cheese Shops", "Cheesesteaks", "Chicken Shop", "Chicken Wings", "Chinese", "Cocktail Bars", "Coffee & Tea", "Colombian", "Comfort Food", "Community Centers", "Community Service/Non-Profit", "Convenience Stores", "Conveyor Belt Sushi", "Creperies", "Cuban", "Dance Clubs", "Delis", "Desserts", "Dim Sum", "Diners", "Dinner Theater", "Dive Bars", "Donuts", "Egyptian", "Empanadas", "Ethiopian", "Falafel", "Fast Food", "Filipino", "Fish & Chips", "Florists", "Food Court", "Food Delivery Services", "Food Stands", "Food Trucks", "French", "Gastropubs", "Gay Bars", "Gelato", "German", "Gluten-Free", "Greek", "Grocery", "Halal", "Hawaiian", "Himalayan/Nepalese", "Honduran", "Hong Kong Style Cafe", "Hot Dogs", "Hot Pot", "Ice Cream & Frozen Yogurt", "Indian", "Indonesian", "Irish", "Irish Pub", "Italian", "Izakaya", "Japanese", "Japanese Curry", "Jazz & Blues", "Juice Bars & Smoothies", "Karaoke", "Korean", "Laotian", "Latin American", "Lebanese", "Live/Raw Food", "Lounges", "Malaysian", "Meat Shops", "Mediterranean", "Mexican", "Middle Eastern", "Modern European", "Moroccan", "Music Venues", "New Mexican Cuisine", "Noodles", "Outdoor Gear", "Pan Asian", "Pasta Shops", "Patisserie/Cake Shop", "Performing Arts", "Peruvian", "Pizza", "Poke", "Polish", "Pool Halls", "Portuguese", "Pretzels", "Pubs", "Puerto Rican", "Ramen", "Restaurants", "Russian", "Salad", "Salvadoran", "Sandwiches", "Scandinavian", "Scottish", "Seafood", "Seafood Markets", "Senegalese", "Shanghainese", "Shaved Ice", "Soul Food", "Soup", "South African", "Southern", "Spanish", "Speakeasies", "Specialty Food", "Sports Bars", "Steakhouses", "Street Vendors", "Sushi Bars", "Syrian", "Szechuan", "Tacos", "Taiwanese", "Tapas Bars", "Tapas/Small Plates", "Teppanyaki", "Tex-Mex", "Thai", "Themed Cafes", "Trinidadian", "Turkish", "Tuscan", "Ukrainian", "Vegan", "Vegetarian", "Venezuelan", "Venues & Event Spaces", "Vietnamese", "Waffles", "Whiskey Bars", "Wine Bars", "Wraps"]
    var foodSelected = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationController = segue.destination as! PersonalVC
        if(PersonalVC.PersonalPreferenceSettings.whichButton == "toSelectFoodLike"){
            PersonalVC.PersonalPreferenceSettings.setSelectedFood = foodSelected
        }else if(PersonalVC.PersonalPreferenceSettings.whichButton == "toSelectFoodHate"){
            PersonalVC.PersonalPreferenceSettings.setSelectedFoodHate = foodSelected
        }
        
    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return food.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        cell.textLabel?.text = food[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if already ticked, unchoose when user tapped the row.
        if (tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.none){
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            if(!foodSelected.contains(food[indexPath.row])){
                foodSelected.append(food[indexPath.row])
            }
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            foodSelected = foodSelected.filter { $0 != food[indexPath.row] }
        }

        
    }
    @objc func foodSelectFinishedButtonPressed(){
        print(foodSelected)
        performSegue(withIdentifier: "preFoodSelectToPre", sender: self)
    }
    
    private func setupNavigationItems(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finished", style: .done, target: self, action: #selector(PreferenceChooseFoodTableViewController.foodSelectFinishedButtonPressed))
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
