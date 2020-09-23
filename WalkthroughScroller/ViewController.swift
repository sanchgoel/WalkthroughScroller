//
//  ViewController.swift
//  WalkthroughScroller
//
//  Created by Sanchit Goel on 23/09/20.
//  Copyright © 2020 Sanchit Goel. All rights reserved.
//

import UIKit

class ViewController: WalkthroughViewController {  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let images = [UIImage(named: "screen1"),
                  UIImage(named: "screen2"),
                  UIImage(named: "screen3"),
                  UIImage(named: "screen4")]
    
    let subText = ["READ, WATCH & LISTEN TO SHORT STORIES WITH YOUR CHILD",
                   "SPEND GOOD SCREEN TIME WITH YOUR CHILD AND EARN POINTS",
                   "DO 10 MINUTE SKILL BASED ACTIVITIES WITH YOUR CHILD",
                   "BUILD A DAILY READING HABIT WITH LEVELISED NEWS"]
    
    self.setupWalkthrough(images: images,
                          subText: subText)    
  }
}
