//
//  WalkthroughScroller.swift
//  WalkthroughScroller
//
//  Created by Sanchit Goel on 23/09/20.
//  Copyright © 2020 Sanchit Goel. All rights reserved.
//

import UIKit

class WalkthroughScroller: UIView {
  
  // Walkthrough Components
  var walkthroughImages = [UIImage?]()
  var walkthroughImageViews = [UIImageView]()
  var walkthroughText = [String]()
  
  let scroller = UIScrollView()
  let stackView = UIStackView()
  let ctaButton = UIButton()
  let kScreenWidth = UIScreen.main.bounds.width
  let kScreenHeight = UIScreen.main.bounds.height
  
  // Background colors
  var bgColors = [UIColor(hex: "#EE5233"),
                  UIColor(hex: "#2570D2"),
                  UIColor(hex: "#20BE6B"),
                  UIColor(hex: "#EEAB33")]
  
  // Image properties
  var imgAspectRatio = CGFloat(264.0/520.0)
  var imgCenterYConstant: CGFloat = -80.0
  var imgWidthMultiplier: CGFloat = 0.6
  var imgMinTopAnchor: CGFloat = 20.0
  var imgCenterXConstraints = [NSLayoutConstraint]()
  
  // Subtext properties
  var subtextFontColor = UIColor.white
  var subtextFont = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
  var subtextBottomSpacing: CGFloat = 130.0
  var subtextWidth: CGFloat = 265.0
  
  // CTA Button properties
  var ctaText = "PROCEED"
  var ctaBtnFont = UIFont(name: "HelveticaNeue-Bold", size: 14.0)
  var ctaBtnColor = UIColor.white
  var ctaBtnBottomSpacing: CGFloat = 50.0
  var ctaBtnSize: CGSize = CGSize(width: 130.0, height: 40.0)
  
  func setupUIForWalkthrough() {
    addScroller()
    addStackViewToScroller()
    addWalkthorughViewsToStackView()
    addCTABtn()
  }
  
  func addScroller() {
    // Add and setup scroller
    self.addSubview(scroller)
    scroller.translatesAutoresizingMaskIntoConstraints = false
    
    scroller.backgroundColor = UIColor.yellow
    scroller.bounces = false
    scroller.bouncesZoom = false
    scroller.showsHorizontalScrollIndicator = false
    scroller.contentInsetAdjustmentBehavior = .never
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
                                                multiplier: imgWidthMultiplier).isActive = true
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
    subTextLabel.font = subtextFont
    subTextLabel.textColor = subtextFontColor
    subTextLabel.textAlignment = .center
    subTextLabel.numberOfLines = 0
    
    subTextLabel.translatesAutoresizingMaskIntoConstraints = false
    walkthroughView.addSubview(subTextLabel)
    
    // Add Constraints
    subTextLabel.widthAnchor.constraint(equalToConstant: subtextWidth).isActive = true
    subTextLabel.bottomAnchor.constraint(equalTo: walkthroughView.bottomAnchor,
                                         constant: -subtextBottomSpacing).isActive = true
    subTextLabel.centerXAnchor.constraint(equalTo: walkthroughView.centerXAnchor).isActive = true
    
    return walkthroughView
  }
  
  func addCTABtn() {
    self.addSubview(ctaButton)
    ctaButton.translatesAutoresizingMaskIntoConstraints = false
    
    ctaButton.isHidden = true
    ctaButton.layer.cornerRadius = ctaBtnSize.height/2.0
    ctaButton.layer.borderWidth = 1.8
    ctaButton.layer.borderColor = ctaBtnColor.cgColor
    ctaButton.titleLabel?.font = ctaBtnFont
    ctaButton.titleLabel?.textColor = ctaBtnColor
    ctaButton.setTitle(ctaText, for: .normal)
    
    ctaButton.widthAnchor.constraint(equalToConstant: ctaBtnSize.width).isActive = true
    ctaButton.heightAnchor.constraint(equalToConstant: ctaBtnSize.height).isActive = true
    ctaButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    ctaButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                      constant: -ctaBtnBottomSpacing).isActive = true        
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
