//
//  UIColor.swift
//  SL
//
//  Created by Taguhi Abgaryan on 7/8/17.
//  Copyright © 2017 Taguhi Abgaryan. All rights reserved.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat(arc4random() % 256) / 256.0
        let green = CGFloat(arc4random() % 256) / 256.0
        let blue = CGFloat(arc4random() % 256) / 256.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    static func shadowOfGreen() -> UIColor {
        let red: CGFloat = 0
        let green: CGFloat = CGFloat(arc4random() % 256) / 256.0
        let blue: CGFloat = 0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
