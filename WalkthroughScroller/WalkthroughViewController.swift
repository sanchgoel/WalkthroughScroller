//
//  ViewController.swift
//  WalkthroughScroller
//
//  Created by Sanchit Goel on 23/09/20.
//  Copyright © 2020 Sanchit Goel. All rights reserved.
//

import UIKit

public class WalkthroughViewController: UIViewController {

  // MARK: - Variables
  let walkthroughView = WalkthroughScroller()
  let pageControl = UIPageControl()
  
  // MARK: - Lifecycle Methods
  public override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Public Methods
  public func setupWalkthrough(images: [UIImage?], subText: [String]) {
    addWalkthroughView(images: images, subText: subText)
    addPageControl(pages: images.count)
  }
  
  // MARK: - Private Methods
  private func addWalkthroughView(images: [UIImage?], subText: [String]) {
    // Set walkthrough images
    walkthroughView.walkthroughImages = images
    walkthroughView.walkthroughText = subText
    
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
    pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
  }
}

extension WalkthroughViewController: UIScrollViewDelegate {
  
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let pageWidth = walkthroughView.scroller.frame.size.width
    let fractionalPage = walkthroughView.scroller.contentOffset.x / pageWidth
    let page = lround(Double(fractionalPage))
    self.pageControl.currentPage = page
    
    for (index, contraint) in walkthroughView.imgCenterXConstraints.enumerated() {
      contraint.constant = walkthroughView.scroller.contentOffset.x - (self.view.frame.width) * CGFloat(index)
    }
    self.view.layoutIfNeeded()
  }

  public func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                 withVelocity velocity: CGPoint,
                                 targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let kCellWidth = self.view.frame.width
    let kCellSpacing: CGFloat = 0
    let kMaxIndex: CGFloat = 4
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

