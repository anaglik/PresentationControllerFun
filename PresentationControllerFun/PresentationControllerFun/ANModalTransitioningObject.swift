//
//  ANModalTransitioningObject.swift
//  PresentationControllerFun
//
//  Created by Andrzej Naglik on 24.07.2015.
//  Copyright © 2015 Andrzej Naglik. All rights reserved.
//

import UIKit

class ANModalTransitioningObject: NSObject, UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
    return 0.6
  }
  
  // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
  func animateTransition(transitionContext: UIViewControllerContextTransitioning){
    
    if let presentedView = transitionContext.viewForKey(UITransitionContextToViewKey){
      presentedView.frame.origin.y = -presentedView.frame.size.height
      transitionContext.containerView()?.addSubview(presentedView)
      
      UIView.animateWithDuration(0.6, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5,
                                    options: UIViewAnimationOptions(rawValue: 0),
                                 animations: { context in
                                        presentedView.frame.origin.y = 0
                                 }, completion: { finished in
                                    transitionContext.completeTransition(true)
                                 })
      
    }
  }
}


// MARK : UIViewControllerTransitioningDelegate

extension ANModalTransitioningObject : UIViewControllerTransitioningDelegate{
  func presentationControllerForPresentedViewController(presented: UIViewController,
    presentingViewController presenting: UIViewController,
    sourceViewController source: UIViewController) -> UIPresentationController? {
      return ANPresentationController(presentedViewController: presented, presentingViewController: presenting)
  }
  
  
  func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController,
    sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      return self
  }
  
//  func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//    return self
//  }
}



