//
//  DiscussionsTableViewCell.swift
//  SL
//
//  Created by Taguhi Abgaryan on 7/8/17.
//  Copyright © 2017 Taguhi Abgaryan. All rights reserved.
//

import UIKit

class DiscussionsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var tags: [UILabel]?
    var votes: UILabel?
    var title: UILabel?
    var comments: UILabel?
    var date: UILabel?
    var author: UILabel?
    
    // MARK: - Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawEmptyContent()
        // add tags
        let tag1 = drawTag()
        tag1.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.25, height: 20)
        let tag2 = drawTag()
        tag2.frame = CGRect(x: UIScreen.main.bounds.width * 0.5, y: 0, width: UIScreen.main.bounds.width * 0.25, height: 20)
        addSubview(tag1)
        addSubview(tag2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("No support for NSCoding")
    }
    
    // MARK: - Methods
    
    func drawEmptyContent() {
        votes = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width * (1.0 / 6.0), height: frame.height * 0.5))
        votes?.backgroundColor = UIColor.lightGray
    }
    
    func drawContent(content: DiscussionContent) {
        
        
        
    }
    
    private func drawTag() -> UILabel {
        let tagLabel = UILabel()
        tagLabel.layer.masksToBounds = false
        //        tagLabel.layer.cornerRadius = 4.0
        tagLabel.backgroundColor = UIColor.shadowOfGreen()
        return tagLabel
    }
    
}

class DiscussionContent {
    
    // MARK: - Properties
    
    var votesCount: Int
    var tags: [String]
    var answersCount: Int
    var title: String
    var date: Date
    var author: String
    
    // MARK: - Initializers
    
    init(title: String, tags: [String], votesCount: Int, answersCount: Int, date: Date, author: String) {
        self.votesCount = votesCount
        self.tags = tags
        self.title = title
        self.answersCount = answersCount
        self.date = date
        self.author = author
    }
    
    // MARK: - Methods
    
    static func random() -> DiscussionContent {
        let randomTitles = [
            "What is Javascript?",
            "Hello there. Anyone using C#?",
            "Ask me anything",
            "Let's hangout",
            "I am looking for the fastest sorting algorithm. Any suggestions?",
            "Sorry for a newbie question, but I'm stuck and really need for your help. How do I resize a UILabel in iOS10 Swift3?",
            "Anyone with experience in Swift4.0?"
        ]
        
        let randomTags = [
            "Javascript",
            "SQL",
            "Go",
            "Rust",
            "HTML",
            "CSS",
            "iOS",
            "Objective-C",
            "Swift",
            "Swift 3.0",
            "Swift 4.0",
            "Android",
            "Java",
            "React Native",
            "Javascript Frameworks",
            ]
        
        let randomDates = [
            Date()
        ]
        
        let randomAuthors = [
            "Adam",
            "Mark",
            "Anonym",
            "Mila",
            "Marie",
            "Robert",
        ]
        
        let title = randomTitles[Int(arc4random()) % randomTitles.count]
        let votes = Int(arc4random()) % 256
        let answers = Int(arc4random()) % 256
        let date = randomDates[Int(arc4random()) % randomTitles.count]
        let author = randomAuthors[Int(arc4random()) % randomTitles.count]
        // pick random tags
        var tags: [String] = []
        let tagsCount = Int(arc4random()) % randomTitles.count
        for _ in 0..<tagsCount {
            let tag = randomTags[Int(arc4random()) % randomTitles.count]
            tags.append(tag)
        }
        
        return DiscussionContent(title: title, tags: tags, votesCount: votes, answersCount: answers, date: date, author: author)
    }
    
}

extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat(arc4random() % 256) / 256.0
        let green = CGFloat(arc4random() % 256) / 256.0
        let blue = CGFloat(arc4random() % 256) / 256.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    static func shadowOfGreen() -> UIColor {
        let red: CGFloat = 0
        let green: CGFloat = CGFloat(arc4random() % 256) / 256.0
        let blue: CGFloat = 0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

// JSON object example

//    {"userName":"P R",
//    "hasAvatar":true,
//    "level":11,
//    "xp":7561,
//    "vote":0,
//    "index":0,
//    "isFollowing":false,
//    "tags":["Nikolay","records"],
//    "id":480659,
//    "parentID":null,
//    "userID":5026965,
//    "courseID":null,
//    "title":"Needed help to complete my code",
//    "message":"I continuously update my code of Nickolay Nachev I still don't know :\nlost in c++\nlost in js \nlost in Java \nlost in python\nhere is the code\nhttps://code.sololearn.com/Wt75r9Bht1OG/?ref=app",
//    "date":"2017-06-21T06:55:27.77",
//    "isAccepted":false,
//    "votes":9,
//    "ordering":0,
//    "answers":5},
