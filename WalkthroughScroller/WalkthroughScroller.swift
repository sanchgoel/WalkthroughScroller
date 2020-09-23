//
//  WalkthroughScroller.swift
//  WalkthroughScroller
//
//  Created by Sanchit Goel on 23/09/20.
//  Copyright © 2020 Sanchit Goel. All rights reserved.
//

import UIKit

class WalkthroughScroller: UIView {

  var bgColors = [UIColor(hex: "#EE5233"),
                  UIColor(hex: "#2570D2"),
                  UIColor(hex: "#20BE6B"),
                  UIColor(hex: "#EEAB33")]
  
  var imgAspectRatio = CGFloat(264.0/520.0)
  var imgCenterYConstant: CGFloat = -80.0
  var imgMinTopAnchor: CGFloat = 20.0
  
  var walkthroughImages = [UIImage?]()
  var walkthroughText = [String]()
  
  var imgCenterXConstraints = [NSLayoutConstraint]()
  
  var walkthroughImageViews = [UIImageView]()
  
  let scroller = UIScrollView()
  let stackView = UIStackView()
  let kScreenWidth = UIScreen.main.bounds.width
  let kScreenHeight = UIScreen.main.bounds.height
  
  func setupUIForWalkthrough() {
    addScroller()
    addStackViewToScroller()
    addWalkthorughViewsToStackView()
  }
  
  func addScroller() {
    // Add and setup scroller
    self.addSubview(scroller)
    scroller.translatesAutoresizingMaskIntoConstraints = false
    
    scroller.backgroundColor = UIColor.yellow
    scroller.bounces = false
    scroller.bouncesZoom = false
    scroller.showsHorizontalScrollIndicator = false
    scroller.decelerationRate = UIScrollView.DecelerationRate.fast

    // Add Constraints to scroller
    scroller.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    scroller.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    scroller.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    scroller.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
  }
  
  func addStackViewToScroller() {
    // Add stack view to scroller
    scroller.addSubview(stackView)
    
    // Setup stack view
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 0
    stackView.backgroundColor = UIColor.red

    // Add constraints of stack view
    stackView.leadingAnchor.constraint(equalTo: scroller.leadingAnchor).isActive = true
    stackView.topAnchor.constraint(equalTo: scroller.topAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: scroller.trailingAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: scroller.bottomAnchor).isActive = true
  }
  
  func addWalkthorughViewsToStackView() {
    for count in 0..<walkthroughImages.count {
      let walkthroughView = setupWalkthroughView(index: count)
      
      stackView.addArrangedSubview(walkthroughView)
      
      walkthroughView.heightAnchor.constraint(equalTo: scroller.heightAnchor).isActive = true
      walkthroughView.widthAnchor.constraint(equalTo: scroller.widthAnchor).isActive = true
    }
  }
  
  func setupWalkthroughView(index: Int) -> UIView {
    let walkthroughView = UIView()
    
    walkthroughView.backgroundColor = bgColors[index]
    walkthroughView.clipsToBounds = true
    
    // Add Walkthorugh Image
    let walkthroughImageView = UIImageView()
    walkthroughImageView.image = walkthroughImages[index]
    walkthroughImageView.contentMode = .scaleAspectFit
    
    walkthroughImageView.translatesAutoresizingMaskIntoConstraints = false
    walkthroughView.addSubview(walkthroughImageView)
    
    // Add constraints
    walkthroughImageView.widthAnchor.constraint(equalTo: walkthroughView.widthAnchor,
                                                multiplier: 0.6).isActive = true
    walkthroughImageView.heightAnchor.constraint(equalTo: walkthroughImageView.widthAnchor,
                                                multiplier: 1/imgAspectRatio).isActive = true
    
    walkthroughImageView.centerXAnchor.constraint(equalTo: walkthroughView.centerXAnchor).isActive = true
    walkthroughImageView.centerYAnchor.constraint(equalTo: walkthroughView.centerYAnchor,
                                                  constant: imgCenterYConstant).isActive = true
    
    walkthroughImageView.topAnchor.constraint(greaterThanOrEqualTo: walkthroughView.topAnchor,
                                              constant: imgMinTopAnchor).isActive = true
        
    walkthroughImageViews.append(walkthroughImageView)
    
    // Add Walkthrough Subtext
    let subTextLabel = UILabel()
    subTextLabel.text = walkthroughText[index]
    subTextLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
    subTextLabel.textColor = UIColor.white
    subTextLabel.textAlignment = .center
    subTextLabel.numberOfLines = 0
    
    subTextLabel.translatesAutoresizingMaskIntoConstraints = false
    walkthroughView.addSubview(subTextLabel)
    
    // Add Constraints
    subTextLabel.widthAnchor.constraint(equalToConstant: 265.0).isActive = true
    subTextLabel.bottomAnchor.constraint(equalTo: walkthroughView.bottomAnchor,
                                         constant: -130.0).isActive = true
    subTextLabel.centerXAnchor.constraint(equalTo: walkthroughView.centerXAnchor).isActive = true
        
    return walkthroughView
  }
  
  func setDefaultConstraints() {
    for (index, imageView) in walkthroughImageViews.enumerated() {
      if let constraint = imageView.superview?.constraints.filter({ $0.firstAttribute == .centerX}).first {
        constraint.constant = -(kScreenWidth) * CGFloat((index))
        imgCenterXConstraints.append(constraint)
      }      
    }
    self.layoutIfNeeded()
  }
}
