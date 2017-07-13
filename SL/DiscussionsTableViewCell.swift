//
//  DiscussionsTableViewCell.swift
//  SL
//
//  Created by Taguhi Abgaryan on 7/8/17.
//  Copyright © 2017 Taguhi Abgaryan. All rights reserved.
//

import UIKit

protocol DiscussionsTableViewCellDelegate {
    func updateHeight(_ height: CGFloat, forCellAt indexPath: IndexPath)
}

class DiscussionsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var delegate: DiscussionsTableViewCellDelegate?
    
    // left side
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    
    // right side
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    
    var tagsView: UIView!
    
    // MARK: - Methods
    
    func drawContent(content: DiscussionContent, at indexPath: IndexPath) {
        // clean cell before setting new content
        votesLabel.text = ""
        answersLabel.text = ""
        dateLabel.text = ""
        authorLabel.text = ""
        titleLabel.text = ""
//        for subview in tagsVerticalView.subviews {
//            subview.removeFromSuperview()
//        }
        
        // set new content
        votesLabel.text = "\(content.votesCount)"
        answersLabel.text = "\(content.answersCount)"
        dateLabel.text = String(describing: content.date) //formattedDate(content.date)
        authorLabel.text = content.author
        titleLabel.text = ""
        
        DispatchQueue.main.async {
            // title label
            self.titleLabel.text = content.title//.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//            self.titleLabel.lineBreakMode = .byWordWrapping
            // tags
            self.setupTags(from: content)
            
            self.delegate?.updateHeight(self.frame.height, forCellAt: indexPath)
        }
    }
    
    func getAttributedString(from string: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, string.characters.count))
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSMakeRange(0, string.characters.count))
        
        let regex = try! NSRegularExpression(pattern: "\\s", options: [])
        let matches = regex.matches(in: string, options: [], range: NSMakeRange(0, string.characters.count))
        for m in matches {
            attributedString.addAttribute(NSKernAttributeName, value: 6, range: m.range)
        }
        return NSAttributedString(attributedString: attributedString)
    }
    
    func setupTags(from content: DiscussionContent) {
        let string = content.tags.joined(separator: " ")
        tagsLabel.backgroundColor = UIColor.clear
        tagsLabel.attributedText = NSAttributedString(string: string)
//        textView.attributedText = getAttributedString(from: string)
//        
//        let pattern = "[^ ]"//"[^ ]+"
//        let regex = try! NSRegularExpression(pattern: pattern, options: [])
//        let matches = regex.matches(in: string, options: [], range: NSMakeRange(0, string.characters.count))
//        
//        for m in matches {
//            textView.addSubview({
//                let range = m.range
//                var frame = frameOfTextInRange(range: range, inTextView: textView)
//                frame = frame.insetBy(dx: CGFloat(-3), dy: CGFloat(2))
//                frame = frame.offsetBy(dx: CGFloat(0), dy: CGFloat(3))
//                let tag = UIView(frame: frame)
//                tag.layer.cornerRadius = 2
//                tag.backgroundColor = Constants.discussionsTCTagColor
//                return tag
//                }())
//        }
        
        tagsLabel.sizeToFit()
        
//        self.tagsVerticalView.addSubview(textView)
//        // add contraints from top and bottom so that tagsVerticalView will have correct height
//        let tagsViewConstraints: [NSLayoutConstraint] = [
//            NSLayoutConstraint(item: textView, attribute: .top, relatedBy: .equal, toItem: self.tagsVerticalView, attribute: .top, multiplier: 1, constant: 0),
//            NSLayoutConstraint(item: textView, attribute: .bottom, relatedBy: .equal, toItem: self.tagsVerticalView, attribute: .bottom, multiplier: 1, constant: 0)
//        ]
//        self.addConstraints(tagsViewConstraints)
    }
    
    func frameOfTextInRange(range:NSRange, inTextView textView:UITextView) -> CGRect {
        let beginning = textView.beginningOfDocument
        if let start = textView.position(from: beginning, offset: range.location) {
            if let end = textView.position(from: start, offset: range.length) {
                if let textRange = textView.textRange(from: start, to: end) {
                    let rect = textView.firstRect(for: textRange)
                    return textView.convert(rect, from: textView)
                }
            }
        }
        print("ERROR")
        return CGRect.zero
    }
    
    func formattedDate(_ date: Date) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.short
        dateformatter.timeStyle = DateFormatter.Style.short
        dateformatter.dateFormat = "MM/dd/yy h:mm a"
        let dateString = dateformatter.string(from: date)
        return dateString
    }
    
}

