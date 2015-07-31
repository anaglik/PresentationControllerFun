//
//  ANPresentationController.swift
//  PresentationControllerFun
//
//  Created by Andrzej Naglik on 11.05.2015.
//  Copyright (c) 2015 Andrzej Naglik. All rights reserved.
//

import UIKit

class ANPresentationController: UIPresentationController {
  
  let dimmingView = UIView()
  
  override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
    super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    dimmingView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
  }
  
  override func presentationTransitionWillBegin() {
    dimmingView.frame = containerView!.bounds
    
    if let containerView = self.containerView{
      containerView.insertSubview(dimmingView, atIndex: 0)
      dimmingView.translatesAutoresizingMaskIntoConstraints = false
      containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[dimmingView]|", options: NSLayoutFormatOptions(rawValue: 0),
                                                                                                       metrics: nil, views: ["dimmingView" : dimmingView]))
      containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[dimmingView]|", options: NSLayoutFormatOptions(rawValue: 0),
                                                                                                       metrics: nil, views: ["dimmingView" : dimmingView]))
    }
    
    presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ context in
      self.dimmingView.alpha = 1.0
    }, completion: nil)
  }
  
  override func dismissalTransitionWillBegin() {
    presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ context in
      self.dimmingView.alpha = 0.0
      }, completion: nil)
  }
  
  override func frameOfPresentedViewInContainerView() -> CGRect {
    return containerView!.bounds.rectByInsetting(dx: 20.0, dy: 20.0)
  }
}
