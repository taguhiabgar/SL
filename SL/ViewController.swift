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
    var discussions = [DiscussionContent]() // contains models of all loaded discussions
    var nextResourceIndex = 0 // shows index of file which will be loaded when requested
    var lastPage = 0 // shows page number of discussions loaded last time
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // tableView setup
        tableView = UITableView(frame: view.frame)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        // register nib file
        tableView.register(UINib.init(nibName: Constants.discussionsTableViewCellNibName, bundle: nil), forCellReuseIdentifier: Constants.discussionsTableViewCellIdentifier)
        
        // read data from file
        perform(#selector(requestData), with: nil, afterDelay: 2.0)
//        requestData()
    }
    
    // MARK: - Methods
    
    private func convertToDiscussions(array: Array<Dictionary<String, Any>>) -> Array<DiscussionContent> {
        var result: Array<DiscussionContent> = []
        for dictionary in array {
            let title = dictionary[Constants.discussionTitleKeyInJSON] as? String ?? Constants.discussionsDefaultTitleValue
            let tags = dictionary[Constants.discussionTagsKeyInJSON] as? [String] ?? Constants.discussionsDefaultTagsValue
            let votesCount = dictionary[Constants.discussionVotesCountKeyInJSON] as? Int ?? Constants.discussionsDefaultVotesValue
            let answersCount = dictionary[Constants.discussionAnswersCountKeyInJSON] as? Int ?? Constants.discussionsDefaultAnswersValue
            let date = dictionary[Constants.discussionDateKeyInJSON] as? Date ?? Constants.discussionsDefaultDateValue
            let author = dictionary[Constants.discussionAuthorKeyInJSON] as? String ?? Constants.discussionsDefaultAuthorValue
            let content = DiscussionContent(title: title, tags: tags, votesCount: votesCount, answersCount: answersCount, date: date, author: author)
            result.append(content)
            print(author)
        }
        return result
    }
    
    @objc private func requestData() { // only 1/3 file is being read
        // create a concurrent queue and perform data requesting inside it
        let queue = DispatchQueue.init(label: "", qos: DispatchQoS.background, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.never, target: nil)
        queue.async {
            let path = self.nextResourceName()
            do {
                let text = try String(contentsOfFile: path)
                if let objectData = text.data(using: String.Encoding.utf8) {
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: objectData, options: JSONSerialization.ReadingOptions.mutableContainers)
                        if let outerDictionary = jsonObject as? Dictionary<String, Any> {
                            if let array = outerDictionary["posts"] as? Array<Dictionary<String, Any>> {
                                let result = self.convertToDiscussions(array: array)
                                self.discussions = result
                                DispatchQueue.main.async {
                                    self.updateData()
                                }
                            }
                        }
                    } catch {
                        print(error) // not handled
                    }
                }
            } catch {
                print(error) // not handled
            }
        }
    }
    
    private func updateData() {
        tableView.reloadData()
    }
    
    private func nextResourceName() -> String {
        let next = Constants.allResources[nextResourceIndex]
        nextResourceIndex += 1
        if nextResourceIndex < Constants.allResources.count {
            nextResourceIndex = 0
        }
        return next!
    }
}

// MARK: - TableView Delegate and Datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discussions.isEmpty ? 20 : discussions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.discussionsTableViewCellIdentifier)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // not implemented
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row < discussions.count {
            let discussionCell = cell as? DiscussionsTableViewCell
            discussionCell?.drawContent(content: discussions[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.emptyCellHeight
    }
}
