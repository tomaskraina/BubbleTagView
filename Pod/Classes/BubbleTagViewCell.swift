//
//  TagViewCell.swift
//  tagCollectionView
//
//  Created by Michal Šimík on 12.11.15.
//  Copyright © 2015 Michal Šimík. All rights reserved.
//

import UIKit

import SnapKit
class BubbleTagViewCell: UICollectionViewCell {
    
    var tagButton: UIButton!
    var tagLabel : UILabel!
    
    var topBottomConstraints : [NSLayoutConstraint] = []
    var leftRightConstraints : [NSLayoutConstraint] = []
    
    var insets : UIEdgeInsets = BubbleTagViewConfiguration.inset {
        didSet(newInsets) {
            
            //  self.contentView.removeConstraints(leftRightConstraints)
            // self.contentView.removeConstraints(topBottomConstraints)
            
            // self.tagLabel.removeConstraints(self.tagLabel.constraints)
            //            self.updateContstraints()
            
            
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
        self.layer.borderWidth = 4.0
        
        self.tagLabel = UILabel()
        
        self.tagLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tagLabel.sizeToFit()
        
        contentView.addSubview(self.tagLabel)
        //        updateContstraints()
        
        tagLabel.textAlignment = .Center
        
        
        
        
        self.tagLabel.contentMode = UIViewContentMode.Center
    }
    
    func setText(text:String) {
        tagLabel.text = text
        tagLabel.sizeToFit()
        
        // self.setNeedsLayout()
        //self.layoutIfNeeded()
    }
    
    //    func updateContstraints ()  {
    //
    //
    //        tagLabel.snp_remakeConstraints(closure: { make -> Void in
    //            make.edges.equalTo(contentView).inset(insets)
    //        })
    //        
    //        
    //   
    //        
    //        
    //        
    //    
    //
    //    }
    
}
