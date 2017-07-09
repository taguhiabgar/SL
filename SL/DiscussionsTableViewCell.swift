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
    
    // left side 
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    
    // right side
    
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagsView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    // MARK: - Methods
    
    func drawContent(content: DiscussionContent) {
        votesLabel.text = "\(content.votesCount)"
        answersLabel.text = "\(content.answersCount)"
        titleLabel.text = content.title + content.title + content.title + content.title
        dateLabel.text = "\(content.date)"
        authorLabel.text = content.author
        // NOTE: - height may vary here
        
    }
    
    private func drawTag() -> UILabel {
        let tagLabel = UILabel()
        tagLabel.layer.masksToBounds = false
        //        tagLabel.layer.cornerRadius = 4.0
        tagLabel.backgroundColor = UIColor.shadowOfGreen()
        return tagLabel
    }
}
