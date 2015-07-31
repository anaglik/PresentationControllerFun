//
//  UIViewController+Transition.swift
//  PresentationControllerFun
//
//  Created by Andrzej Naglik on 13.05.2015.
//  Copyright (c) 2015 Andrzej Naglik. All rights reserved.
//

import UIKit

extension UIViewController : UINavigationControllerDelegate{

  func setupInteractiveTransitioning() {
    if(navigationController?.delegate == nil){
      navigationController?.delegate = self
    }
  }
  
}

