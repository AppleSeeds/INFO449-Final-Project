//
//  PreferenceChooseFoodTableViewController.swift
//  EatWithFriends
//
//  Created by YuanShaochen on 2017/12/11.
//  Copyright © 2017年 iGuest. All rights reserved.
//

import UIKit

class PreferenceChooseFoodTableViewController: UITableViewController {
    
    let food = ["Chinese food", "Japanese food", "Korean food", "American food", "Mexican food"]
    var foodSelected = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //foodSelectedString = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func foodSelectedButtonPressed(_ sender: Any) {
        print(foodSelected)
        performSegue(withIdentifier: "preFoodSelectToPre", sender: self)
 
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
