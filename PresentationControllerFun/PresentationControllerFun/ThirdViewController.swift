//
//  ThirdViewController.swift
//  PresentationControllerFun
//
//  Created by Andrzej Naglik on 24.07.2015.
//  Copyright © 2015 Andrzej Naglik. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
  
  let completionHander : (() -> Void)?
  let imageView : UIImageView
  
  init(completionHandler handler: (() -> Void)){
    completionHander = handler
    imageView = UIImageView(image: UIImage(named: "test-photo2.png"))
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    completionHander = nil
    imageView = UIImageView(image: UIImage(named: "test-photo2.png"))
    super.init(coder: aDecoder)
  }

  override func loadView() {
    let mainView = UIView(frame: UIScreen.mainScreen().bounds);
    mainView.backgroundColor = UIColor.whiteColor()
    view = mainView
    
    view.addSubview(imageView)
    imageView.contentMode = UIViewContentMode.ScaleAspectFit
    setupConstraints()
  }
  
  func setupConstraints(){
    imageView.translatesAutoresizingMaskIntoConstraints = false
    let myViews = ["imageView" : imageView]
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: myViews))
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: myViews))
  }


  override func viewDidLoad() {
    super.viewDidLoad()
    let closeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: Selector("closeTapped:"))
    self.navigationItem.rightBarButtonItem = closeButton
  }
  
  func closeTapped(sender: AnyObject){
    if let block = self.completionHander{
      block()
    }
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
    
}
