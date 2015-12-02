//
//  TagView.swift
//  tagCollectionView
//
//  Created by Michal Šimík on 12.11.15.
//  Copyright © 2015 Michal Šimík. All rights reserved.
//

import UIKit
import FSQCollectionViewAlignedLayout

public enum HorizontalAlignment {
    case Left
    case Center
    case Right
}


@IBDesignable public class BubbleTagView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var items:[String] =  []
    var hAlignment:FSQCollectionViewHorizontalAlignment = FSQCollectionViewHorizontalAlignment.Center
    private var sizingCell: BubbleTagViewCell!
    var cellColor = UIColor.blueColor()
    var font:UIFont?

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.collectionViewLayout = FSQCollectionViewAlignedLayout()
        self.customInit()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: FSQCollectionViewAlignedLayout())
        self.customInit()
        
    }
    
    func customInit() {
        self.sizingCell = BubbleTagViewCell(frame: CGRectMake(0, 0, 100, 25))
        self.backgroundColor = UIColor.whiteColor()
        var frame = self.bounds
        frame.size.height = CGFloat(25)
        
        
        self.registerClass(BubbleTagViewCell.self, forCellWithReuseIdentifier: "TagCell")
        
        self.dataSource = self
        self.delegate = self
        
        self.backgroundColor = UIColor.clearColor()
    }
    
    // MARK: - Designable
    
    public override func prepareForInterfaceBuilder() {
        self.setTags(["hashtag1", "hashtag2", "hashtag3"])
    }
    
    //MARK: -public API
    public func setTags(tags: [String]) {
        
        self.items = []
        for tag in tags where tag != ""{
                self.items.append("#\(tag)")
        }
        
        CATransaction.begin()
        CATransaction.setCompletionBlock { () -> Void in
            self.collectionViewLayout.invalidateLayout() // Invalidate layout
            self.invalidateIntrinsicContentSize(nil) // Invalidate intrinsic size
        }
        
        self.reloadData() // Reload collectionView
        CATransaction.commit()
    }
    
    public func setCellCollor(color:UIColor) {
        cellColor = color
        self.reloadData()
    }
    
    public func setHorizontalAlignment(horizontalAlignment: HorizontalAlignment){
        switch horizontalAlignment {
        case .Left:
            hAlignment = FSQCollectionViewHorizontalAlignment.Left
        case .Right:
            hAlignment = FSQCollectionViewHorizontalAlignment.Right
        case .Center:
            hAlignment = FSQCollectionViewHorizontalAlignment.Center
        }
        self.reloadData()
        
        
    }
    
    
    public func setFontForCel(font: UIFont) {
        self.font = font
    }
    
    //MARK: -layout attributes
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: FSQCollectionViewAlignedLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!, remainingLineSpace: CGFloat) -> CGSize {
        let item = self.items[indexPath.item]
        self.sizingCell.tagButton.setTitle(item, forState: .Normal)
        let size = self.sizingCell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        let maximumWidth = CGRectGetWidth(collectionView.bounds)

        return CGSizeMake(min(size.width, maximumWidth), BubbleTagViewConfiguration.cellHeight)
    }
    
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: FSQCollectionViewAlignedLayout!, attributesForSectionAtIndex sectionIndex: Int) -> FSQCollectionViewAlignedLayoutSectionAttributes! {
        
        let vAlignment:FSQCollectionViewVerticalAlignment = FSQCollectionViewVerticalAlignment.Center;
        return FSQCollectionViewAlignedLayoutSectionAttributes.withHorizontalAlignment(hAlignment, verticalAlignment: vAlignment)
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: FSQCollectionViewAlignedLayout!, attributesForCellAtIndexPath indexPath: NSIndexPath!) -> FSQCollectionViewAlignedLayoutCellAttributes! {
        return collectionViewLayout.defaultCellAttributes
    }
    
    // MARK:- Autolayout
    override public func intrinsicContentSize() -> CGSize {
        let size = (self.collectionViewLayout as! FSQCollectionViewAlignedLayout).collectionViewContentSize()
        return CGSizeMake(CGRectGetWidth(self.bounds),  size.height)
    }
    
    
    private func invalidateIntrinsicContentSize(completionBlock: (() -> ())?) {
        
        if self.intrinsicContentSize() != self.bounds.size {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.invalidateIntrinsicContentSize()
                
                }) { (finished) -> Void in
                    completionBlock?()
            }
        } else {
            completionBlock?()
        }
    }
    
    
    // MARK: -UICollectionViewDelegate and datasource
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TagCell", forIndexPath: indexPath) as! BubbleTagViewCell
        
        cell.tagButton.titleLabel!.text = self.items[indexPath.row]
        if let font = font {
            cell.tagButton.titleLabel!.font = font
        } else {
            cell.tagButton.titleLabel!.font = BubbleTagViewConfiguration.cellFont
        }
        
        cell.tagButton.titleLabel!.textColor = BubbleTagViewConfiguration.cellFontColor

        cell.tagButton.setTitle(self.items[indexPath.row], forState: .Normal)
        cell.backgroundColor = cellColor

        return cell
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
}
