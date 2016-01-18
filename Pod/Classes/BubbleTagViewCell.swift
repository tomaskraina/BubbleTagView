//
//  TagViewCell.swift
//  tagCollectionView
//
//  Created by Michal Šimík on 12.11.15.
//  Copyright © 2015 Michal Šimík. All rights reserved.
//

import UIKit

class BubbleTagViewCell: UICollectionViewCell {
    
    var tagLabel: UILabel!
    var customConstraints: [NSLayoutConstraint] = []
    
    var insets : UIEdgeInsets = BubbleTagViewConfiguration.inset {
        didSet(newInsets) {
            
        }
        
    }
    
    var notSelectedFont : UIFont = BubbleTagViewConfiguration.cellFont {
        willSet(font) {
            
            if (!selected) {
                self.tagLabel!.font = font
            }
            
        }
        
    }
    
    var notSelectedFontColor : UIColor = BubbleTagViewConfiguration.cellFontColor {
        willSet(color) {
            if (!selected) {
                self.tagLabel!.textColor = color
            }
        }
    }
    
    
    var notSelectedColor : UIColor = BubbleTagViewConfiguration.cellBackgroundColor {
        willSet(color) {
            if (!selected) {
                self.backgroundColor = color
            }
        }
    }
    
    var notSelectedBorderColor : UIColor? {
        didSet(color) {
            setBorders(selected)
        }
    }
    
    var selectedFont : UIFont = BubbleTagViewConfiguration.cellFont {
        willSet(font) {
            if (selected) {
                self.tagLabel!.font = font
            }
        }
        
    }
    
    var selectedFontColor : UIColor = BubbleTagViewConfiguration.cellFontColor {
        willSet(color) {
            if (selected) {
                self.tagLabel!.textColor = color
            }
        }
    }
    var selectedColor : UIColor = BubbleTagViewConfiguration.cellBackgroundColor {
        willSet(color) {
            if (selected) {
                self.backgroundColor = color
            }
        }
    }
    
    var selectedBorderColor : UIColor? {
        willSet(color) {
            setBorders(selected)
        }
    }
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    
    func commonInit() {
       
        // Setup label
        self.tagLabel = UILabel()
        self.contentView.addSubview(self.tagLabel)
        self.setupConstraintsForLabel()
        self.tagLabel.textAlignment = .Center
        
        self.layer.cornerRadius = CGRectGetHeight(self.layer.frame) / 2
        self.layer.masksToBounds = true
    }
    
    func setupConstraintsForLabel() {
        self.tagLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["label": self.tagLabel]
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[label]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[label(22)]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: views)
        
        self.contentView.addConstraints(horizontalConstraints)
        self.contentView.addConstraints(verticalConstraints)
    }
    
    
    override var selected : Bool {
        willSet(selected) {
            if (selected) {
                self.tagLabel!.font = selectedFont
                self.tagLabel!.textColor = selectedFontColor
                self.backgroundColor = selectedColor
            } else {
                self.tagLabel!.font = notSelectedFont
                self.tagLabel!.textColor = notSelectedFontColor
                self.backgroundColor = notSelectedColor
            }
            setBorders(selected)
        }
    }
    
    private func setBorders(selected : Bool ) {
        
        
        if (selected) {
            
            if let color = selectedBorderColor?.CGColor {
                addBordersWithColor(color)
            } else {
                removeBorders()
            }
        } else {
            
            
            if let color = notSelectedBorderColor?.CGColor {
                addBordersWithColor(color)
            } else {
                removeBorders()
            }
            
        }
        
    }
    
    private func addBordersWithColor(color : CGColor) {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = color
    }
    
    private func removeBorders() {
        self.layer.borderWidth = 0.0
    }
    
    
    func setText(text:String) {
        tagLabel.text = text
        tagLabel.sizeToFit()
    }
}
