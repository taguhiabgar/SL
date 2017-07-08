//
//  ViewController.swift
//  SL
//
//  Created by Taguhi Abgaryan on 7/8/17.
//  Copyright © 2017 Taguhi Abgaryan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var tableView: UITableView!
    var discussions = [DiscussionContent]()
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // tableView setup
        tableView = UITableView(frame: view.frame)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        discussions = requestData()
        
        self.tableView.reloadData()
    }
    
    // MARK: - Methods
    
    private func convertToDiscussions(array: Array<Dictionary<String, Any>>) -> Array<DiscussionContent> {
            var result: Array<DiscussionContent> = []
            for dictionary in array {
                let content = DiscussionContent(title: "", tags: [], votesCount: 0, answersCount: 0, date: Date(), author: "")
                content.title = dictionary["title"] as? String ?? ""
                content.tags = dictionary["tags"] as? [String] ?? []
                content.votesCount = dictionary["votes"] as? Int ?? 0
                content.answersCount = dictionary["answers"] as? Int ?? 0
                content.date = dictionary["date"] as? Date ?? Date()
                content.author = dictionary["userName"] as? String ?? ""
                result.append(content)
            }
            return result
    }
    
    public func requestData() -> [DiscussionContent] {
        let path = Bundle.main.path(forResource: "response1", ofType: "txt")
        do {
            let text = try String(contentsOfFile: path!)
            if let objectData = text.data(using: String.Encoding.utf8) {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: objectData, options: JSONSerialization.ReadingOptions.mutableContainers)
                    if let outerDictionary = jsonObject as? Dictionary<String, Any> {
                        if let array = outerDictionary["posts"] as? Array<Dictionary<String, Any>> {
                            let result = convertToDiscussions(array: array)
                            return result
                        }
                    }
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
        
//        let responseObject: Data = Data()
//        self.discussions = self.convertToArrayOfDictionaries(response: responseObject)
        
        return []
        
    }
    
    private func updateData() {
        tableView.reloadData()
    }
}

// MARK: - TableView Delegate and Datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 500 // discussions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let discussion = discussions[indexPath.row]
        let cell = DiscussionsTableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let discussionsCell = cell as! DiscussionsTableViewCell
//        dcell.drawContent(content: DiscussionContent(title: <#T##String#>, tags: <#T##[String]#>, votesCount: <#T##Int#>, answersCount: <#T##Int#>, date: <#T##Date#>, author: <#T##String#>))
        
    }
}








