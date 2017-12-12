//
//  PreferenceChooseRestTableViewController.swift
//  EatWithFriends
//
//  Created by YuanShaochen on 2017/12/12.
//  Copyright © 2017年 iGuest. All rights reserved.
//

import UIKit

class PreferenceChooseRestTableViewController: UITableViewController {
    
    let restaurant = ["A", "B", "C", "D", "E"]//source data
    var restSelected = [String]()//result from user choice
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func restSelectionFinishButtonPress(_ sender: UIBarButtonItem) {
        print(restSelected)
        performSegue(withIdentifier: "restSelectionToPre", sender: self)
    }
    
    //after user selection and press button finished, segue is executed, and before execution, save result in global variables to transfer the data back to the preference screen.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationController = segue.destination as! PersonalVC
//        restSelectedString = restSelected.joined(separator: ", ")//put all selected food into one string.
        if(PersonalVC.PersonalPreferenceSettings.whichButton == "toSelectRestLike"){
            PersonalVC.PersonalPreferenceSettings.setSelectedRest = restSelected
        }else if(PersonalVC.PersonalPreferenceSettings.whichButton == "toSelectRestHate"){
            PersonalVC.PersonalPreferenceSettings.setSelectedRestHate = restSelected
        }
        
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurant.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "choosingRestCells", for: indexPath)
        cell.textLabel?.text = restaurant[indexPath.row]
        return cell
    }
    //setup table view with data
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
