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
    var tagsView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bottomStackView: UIStackView!
    
    @IBOutlet weak var tagsVerticalStackView: UIStackView!
    
    
    
    var cellHeight: CGFloat = 0
    
    private var tagsMaxY: CGFloat = 0
    
    // MARK: - Methods
    
    func drawContent(content: DiscussionContent) {
        votesLabel.text = "\(content.votesCount)"
        answersLabel.text = "\(content.answersCount)"
        titleLabel.text = content.title.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        dateLabel.text = "\(content.date)"
        authorLabel.text = content.author
        
        // configure title label
        titleLabel.lineBreakMode = .byWordWrapping
//        titleLabel.sizeToFit()
        
        // tags view
        setupTagsView(with: content.tags)
        
        cellHeight = tagsMaxY + titleLabel.frame.height + bottomStackView.frame.height
        
        
        tagsView.frame = CGRect(x: 0, y: 0, width: titleLabel.frame.width, height: tagsMaxY)
//        tagsView.frame.size.height = tagsMaxY
        
        tagsVerticalStackView.addArrangedSubview(tagsView)
        
        // NOTE: - height may vary here
        
    }
    
    private func setupTagsView(with tags: [String]) {
        // remove subviews
        if tagsView != nil {
            for subview in tagsView.subviews {
                subview.removeFromSuperview()
            }
        } else {
            tagsView = UIView()
        }
        
        
        var lastX: CGFloat = 0
        var lastY: CGFloat = 0
        
        // create labels
        for tag in tags {
            let tagLabel = UILabel()
            tagLabel.text = tag
//            tagLabel.font = dateLabel.font
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
            if lastX + tagLabel.frame.width >= titleLabel.frame.width {
                lastX = 0
                lastY += tagLabel.frame.height + Constants.discussionsTCTagsVerticalPadding
            }
            tagLabel.frame.origin = CGPoint(x: lastX, y: lastY)
            lastX += tagLabel.frame.width + Constants.discussionsTCTagsHorizontalPadding
            tagsMaxY = tagLabel.frame.height + lastY
            
            tagsView.addSubview(tagLabel)
        }
        setNeedsLayout()
        setNeedsUpdateConstraints()
        updateConstraints()
    }
}
