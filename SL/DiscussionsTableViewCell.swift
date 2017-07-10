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
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var tagsVerticalView: UIView!
    
    var tagsView: UIView!
    
    // MARK: - Methods
    
    func drawContent(content: DiscussionContent) {
        votesLabel.text = "\(content.votesCount)"
        answersLabel.text = "\(content.answersCount)"
        titleLabel.text = content.title.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        dateLabel.text = formattedDate(content.date)
        authorLabel.text = content.author
        
        // configure title label
        titleLabel.lineBreakMode = .byWordWrapping
        
        // tags view
        setupTagsView(with: content.tags)
        
        tagsVerticalView.addSubview(tagsView)
        // add contraints from top and bottom so that tagsVerticalView will have correct height
        let tagsViewConstraints: [NSLayoutConstraint] = [
            NSLayoutConstraint(item: self.tagsView, attribute: .top, relatedBy: .equal, toItem: tagsVerticalView, attribute: .top, multiplier: 1,
                               constant: 0),
            NSLayoutConstraint(item: self.tagsView, attribute: .bottom, relatedBy: .equal, toItem: tagsVerticalView, attribute: .bottom, multiplier: 1, constant: 0)
        ]
        self.addConstraints(tagsViewConstraints)
    }
    
    func formattedDate(_ date: Date) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.short
        dateformatter.timeStyle = DateFormatter.Style.short
        dateformatter.dateFormat = "MM/dd/yy h:mm a"
        let dateString = dateformatter.string(from: date)
        return dateString
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
        var tagsMaxY: CGFloat = 0
        
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
            if lastX + tagLabel.frame.width >= titleLabel.frame.width {
                lastX = 0
                lastY += tagLabel.frame.height + Constants.discussionsTCTagsVerticalPadding
            }
            tagLabel.frame.origin = CGPoint(x: lastX, y: lastY)
            lastX += tagLabel.frame.width + Constants.discussionsTCTagsHorizontalPadding
            tagsMaxY = tagLabel.frame.height + lastY
            
            tagsView.addSubview(tagLabel)
        }
        tagsView.frame.size.height = tagsMaxY
    }
}
