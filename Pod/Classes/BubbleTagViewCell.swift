//
//  TagViewCell.swift
//  tagCollectionView
//
//  Created by Michal Šimík on 12.11.15.
//  Copyright © 2015 Michal Šimík. All rights reserved.
//

import UIKit


class BubbleTagViewCell: UICollectionViewCell {
    
    var tagButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    
    func commonInit() {
        self.layer.cornerRadius = self.layer.frame.height/2
        self.layer.masksToBounds = true
        
        self.tagButton = UIButton()
        self.tagButton.translatesAutoresizingMaskIntoConstraints = false

        tagButton.sizeToFit()

        contentView.addSubview(self.tagButton)
        
        let views = ["field": self.tagButton]
        
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[field]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[field]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: views)
        
        self.contentView.addConstraints(horizontalConstraints)
        self.contentView.addConstraints(verticalConstraints)
        
        self.tagButton.contentMode = UIViewContentMode.Left
    }

}
