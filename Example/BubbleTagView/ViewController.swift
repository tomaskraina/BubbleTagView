//
//  ViewController.swift
//  BubbleTagView
//
//  Created by Michal Šimík on 11/13/2015.
//  Copyright (c) 2015 Michal Šimík. All rights reserved.
//

import UIKit
import BubbleTagView

class ViewController: UIViewController {

    @IBOutlet weak var bubbleTagView: BubbleTagView!
   
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items =  ["sport", "fashion", "party"]
        bubbleTagView.setTags(items)
        bubbleTagView.setHorizontalAlignment(.Left)
        bubbleTagView.setCellCollor(UIColor.blackColor())
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

