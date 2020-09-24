//
//  ViewController.swift
//  WalkthroughScroller
//
//  Created by Sanchit Goel on 23/09/20.
//  Copyright © 2020 Sanchit Goel. All rights reserved.
//

import UIKit

protocol WalkthorughScrollerDelegate: class {
  func ctaBtnDidTap()
}

public class WalkthroughViewController: UIViewController {

  // MARK: - Variables
  private let walkthroughView = WalkthroughScroller()
  private let pageControl = UIPageControl()
  private var pageControlBottomSpacing: CGFloat = 50.0
  private var numberOfPages = 4
  
  weak var delegate: WalkthorughScrollerDelegate?
  
  // MARK: - Lifecycle Methods
  public override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Public Methods
  public func setupWalkthrough(images: [UIImage?], subtext: [String]) {
    addWalkthroughView(images: images, subtext: subtext)
    addPageControl(pages: images.count)
    numberOfPages = images.count
    walkthroughView.ctaButton.addTarget(self, action: #selector(ctaBtnAction), for: .touchUpInside)
  }
  
  public func setBgColors(colors: [UIColor?]) {
    walkthroughView.bgColors = colors
  }
  
  public func setImageProperties(aspectRatio: CGFloat,
                                 centerYConstant: CGFloat,
                                 minTopAnchor: CGFloat,
                                 widthMultiplier: CGFloat) {
    walkthroughView.imgAspectRatio = aspectRatio
    walkthroughView.imgCenterYConstant = centerYConstant
    walkthroughView.imgMinTopAnchor = minTopAnchor
    walkthroughView.imgWidthMultiplier = widthMultiplier
  }
  
  public func setLabelProperties(font: UIFont? = UIFont(name: "HelveticaNeue-Bold", size: 20.0),
                                 color: UIColor,
                                 width: CGFloat,
                                 bottomSpacing: CGFloat) {
    walkthroughView.subtextFont = font
    walkthroughView.subtextFontColor = color
    walkthroughView.subtextWidth = width
    walkthroughView.subtextBottomSpacing = bottomSpacing
  }
  
  public func setCTABtnProperties(text: String,
                                  size: CGSize,
                                  font: UIFont? = UIFont(name: "HelveticaNeue-Bold", size: 14.0),
                                  bottomSpacing: CGFloat,
                                  color: UIColor) {
    walkthroughView.ctaText = text
    walkthroughView.ctaBtnSize = size
    walkthroughView.ctaBtnFont = font
    walkthroughView.ctaBtnBottomSpacing = bottomSpacing
    walkthroughView.ctaBtnColor = color
  }
  
  public func setPageControlBottomSpacing(bottomSpace: CGFloat) {
    self.pageControlBottomSpacing = bottomSpace
  }
  
  // MARK: - Private Methods
  private func addWalkthroughView(images: [UIImage?], subtext: [String]) {
    // Set walkthrough images
    walkthroughView.walkthroughImages = images
    walkthroughView.walkthroughText = subtext
    
    // Add walkthrough view to controller
    self.view.addSubview(walkthroughView)
    walkthroughView.translatesAutoresizingMaskIntoConstraints = false

    // Add Constraints to walkthrough view
    walkthroughView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    walkthroughView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    walkthroughView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    walkthroughView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    
    // Call Setup UI method
    walkthroughView.setupUIForWalkthrough()
    walkthroughView.scroller.delegate = self
    walkthroughView.setDefaultConstraints()
  }
  
  private func addPageControl(pages: Int) {
    // Add page control to view
    self.view.addSubview(pageControl)
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    pageControl.numberOfPages = pages
    
    // Set Constraints
    pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,
                                        constant: -pageControlBottomSpacing).isActive = true
  }
  
  @objc func ctaBtnAction(sender: UIButton!) {
    delegate?.ctaBtnDidTap()
  }
}

extension WalkthroughViewController: UIScrollViewDelegate {
  
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let pageWidth = walkthroughView.scroller.frame.size.width
    let fractionalPage = walkthroughView.scroller.contentOffset.x / pageWidth
    let page = lround(Double(fractionalPage))
    self.pageControl.currentPage = page
    
    if page == numberOfPages - 1 {
      self.pageControl.isHidden = true
      self.walkthroughView.ctaButton.isHidden = false
    } else {
      self.pageControl.isHidden = false
      self.walkthroughView.ctaButton.isHidden = true
    }
    
    for (index, contraint) in walkthroughView.imgCenterXConstraints.enumerated() {
      contraint.constant = walkthroughView.scroller.contentOffset.x
                           - (self.view.frame.width) * CGFloat(index)
    }
    self.view.layoutIfNeeded()
  }

  public func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                 withVelocity velocity: CGPoint,
                                 targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let kCellWidth = self.view.frame.width
    let kCellSpacing: CGFloat = 0
    let kMaxIndex = CGFloat(numberOfPages)
    let targetX: CGFloat = scrollView.contentOffset.x + velocity.x * 10.0
    var targetIndex: CGFloat = 0.0
    if (velocity.x > 0) {
        targetIndex = ceil(targetX / (kCellWidth + kCellSpacing))
    } else if (velocity.x == 0) {
        targetIndex = round(targetX / (kCellWidth + kCellSpacing))
    } else if (velocity.x < 0) {
        targetIndex = floor(targetX / (kCellWidth + kCellSpacing))
    }
    if (targetIndex < 0) {
      targetIndex = 0
    }
    if (targetIndex > kMaxIndex) {
      targetIndex = kMaxIndex
    }
    targetContentOffset.pointee.x = targetIndex * (kCellWidth + kCellSpacing)
  }

  public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let pageWidth = walkthroughView.scroller.frame.size.width
    let fractionalPage = walkthroughView.scroller.contentOffset.x / pageWidth
    let page = lround(Double(fractionalPage))

    let endPoint = CGPoint(x: pageWidth*CGFloat(page), y: 0)
    walkthroughView.scroller.setContentOffset(endPoint, animated: true)
  }
}

