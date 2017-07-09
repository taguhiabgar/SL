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
    
    @IBOutlet weak var rightView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagsView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    // stack views
    
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var tagsStackView: UIStackView!
    @IBOutlet weak var bottomStackView: UIStackView!
    
    
    // MARK: - Methods
    
    func drawContent(content: DiscussionContent) {
        votesLabel.text = "\(content.votesCount)"
        answersLabel.text = "\(content.answersCount)"
        titleLabel.text = content.title
        dateLabel.text = "\(content.date)"
        authorLabel.text = content.author
        
        // configure title label
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.sizeToFit()
        
        // tags view
//        setupTagsView(with: content.tags)
        
        
        
        // NOTE: - height may vary here
        
    }
    
    private func setupTagsView(with tags: [String]) {
        // remove subviews
//        for subview in tagsView.subviews {
//            subview.removeFromSuperview()
//        }
//        
//        var lastX: CGFloat = 0
//        var lastY: CGFloat = 0
        
        // create labels
        for tag in tags {
            let tagLabel = UILabel()
            tagLabel.layer.masksToBounds = true
            tagLabel.text = tag
            tagLabel.font = dateLabel.font
            tagLabel.sizeToFit()
            tagLabel.layer.cornerRadius = 4.0
            tagLabel.backgroundColor = Constants.discussionsTCTagColor
            tagLabel.textColor = UIColor.white
            tagLabel.textAlignment = .center
            tagLabel.frame.size.width = tagLabel.intrinsicContentSize.width + 2 * Constants.discussionsTCTagTitleHorizontalMargin
            // calculate position of label
//            if lastX + tagLabel.frame.width >= tagsView.frame.width {
//                lastX = 0
//                lastY += tagLabel.frame.height + Constants.discussionsTCTagsVerticalPadding
//            }
//            tagLabel.frame.origin = CGPoint(x: lastX, y: lastY)
//            lastX += tagLabel.frame.width + Constants.discussionsTCTagsHorizontalPadding
            
            tagsView.addSubview(tagLabel)
        }
        setNeedsLayout()
        setNeedsUpdateConstraints()
//        tagsView.frame.size.height = lastY + tagLabels[0].frame.height
    }
}
