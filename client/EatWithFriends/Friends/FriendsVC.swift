//
//  FriendsVC.swift
//  EatWithFriends
//
//  Created by ​ on 12/4/17.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit

class FriendsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var userSelf: SelfMode?
    
    @IBAction func AddFriend(_ sender: Any) {
        let score = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newfriendvc") as! AddFriendViewController
        score.modalPresentationStyle = .popover
        if let pop = score.popoverPresentationController {
            pop.delegate = self
            pop.permittedArrowDirections = .down
            pop.sourceView = sender as! UIButton
            pop.sourceRect = (sender as! UIButton).bounds
        }
        self.present(score, animated: true) { }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    var words = [String]()
    var wordsSection = [String]()
    var wordsDict = [String:[String]]()
    
    func generateWordsDict() {
        let globelSelf = self.tabBarController as! tabBarController
        if (globelSelf.userSelf != nil) {
            self.userSelf = globelSelf.userSelf
        }
        words = getNameList(userList: (self.userSelf?.getFetchedFriend())!)
        for word in words {
            let key = "\(word[word.startIndex])"
            let upper = key.uppercased()
            
            if var wordValues = wordsDict[upper] {
                wordValues.append(word)
                wordsDict[upper] = wordValues
            } else {
                wordsDict[upper] = [word]
            }
        }
        
        wordsSection = [String](wordsDict.keys)
        wordsSection = wordsSection.sorted()
    }
    
    // Get all names from the user list
    private func getNameList(userList: [User]) -> [String] {
        var result = [String]()
        for user in userList {
            result.append(user.name)
        }
        return result
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return wordsSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let wordKey = wordsSection[section]
        if let wordValues = wordsDict[wordKey] {
            return wordValues.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as? FriendsCell else {
            fatalError("The de-queued cell is not an instance of FriendsCell.")
        }
        let wordKey = wordsSection[indexPath.section]
        if let wordValues = wordsDict[wordKey.uppercased()] {
            cell.name.text = wordValues[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return wordsSection[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return wordsSection
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let index = wordsSection.index(of: title) else {
            return -1
        }
        return index
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateWordsDict()
        
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
