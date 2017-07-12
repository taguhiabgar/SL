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
    dateLabel.text = formattedDate(content.date)
    authorLabel.text = content.author
    
//    DispatchQueue.main.async {
      // configure title label
      self.titleLabel.text = content.title.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
      self.titleLabel.lineBreakMode = .byWordWrapping
      
      // tags view
//      self.setupTagsView(with: content.tags)
//      
//      self.tagsVerticalView.addSubview(self.tagsView)
//      // add contraints from top and bottom so that tagsVerticalView will have correct height
//      let tagsViewConstraints: [NSLayoutConstraint] = [
//        NSLayoutConstraint(item: self.tagsView, attribute: .top, relatedBy: .equal, toItem: self.tagsVerticalView, attribute: .top, multiplier: 1,
//                           constant: 0),
//        NSLayoutConstraint(item: self.tagsView, attribute: .bottom, relatedBy: .equal, toItem: self.tagsVerticalView, attribute: .bottom, multiplier: 1, constant: 0)
//      ]
//      self.addConstraints(tagsViewConstraints)
//    }
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
      
      tagLabel.layer.drawsAsynchronously = true
      
      tagLabel.layer.isOpaque = true
      tagLabel.text = tag
      tagLabel.font = dateLabel.font
      tagLabel.sizeToFit()
      tagLabel.textColor = UIColor.white
      tagLabel.textAlignment = .center
      tagLabel.frame.size.width = tagLabel.intrinsicContentSize.width + 2 * Constants.discussionsTCTagTitleHorizontalMargin
      
      // for smooth scrolling
      tagLabel.backgroundColor = Constants.discussionsTCTagColor
      tagLabel.layer.backgroundColor = UIColor.white.cgColor
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
  
//  func f() {
//    // setup text handling
//    var textStorage = NSTextStorage(attributedString: NSAttributedString(string: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu"))
//    
//    textStorage.addLayoutManager(NSLayoutManager())
//    var textContainer = NSTextContainer(size: <#T##CGSize#>)
//    
//  }
  
}
  
//  // use our subclass of NSLayoutManager
//  MyLayoutManager *textLayout = [[MyLayoutManager alloc] init];
//  
//  [textStorage addLayoutManager:textLayout];
//  
//  NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:self.view.bounds.size];
//  
//  [textLayout addTextContainer:textContainer];
//  UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0,20,self.view.bounds.size.width,self.view.bounds.size.height-20)
//  textContainer:textContainer];
//  [self.view addSubview:textView];
//  
//  // set some background color to our text
//  [textView.textStorage setAttributes:[NSDictionary dictionaryWithObject:[UIColor blueColor] forKey:NSBackgroundColorAttributeName] range:NSMakeRange(22, textView.text.length - 61)];
//}
//@end
//
//@interface MyLayoutManager : NSLayoutManager
//@end
//
//- (void)fillBackgroundRectArray:(const CGRect *)rectArray count:(NSUInteger)rectCount forCharacterRange:(NSRange)charRange color:(UIColor *)color
//{
//  CGFloat halfLineWidth = 4.; // change this to change corners radius
//  
//  CGMutablePathRef path = CGPathCreateMutable();
//  
//  if (rectCount == 1
//    || (rectCount == 2 && (CGRectGetMaxX(rectArray[1]) < CGRectGetMinX(rectArray[0])))
//    )
//  {
//    // 1 rect or 2 rects without edges in contact
//    
//    CGPathAddRect(path, NULL, CGRectInset(rectArray[0], halfLineWidth, halfLineWidth));
//    if (rectCount == 2)
//    CGPathAddRect(path, NULL, CGRectInset(rectArray[1], halfLineWidth, halfLineWidth));
//  }
//  else
//  {
//    // 2 or 3 rects
//    NSUInteger lastRect = rectCount - 1;
//    
//    CGPathMoveToPoint(path, NULL, CGRectGetMinX(rectArray[0]) + halfLineWidth, CGRectGetMaxY(rectArray[0]) + halfLineWidth);
//    
//    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rectArray[0]) + halfLineWidth, CGRectGetMinY(rectArray[0]) + halfLineWidth);
//    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rectArray[0]) - halfLineWidth, CGRectGetMinY(rectArray[0]) + halfLineWidth);
//    
//    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rectArray[0]) - halfLineWidth, CGRectGetMinY(rectArray[lastRect]) - halfLineWidth);
//    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rectArray[lastRect]) - halfLineWidth, CGRectGetMinY(rectArray[lastRect]) - halfLineWidth);
//    
//    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rectArray[lastRect]) - halfLineWidth, CGRectGetMaxY(rectArray[lastRect]) - halfLineWidth);
//    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rectArray[lastRect]) + halfLineWidth, CGRectGetMaxY(rectArray[lastRect]) - halfLineWidth);
//    
//    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rectArray[lastRect]) + halfLineWidth, CGRectGetMaxY(rectArray[0]) + halfLineWidth);
//    
//    CGPathCloseSubpath(path);
//  }
//  
//  [color set]; // set fill and stroke color
//  
//  CGContextRef ctx = UIGraphicsGetCurrentContext();
//  CGContextSetLineWidth(ctx, halfLineWidth * 2.);
//  CGContextSetLineJoin(ctx, kCGLineJoinRound);
//  
//  CGContextAddPath(ctx, path);
//  CGPathRelease(path);
//  
//  CGContextDrawPath(ctx, kCGPathFillStroke);
//}
//
