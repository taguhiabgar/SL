//
//  DiscussionContent.swift
//  SL
//
//  Created by Taguhi Abgaryan on 7/8/17.
//  Copyright © 2017 Taguhi Abgaryan. All rights reserved.
//

import Foundation


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
    
    
}
