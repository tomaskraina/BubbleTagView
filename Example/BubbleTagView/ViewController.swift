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
   
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items =  ["sport", "fashion", "party"]
        bubbleTagView.bubbleDelegate = self
        bubbleTagView.setHorizontalAlignment(.Center)
        bubbleTagView.cellColor = UIColor.greenColor()
        bubbleTagView.cellBorderColor = UIColor.blueColor()
        bubbleTagView.fontColor = UIColor.blueColor()

        bubbleTagView.allowsMultipleSelection = true    
        bubbleTagView.setTags(items)        


        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bubbleTagView(bubbleTagView: BubbleTagView, didDeselectTagAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func bubbleTagView(bubbleTagView: BubbleTagView, didSelectTagAtIndexPath indexPath: NSIndexPath) {

    }
}

