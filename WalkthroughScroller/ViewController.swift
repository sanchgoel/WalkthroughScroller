//
//  ViewController.swift
//  WalkthroughScroller
//
//  Created by Sanchit Goel on 23/09/20.
//  Copyright © 2020 Sanchit Goel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()    
  }
    
  // Add this code where you have to present/push walkthrough
  @IBAction func presentBtnTapped(_ sender: Any) {
    let images = [UIImage(named: "screen1"),
                  UIImage(named: "screen2"),
                  UIImage(named: "screen3"),
                  UIImage(named: "screen4")]
    
    let subtext = ["READ, WATCH & LISTEN TO SHORT STORIES WITH YOUR CHILD",
                   "SPEND GOOD SCREEN TIME WITH YOUR CHILD AND EARN POINTS",
                   "DO 10 MINUTE SKILL BASED ACTIVITIES WITH YOUR CHILD",
                   "BUILD A DAILY READING HABIT WITH LEVELISED NEWS"]
       
    pushWalkthroughContoller(images: images, subtext: subtext)
  }
  
  // Add this method to present walkthrough controller
  func presentWalkthroughContoller(images: [UIImage?],
                                   subtext: [String]) {
    let walkthroughController = WalkthroughViewController()
    walkthroughController.setupWalkthrough(images: images, subtext: subtext)
    walkthroughController.modalPresentationStyle = .fullScreen
    walkthroughController.delegate = self
    self.present(walkthroughController, animated: true, completion: nil)
  }
  
  // Add this method to push walkthrough controller
  func pushWalkthroughContoller(images: [UIImage?],
                                subtext: [String]) {
    let walkthroughController = WalkthroughViewController()
    walkthroughController.setupWalkthrough(images: images, subtext: subtext)
    walkthroughController.modalPresentationStyle = .fullScreen
    walkthroughController.delegate = self
    self.navigationController?.pushViewController(walkthroughController, animated: true)
  }
  
  // For customImplementation use this
  func pushCustomWalkthroughContoller(images: [UIImage?],
                                      subtext: [String]) {
    let walkthroughController = WalkthroughViewController()
    walkthroughController.setupWalkthrough(images: images, subtext: subtext)
    walkthroughController.modalPresentationStyle = .fullScreen
    walkthroughController.delegate = self        
    
    // Set Bg Colors
    let colors = [UIColor(hex: "#EE5233"),
                  UIColor(hex: "#2570D2"),
                  UIColor(hex: "#20BE6B"),
                  UIColor(hex: "#EEAB33")]
    walkthroughController.setBgColors(colors: colors)
    
    // Set Custom Image properties
    // Aspect ratio example 1:5 would be CGFloat(1/5)
    // centerYConstant add constant to center vertical constraint
    // MinTopAnchor is the minimum distance of image from top of superview
    // image has equal width to that of parent view, modify this with help of this multiplier
    walkthroughController.setImageProperties(aspectRatio: CGFloat(1/5),
                                             centerYConstant: -80.0,
                                             minTopAnchor: 20,
                                             widthMultiplier: 0.6)
    
    // Set subtext properties
    walkthroughController.setLabelProperties(color: UIColor.white,
                                             width: 265.0,
                                             bottomSpacing: 130.0)
    
    // Set CTA btn properties
    walkthroughController.setCTABtnProperties(text: "PROCEED",
                                              size: CGSize(width: 130.0,
                                                           height: 40.0),
                                              font: UIFont(name: "HelveticaNeue-Bold",
                                                           size: 14.0),
                                              bottomSpacing: 50.0,
                                              color: UIColor.white)
    
    // Set page control bottom space
    walkthroughController.setPageControlBottomSpacing(bottomSpace: 50.0)
    
    self.navigationController?.pushViewController(walkthroughController, animated: true)
  }
}

extension ViewController: WalkthorughScrollerDelegate {
  func ctaBtnDidTap() {
    // Handle CTA btn tap
    print("CTA btn tapped")
  }
}
