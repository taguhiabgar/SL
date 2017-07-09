//
//  Constants.swift
//  SL
//
//  Created by Taguhi Abgaryan on 7/8/17.
//  Copyright © 2017 Taguhi Abgaryan. All rights reserved.
//

import UIKit

class Constants {
    
    static let responceLimitPerRequest = 20
    
    static let allResources = [
        Bundle.main.path(forResource: "response1", ofType: "txt"),
        Bundle.main.path(forResource: "response2", ofType: "txt"),
        Bundle.main.path(forResource: "response3", ofType: "txt"),
    ]
    
    // MARK: - Discussions
    // TC stands for TableViewCell
    
    // cell
    
    static let emptyCellHeight: CGFloat = UIScreen.main.bounds.height * 0.2
    
    static let discussionsTCIdentifier = "discussionCell"
    
    static let discussionsTCNibName = "DiscussionsTableViewCell"
    
    static let discussionsTCTagColor = UIColor(red: 148.0 / 256.0, green: 200.0 / 256.0, blue: 141.0 / 256.0, alpha: 1.0)
    
    static let discussionsTCTagTitleHorizontalMargin: CGFloat = 3
    
    static let discussionsTCTagsHorizontalPadding: CGFloat = 5
    
    static let discussionsTCTagsVerticalPadding: CGFloat = 4
    
    //  values accessors
    
    static let discussionTitleKeyInJSON = "title"
    
    static let discussionTagsKeyInJSON = "tags"
    
    static let discussionVotesCountKeyInJSON = "votes"
    
    static let discussionAnswersCountKeyInJSON = "answers"
    
    static let discussionDateKeyInJSON = "date"
    
    static let discussionAuthorKeyInJSON = "userName"
    
    // default values
    
    static let discussionsDefaultTitleValue = ""
    
    static let discussionsDefaultTagsValue: [String] = []
    
    static let discussionsDefaultVotesValue = 0
    
    static let discussionsDefaultAnswersValue = 0
    
    static let discussionsDefaultDateValue = Date()
    
    static let discussionsDefaultAuthorValue = ""
    
}
