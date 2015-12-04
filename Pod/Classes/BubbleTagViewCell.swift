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
    var tagLabel : UILabel!
    
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
        willSet(color) {
            
            guard let color = color?.CGColor else  {
                removeBorders()
                return
            }
        
            if (selected) {
                addBordersWithColor(color)
            }
            
            
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
            
            guard let color = color?.CGColor else  {
                removeBorders()
                return
            }
            
            
            
            if (selected) {
                addBordersWithColor(color)
            }
            
            
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
        }
        
        didSet(selected) {
            setBorders()
        }
    }
    
    private func setBorders() {
        
        
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
        
        let views = ["field": self.tagLabel]
        
        tagLabel.textAlignment = .Center
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[field]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[field]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: views)
        
        self.contentView.addConstraints(horizontalConstraints)
        self.contentView.addConstraints(verticalConstraints)
        
        self.tagLabel.contentMode = UIViewContentMode.Center
    }
    
    


}
