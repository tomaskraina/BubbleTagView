//
//  TagViewConfiguration.swift
//  tagCollectionView
//
//  Created by Michal Šimík on 12.11.15.
//  Copyright © 2015 Michal Šimík. All rights reserved.
//

import Foundation

public class BubbleTagViewConfiguration {
    /// View insets
    public static var inset: UIEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5)
    
    /// Height for item
    public static var cellHeight: CGFloat = 22.0
    
    // Tag button label font
    public static var cellFont = UIFont.avenirHeavyFontOfSize(12)
    
    // Tag button label font color
    public static var cellFontColor = UIColor.whiteColor()
    
    //Tag button background color
    public static var cellBackgroundColor = UIColor.oceanBlue()
    
    //Tag button height
    
}

extension UIFont {
    class func avenirHeavyFontOfSize(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Heavy", size: fontSize)!
    }
    
}


extension UIColor {
    class func oceanBlue() -> UIColor {
        return UIColor(red: 0.000, green: 0.792, blue: 0.910, alpha: 1.00)
    }
    
}