//
//  ViewController.swift
//  BubbleTagView
//
//  Created by Michal Šimík on 11/13/2015.
//  Copyright (c) 2015 Michal Šimík. All rights reserved.
//

import UIKit
import BubbleTagView

class ViewController: UIViewController, BubbleTagViewDelegate {

    @IBOutlet weak var bubbleTagView: BubbleTagView! 
    @IBOutlet weak var pageControl: UIPageControl!
   
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items =  ["Cultura","Food","Sport","Travel", "Tag1", "Tag2", "Tag3", "Tag4", "Tag5", "Tag6", "Tag7", "Tag8", "Tag9", "Tag10", "Tag11", "Tag12", ]
        
        bubbleTagView.bubbleDelegate = self
        bubbleTagView.setHorizontalAlignment(.Center)
        bubbleTagView.cellColor = UIColor.greenColor()
        bubbleTagView.cellBorderColor = UIColor.blueColor()
        bubbleTagView.fontColor = UIColor.blueColor()

        bubbleTagView.allowsMultipleSelection = true
        
        // enable paging
        bubbleTagView.pagingEnabled = true
        bubbleTagView.showsHorizontalScrollIndicator = false
        
        bubbleTagView.setTags(items)        

        bubbleTagView.insets = UIEdgeInsetsMake(0, 5, 0, 5)
        
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bubbleTagView(bubbleTagView: BubbleTagView, didDeselectTagAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func bubbleTagView(bubbleTagView: BubbleTagView, didSelectTagAtIndexPath indexPath: NSIndexPath) {

    }
    
    func bubbleTagView(bubbleTagView: BubbleTagView, didChangeNumberOfPages numberOfPages:UInt) {
    
        pageControl.numberOfPages = Int(numberOfPages)
        
    }
    func bubbleTagView(bubbleTagView: BubbleTagView, didChangeCurrentPage currentPage:UInt) {
        
        pageControl.currentPage = Int(currentPage)
    
    }
}

