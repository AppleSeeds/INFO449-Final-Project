//
//  SelfMode.swift
//  EatWithFriends
//
//  Created by 徐 翰洋 on 11/12/2017.
//  Copyright © 2017 iGuest. All rights reserved.
//

import Foundation

class SelfMode {
    private var firstName: String?
    private var lastName: String?
    private var id: String?
    private var fetchedFriend = [User]()
    private var foodLiked = [String]()
    private var foodHated = [String]()
    private var restLiked = [String]()
    private var restHated = [String]()

    init(url: String) {
        self.firstName = LoginViewController.GlobalVariable.myFirstName
        self.lastName = LoginViewController.GlobalVariable.myLastName
        self.id = LoginViewController.GlobalVariable.myUserId
        
        let A = User(name: "A", foodLiked: [], foodHated: [], restLiked: [], restHated: [])
        let B = User(name: "B", foodLiked: [], foodHated: [], restLiked: [], restHated: [])
        let C = User(name: "C", foodLiked: [], foodHated: [], restLiked: [], restHated: [])
        let D = User(name: "D", foodLiked: [], foodHated: [], restLiked: [], restHated: [])
        
        fetchedFriend.append(A)
        fetchedFriend.append(B)
        fetchedFriend.append(C)
        fetchedFriend.append(D)
        
        self.makeGetRequest(url: url)
    }
    
    func getFetchedFriend() -> [User]{
        return self.fetchedFriend
    }
    
    func getFoodLiked() -> [String] {
        return self.foodLiked
    }
    
    func getFoodHated() -> [String] {
        return self.foodHated
    }
    
    func getRestLiked() -> [String] {
        return self.restLiked
    }
    
    func getRestHated() -> [String] {
        return self.restHated
    }
    
////////////////////////////////// Http connection
    func makeGetRequest(url: String) {
        let url = URL(string: url)
        if url != nil {
            let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
                if (!Reachability.isConnectedToNetwork() || error != nil){
                    // Do nothing
                } else {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!) as! [AnyObject]
                        //self.buildQuiz(json: json )
                    } catch {
                        print (error)
                    }
                }
            }
            task.resume()
        }
    }
    
    /*
    private func buildSelf(json: [AnyObject]) {
        for obj in json {
            let quiz = obj as? [String:AnyObject]
            let title = quiz!["title"] as! String!
            let desc = quiz!["desc"] as! String!
            let newQuiz = Quiz(Name: title!, Description: desc!)
            
            var newQuestions = [Question]()
            let questions = quiz!["questions"] as! [AnyObject]!
            
            for questionObj in questions! {
                let question = questionObj as? [String:AnyObject]
                let text = question!["text"] as! String!
                let answer = Int((question!["answer"] as! String!))
                let answers = question!["answers"] as! [String]!
                newQuestions.append(Question(Question: text!, Opts: answers!,Answer: answer!))
            }
            self.quizzes[newQuiz] = newQuestions
        }
    }
    
    func makePostRequest() {
        
    }
    */
////////////////////////////////////////////////////////////////////////////////////////////////////
}
