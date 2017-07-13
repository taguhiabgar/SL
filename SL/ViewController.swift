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
    
    var heights: [CGFloat] = []
    
    var tableView: UITableView!
    
    // contains models of all loaded discussions
    var discussions = [DiscussionContent]() {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    // shows index of file which will be loaded when requested
    var nextResourceIndex = 0
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // tableView basic setup
        tableView = UITableView(frame: view.frame)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        // register nib file
        tableView.register(UINib.init(nibName: Constants.discussionsTCNibName, bundle: nil), forCellReuseIdentifier: Constants.discussionsTCIdentifier)
        
        // configure row height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 70
        
        //        tableView.allowsSelection = false
        
        // read data from file
        perform(#selector(requestData), with: nil, afterDelay: 2.0)
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
        }
        return result
    }
    
    @objc fileprivate func requestData() {
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
                                self.discussions.append(contentsOf: result)
                                DispatchQueue.main.async {
                                    self.updateView()
                                }
                            }
                        }
                    } catch {
                        print(error)
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func updateView() {
        tableView.reloadData()
    }
    
    private func nextResourceName() -> String {
        let next = Constants.allResources[nextResourceIndex]
        nextResourceIndex += 1
        if nextResourceIndex == Constants.allResources.count {
            nextResourceIndex = 0
        }
        return next!
    }
    
}

// MARK: - TableView Delegate and Datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource, DiscussionsTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discussions.isEmpty ? 20 : discussions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.discussionsTCIdentifier)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // draw content on cell
        if indexPath.row < discussions.count {
            let discussionCell = cell as? DiscussionsTableViewCell
            discussionCell?.delegate = self
            discussionCell?.drawContent(content: self.discussions[indexPath.row], at: indexPath)
        }
        
        // activity indicator
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex { // last row is reached
            // create and show activity indicator
            let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
            // load next page after 2 seconds
            perform(#selector(requestData), with: nil, afterDelay: 2.0)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if discussions.count > Constants.responceLimitPerRequest {
            if indexPath.row < heights.count {
                return heights[indexPath.row]
            }
        }
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let cell = tableView.cellForRow(at: indexPath) as? DiscussionsTableViewCell {
//        }
    }
    
    // MARK: - DiscussionsTableViewCellDelegate
    
    func updateHeight(_ height: CGFloat, forCellAt indexPath: IndexPath) {
        if indexPath.row < heights.count {
            if heights[indexPath.row] != height {
                heights[indexPath.row] = height
            }
        } else {
            heights.append(height)
        }
    }
    
}
