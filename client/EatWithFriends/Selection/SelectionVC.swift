//
//  SelectionVC.swift
//  EatWithFriends
//
//  Created by ​ on 12/3/17.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit

class SelectionVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let data = [["Search for Friends", "Create a Dummy"], ["Friend One", "Friend Two", "Friend Three"]]
    let titles = ["Section One", "Section Two"]

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SelectionCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SelectionCell else {
            fatalError("The de-queued cell is not an instance of SelectionCell.")
        }
        cell.label.adjustsFontSizeToFitWidth = true
        cell.label.text = data[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < titles.count {
            return titles[section]
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let score = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sfvc") as! SearchFriendVC
            score.modalPresentationStyle = .popover
            if let pop = score.popoverPresentationController {
                pop.delegate = self
                pop.sourceView = tableView
            }
            self.present(score, animated: true) { }
        } else if indexPath.row == 1 {
            let score = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "dvc") as! DummyVC
            score.modalPresentationStyle = .popover
            if let pop = score.popoverPresentationController {
                pop.delegate = self
                pop.sourceView = tableView
            }
            self.present(score, animated: true) { }
        }
    }

    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
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
