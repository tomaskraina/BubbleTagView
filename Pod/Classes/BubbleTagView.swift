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

public protocol BubbleTagViewDelegate {
    
    func bubbleTagView(bubbleTagView: BubbleTagView, didSelectTagAtIndexPath indexPath:NSIndexPath);
    func bubbleTagView(bubbleTagView: BubbleTagView, didDeselectTagAtIndexPath indexPath:NSIndexPath);
    func bubbleTagView(bubbleTagView: BubbleTagView, didChangeNumberOfPages numberOfPages:UInt)
    func bubbleTagView(bubbleTagView: BubbleTagView, didChangeCurrentPage currentPage:UInt)
    
}

extension BubbleTagViewDelegate {
    
    func bubbleTagView(bubbleTagView: BubbleTagView, didSelectTagAtIndexPath indexPath:NSIndexPath) {}
    func bubbleTagView(bubbleTagView: BubbleTagView, didDeselectTagAtIndexPath indexPath:NSIndexPath) {}
    func bubbleTagView(bubbleTagView: BubbleTagView, didChangeNumberOfPages numberOfPages:UInt) {}
    func bubbleTagView(bubbleTagView: BubbleTagView, didChangeCurrentPage currentPage:UInt) {}
}


public class BubbleTagView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    public var bubbleDelegate : BubbleTagViewDelegate?
    var items:[String] =  []
    var hAlignment:FSQCollectionViewHorizontalAlignment = FSQCollectionViewHorizontalAlignment.Center
    private var sizingCell: BubbleTagViewCell!
    
    public var cellColor : UIColor = BubbleTagViewConfiguration.cellBackgroundColor
    public var font:UIFont = BubbleTagViewConfiguration.cellFont
    public var fontColor:UIColor = BubbleTagViewConfiguration.cellFontColor
    public var cellBorderColor : UIColor?
    
    public var selectedFont : UIFont?
    public var selectedFontColor: UIColor?
    public var selectedCellColor: UIColor?
    public var selectedCellBorderColor : UIColor?
    public var insets : UIEdgeInsets? {
        didSet {
            if let insets = insets {
                self.sizingCell.insets = insets
                self.reloadData()
            }
        }
        
    }
    
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
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        self.backgroundColor = UIColor.clearColor()
    }
    
    // MARK: - Designable
    
    /*  public override func prepareForInterfaceBuilder() {
    self.setTags(["hashtag1", "hashtag2", "hashtag3"])
    }*/
    
    //MARK: -public API
    public func setTags(tags: [String]) {
        
        self.items = []
        for tag in tags where tag != ""{
            self.items.append("#\(tag)")
        }
        
        CATransaction.begin()
        CATransaction.setCompletionBlock { () -> Void in
            
            self.invalidateIntrinsicContentSize({ () -> () in
                self.setNeedsLayout()
                self.layoutIfNeeded()
            }) // Invalidate intrinsic size
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
        self.sizingCell.setText(item)
        let size = self.sizingCell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        let maximumWidth = CGRectGetWidth(collectionView.bounds)
        
        
        return CGSizeMake(min(size.width, maximumWidth),  size.height)
    }
    
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: FSQCollectionViewAlignedLayout!, attributesForSectionAtIndex sectionIndex: Int) -> FSQCollectionViewAlignedLayoutSectionAttributes! {
        
        let vAlignment:FSQCollectionViewVerticalAlignment = FSQCollectionViewVerticalAlignment.Center;
        return FSQCollectionViewAlignedLayoutSectionAttributes.withHorizontalAlignment(hAlignment, verticalAlignment: vAlignment)
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: FSQCollectionViewAlignedLayout!, attributesForCellAtIndexPath indexPath: NSIndexPath!) -> FSQCollectionViewAlignedLayoutCellAttributes! {
        return collectionViewLayout.defaultCellAttributes
    }
    
    var previousNumberOfPages: UInt?
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: FSQCollectionViewAlignedLayout!, didChangeNumberOfPages numberOfPages: UInt) {
        
        if previousNumberOfPages != numberOfPages {
            previousNumberOfPages = numberOfPages
            
            bubbleDelegate?.bubbleTagView(self, didChangeNumberOfPages:numberOfPages)
        }
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
        
        
        
        
        cell.notSelectedFont = font
        
        if let selectedFont = selectedFont {
            cell.selectedFont = selectedFont
        }
        
        cell.notSelectedColor = cellColor
        
        if let color = selectedCellColor {
            cell.selectedColor = color
        }
        
        cell.notSelectedFontColor = fontColor
        
        if let color = selectedFontColor {
            cell.selectedFontColor = color
        }
        
        cell.notSelectedBorderColor = cellBorderColor
        cell.selectedBorderColor = selectedCellBorderColor
        
        if let insets = insets {
            cell.insets = insets
        }
        
        cell.tagLabel.text = self.items[indexPath.row]
        
        
        return cell
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    public override func selectItemAtIndexPath(indexPath: NSIndexPath?, animated: Bool, scrollPosition: UICollectionViewScrollPosition) {
        super.selectItemAtIndexPath(indexPath, animated: animated, scrollPosition: scrollPosition);
        
    }
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        bubbleDelegate?.bubbleTagView(self, didSelectTagAtIndexPath: indexPath)
    }
    
    public func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
        bubbleDelegate?.bubbleTagView(self, didDeselectTagAtIndexPath: indexPath)
        
    }
    
    // MARK: - UIScrollViewDelegate
    
    var previousPage = 0
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if !pagingEnabled { return }
        
        let pageWidth = scrollView.bounds.size.width
        let fractionalPage = Double(scrollView.contentOffset.x / pageWidth)
        let currentPage = lround(fractionalPage)
        
        if (previousPage != currentPage) {
            previousPage = currentPage
            
            bubbleDelegate?.bubbleTagView(self, didChangeCurrentPage: UInt(currentPage))
        }
    }
}
