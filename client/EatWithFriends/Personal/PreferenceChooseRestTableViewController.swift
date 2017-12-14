//
//  PreferenceChooseRestTableViewController.swift
//  EatWithFriends
//
//  Created by YuanShaochen on 2017/12/12.
//  Copyright © 2017年 iGuest. All rights reserved.
//

import UIKit

class PreferenceChooseRestTableViewController: UITableViewController {
    
    let restaurant = ["Guanaco\'s Tacos Pupuseria", "Henry\'s Taiwan Kitchen", "Sizzle&Crunch", "Korean Tofu House", "Thanh Vi", "Wann Yen", "I See Food", "Portage Bay Café", "Beetle Cafe", "Shawarma King", "Mee Sum", "SilkRoad Noodle Bar", "U:Don", "Chi Mac", "Palmi Korean BBQ", "Aladdin Falafel Corner", "Voula\'s Offshore Cafe", "Hiroshi\'s Poke", "Itadakimasu", "Morsel", "Arepa Venezuelan Kitchen", "Old School Ironworks", "JOEY U-Village", "Din Tai Fung", "Ku Sushi and Izakaya", "Pasta & Co", "Ma\'ono Fried Chicken", "Teriyaki 1st", "Eureka!", "Little Lago", "Hokkaido Ramen Santouka", "Amazing Thai Cuisine", "Ba Bar", "Piatti", "Xi\'an Noodles", "Eastlake Bar & Grill", "Fat Ducks Deli & Bakery", "Westward", "Pinkaew Thai Cuisine", "Kabul Afghan Cuisine", "Kokkaku", "TNT Taqueria", "Frank\'s Oyster House & Champagne Parlor", "The Octopus Bar", "Yoroshiku", "Saint Helens Cafe", "Pair", "D\' La Santa", "Jak\'s Grill", "Congeez", "Cantinetta", "Union Saloon", "Harvest Beat", "Pam\'s Kitchen", "Bodrum Bistro Anatolian Kitchen", "Mammoth", "Pomodoro", "Burgundian", "Himalayan Sherpa House", "mkt.", "Cafe Lago", "Kisaku Sushi", "Next Level Burger", "Mioposto - Bryant", "Toronado Seattle", "Tilth", "Rain City Burgers", "Casa Patrón", "Bol Test Kitchen & Bar", "Rocking Wok Taiwanese Cuisine", "Musashi\'s", "JuneBaby", "Pablo y Pablo", "Wataru", "Salare", "Bizzarro Italian Cafe", "The Zouave Restaurant", "Tutta Bella Neapolitan Pizzeria - Wallingford", "Tsui Sushi Bar", "The Butcher & The Baker", "Perché No Pasta & Vino", "Cicchetti", "Serafina", "36 Stone", "RoRo BBQ & Grill", "Art of The Table", "Seattle Meowtropolitan", "Joule", "Manolin", "Stone Way Cafe", "Kamonegi", "Thackeray", "MiiR", "Pacific Inn Pub", "Nell\'s Restaurant", "Brunello Ristorante", "Shelter Lounge", "Mykonos Greek Grill", "Uneeda Burger", "Rosita\'s Mexican Grill"]
   
    var restSelected = [String]()//result from user choice

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        

    }
    
    //after user selection and press button finished, segue is executed, and before execution, save result in global variables to transfer the data back to the preference screen.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destinationController = segue.destination as! PersonalVC
//        restSelectedString = restSelected.joined(separator: ", ")//put all selected food into one string.
        if(PersonalVC.PersonalPreferenceSettings.whichButton == "toSelectRestLike"){
            PersonalVC.PersonalPreferenceSettings.setSelectedRest = restSelected
        }else if(PersonalVC.PersonalPreferenceSettings.whichButton == "toSelectRestHate"){
            PersonalVC.PersonalPreferenceSettings.setSelectedRestHate = restSelected
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurant.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "choosingRestCells", for: indexPath)
        cell.textLabel?.text = restaurant[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //when user tapped a row and if it is not ticked, the row will be ticked and this item is added to the result array.
        if (tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.none){
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            if(!restSelected.contains(restaurant[indexPath.row])){
                restSelected.append(restaurant[indexPath.row])
            }
            //if already ticked, unchoose when user tapped the row, and remove the item from the result array.
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            restSelected = restSelected.filter { $0 != restaurant[indexPath.row] }
        }
    }
    
    private func setupNavigationItems(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finished", style: .done, target: self, action: #selector(PreferenceChooseRestTableViewController.restSelectFinishedButtonPressed))
    }
    
    @objc func restSelectFinishedButtonPressed(){
        print(restSelected)
        performSegue(withIdentifier: "restSelectionToPre", sender: self)
    }
    
    private func restListToStringList(restList: [Restaurant]) -> [String] {
        var result = [String]()
        for rest in restList {
            result.append(rest.name)
        }
        return result
    }
    

}
