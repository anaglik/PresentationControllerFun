//
//  ANTransitioningObject.swift
//  PresentationControllerFun
//
//  Created by Andrzej Naglik on 13.05.2015.
//  Copyright (c) 2015 Andrzej Naglik. All rights reserved.
//

import UIKit


func DegreesToRadians(value:Double) -> Double {
  return value * M_PI / 180.0
}

class ANNavigationTransitioningObject: UIPercentDrivenInteractiveTransition{
  internal var operationType : UINavigationControllerOperation?
  internal var navigationController : UINavigationController?
  var isTransitioning = false
  
  convenience init(operationType operation: UINavigationControllerOperation?) {
    self.init()
    self.operationType = operation
  }
  
  func addGestureRecognizerToViewController(viewController: UIViewController){
    navigationController = viewController.navigationController
    
    if let view = navigationController?.view{
      let panGestureRecognier = UIScreenEdgePanGestureRecognizer(target: self, action: Selector("handleGesture:"))
      panGestureRecognier.edges = UIRectEdge.Left
      view.addGestureRecognizer(panGestureRecognier)
    }

  }
  
  func handleGesture(gestureRecognizer : UIScreenEdgePanGestureRecognizer){
    let viewTranslation = gestureRecognizer.translationInView(gestureRecognizer.view!.superview!)
    let velocity = gestureRecognizer.velocityInView(gestureRecognizer.view!.superview!)

    switch gestureRecognizer.state{
    case .Began:
      isTransitioning = true
      navigationController?.popViewControllerAnimated(true)
  
    case .Changed:
      let distanceToSwipe = CGRectGetWidth((gestureRecognizer.view?.frame)!)/2.0
      let const = CGFloat(fminf(fmaxf(Float(viewTranslation.x / distanceToSwipe), 0.0), 0.99))
      updateInteractiveTransition(const)

    case .Cancelled, .Ended:
      if(gestureRecognizer.state == .Cancelled || velocity.x > 0){
        finishInteractiveTransition()
      }else{
        cancelInteractiveTransition()
      }
      isTransitioning = false
    
    case .Failed:
      cancelInteractiveTransition()
      isTransitioning = false
    
    default:
      print("default reached")
    }
  }
  
  override func startInteractiveTransition(transitionContext: UIViewControllerContextTransitioning){
    super.startInteractiveTransition(transitionContext)
  }
  
}


// MARK : UIViewControllerAnimatedTransitioning

extension ANNavigationTransitioningObject : UIViewControllerAnimatedTransitioning{
  // This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
  // synchronize with the main animation.
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
    return 0.6
  }
  
  // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
  func animateTransition(transitionContext: UIViewControllerContextTransitioning){
    let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
    let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
    
    if let container = transitionContext.containerView(){
      container.addSubview(fromViewController!.view)
      container.addSubview(toViewController!.view)
    }
    
    var futureFromTransform : CATransform3D = CATransform3DIdentity
    let futureToTransform : CATransform3D = CATransform3DIdentity
    var toTransform : CATransform3D = CATransform3DIdentity
    
    let percentProgres : CGFloat = 1.0
  
    if(self.operationType == .Push){
      fromViewController?.view.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
      fromViewController?.view.frame.origin.x = 0
    
      futureFromTransform = CATransform3DMakeRotation(CGFloat(M_PI_2) * percentProgres, 0.0, 1.0, 0.0)
      futureFromTransform = CATransform3DTranslate(futureFromTransform, -10.0 * percentProgres, 0.0, -50.0 * percentProgres)
    
    
      toViewController?.view.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
      toViewController?.view.frame.origin.x = 0.0
      toViewController?.view.frame.origin.y = 0.0
    
      toTransform = CATransform3DMakeRotation(CGFloat(M_PI_2) * percentProgres, 0.0, 1.0, 0.0)
      toTransform = CATransform3DRotate(toTransform, CGFloat(DegreesToRadians(Double(10 * percentProgres))), 1.0, 0.0, 0.0)
      toTransform = CATransform3DTranslate(toTransform, 0, -200 * percentProgres, 150.0 * percentProgres)
      toViewController?.view.layer.transform = toTransform
    }else{
      toViewController?.view.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
      toViewController?.view.frame.origin.x = 0
      toViewController?.view.frame.origin.y = 0
      toTransform = CATransform3DMakeRotation(CGFloat(M_PI_2) * percentProgres, 0.0, 1.0, 0.0)
      toTransform = CATransform3DTranslate(toTransform, -10.0 * percentProgres, 0.0, -50.0 * percentProgres)
      toViewController?.view.layer.transform = toTransform
      
      
      fromViewController?.view.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
      fromViewController?.view.frame.origin.x = 0.0
      fromViewController?.view.frame.origin.y = 0.0
      futureFromTransform = CATransform3DMakeRotation(CGFloat(M_PI_2) * percentProgres, 0.0, 1.0, 0.0)
      futureFromTransform = CATransform3DRotate(futureFromTransform, CGFloat(DegreesToRadians(10)), 1.0, 0.0, 0.0)
      futureFromTransform = CATransform3DTranslate(futureFromTransform, 0, -200 * percentProgres, 150.0 * percentProgres)
    }
    
    var perspectiveTransform : CATransform3D = CATransform3DIdentity;
    let distance :CGFloat = 1200;
    perspectiveTransform.m34 = 1.0/(-distance);
    
    if let container = transitionContext.containerView(){
      container.layer.sublayerTransform = perspectiveTransform
    }
    
    UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
      fromViewController?.view.layer.transform = futureFromTransform
      toViewController?.view.layer.transform = futureToTransform
      }, completion: { (finished) -> Void in
        fromViewController?.view.layer.transform = CATransform3DIdentity
        toViewController?.view.layer.transform = CATransform3DIdentity
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    })
    
  }
  
  
}
