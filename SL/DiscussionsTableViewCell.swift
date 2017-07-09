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
    @IBOutlet weak var bottomStackView: UIStackView!
    
    @IBOutlet weak var tagsViewHeightConstraint: NSLayoutConstraint!
    
    
    // MARK: - Methods
    
    func drawContent(content: DiscussionContent) {
        votesLabel.text = "\(content.votesCount)"
        answersLabel.text = "\(content.answersCount)"
        titleLabel.text = content.title
        dateLabel.text = "\(content.date)"
        authorLabel.text = content.author
        
        // configure title label
        titleLabel.lineBreakMode = .byWordWrapping
//        titleLabel.sizeToFit()
        
        // tags view
        setupTagsView(with: content.tags)
        
        
        
        // NOTE: - height may vary here
        
    }
    
    private func setupTagsView(with tags: [String]) {
        // remove subviews
        for subview in tagsView.subviews {
            subview.removeFromSuperview()
        }
        
        var lastX: CGFloat = 0
        var lastY: CGFloat = 0
        
        // create labels
        for tag in tags {
            let tagLabel = UILabel()
            tagLabel.text = tag
            tagLabel.font = dateLabel.font
            tagLabel.sizeToFit()
            tagLabel.textColor = UIColor.white
            tagLabel.textAlignment = .center
            tagLabel.frame.size.width = tagLabel.intrinsicContentSize.width + 2 * Constants.discussionsTCTagTitleHorizontalMargin
            
            // for smooth scrolling
            tagLabel.backgroundColor = UIColor.clear
            tagLabel.layer.backgroundColor = Constants.discussionsTCTagColor.cgColor
            tagLabel.layer.cornerRadius = 4
            tagLabel.layer.masksToBounds = false
            tagLabel.layer.shouldRasterize = true
            tagLabel.layer.rasterizationScale = UIScreen.main.scale
            
            // calculate position of label
            if lastX + tagLabel.frame.width >= tagsView.frame.width {
                lastX = 0
                lastY += tagLabel.frame.height + Constants.discussionsTCTagsVerticalPadding
            }
            tagLabel.frame.origin = CGPoint(x: lastX, y: lastY)
            lastX += tagLabel.frame.width + Constants.discussionsTCTagsHorizontalPadding
            
            tagsView.addSubview(tagLabel)
        }
        setNeedsLayout()
        setNeedsUpdateConstraints()
//        tagsView.frame.size.height = 50.0
        tagsViewHeightConstraint.constant = 50
        updateConstraints()
//        tagsView.frame.size.height = lastY + tagLabels[0].frame.height
    }
}
