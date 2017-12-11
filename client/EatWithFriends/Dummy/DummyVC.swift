//
//  DummyVC.swift
//  EatWithFriends
//
//  Created by ​ on 12/4/17.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit

protocol DummyViewControllerDelegate {
    func appendFriend(friend : String)
}

class DummyVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    var delegate : DummyViewControllerDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var data = [["Add Name"], ["Add the food you love", "Add the food you hate", "Add the restaurent you love", "Add the restaurent you hate"]]
    let titles = ["Add Information", "Add Preference"]
    
    // Update table to display added friend
    @IBAction func finish(_ sender: Any) {
        if (self.delegate) != nil {
            self.delegate?.appendFriend(friend: "Success!")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell else {
                fatalError("The de-queued cell is not an instance of SelectionCell.")
            }
            cell.label.adjustsFontSizeToFitWidth = true
            cell.label.text = data[indexPath.section][indexPath.row]
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PrefCell", for: indexPath) as? PrefCell else {
                fatalError("The de-queued cell is not an instance of SelectedFriendsCell.")
            }
            cell.label.adjustsFontSizeToFitWidth = true
            cell.label.text = data[indexPath.section][indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < titles.count {
            return titles[section]
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
