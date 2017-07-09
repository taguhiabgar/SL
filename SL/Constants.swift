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
    
    static let discussionsTableViewCellIdentifier = "discussionCell"
    
    static let discussionsTableViewCellNibName = "DiscussionsTableViewCell"
    
    static let emptyCellHeight: CGFloat = UIScreen.main.bounds.height * 0.2
    
    static let allResources = [
        Bundle.main.path(forResource: "response1", ofType: "txt"),
        Bundle.main.path(forResource: "response2", ofType: "txt"),
        Bundle.main.path(forResource: "response3", ofType: "txt"),
    ]
    
    // MARK: - Discussions
    
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
