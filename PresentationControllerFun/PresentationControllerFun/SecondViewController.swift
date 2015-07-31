//
//  SecondViewController.swift
//  PresentationControllerFun
//
//  Created by Andrzej Naglik on 11.05.2015.
//  Copyright (c) 2015 Andrzej Naglik. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
  var imageView: UIImageView!
  
  lazy var modalTransitioning : UIViewControllerTransitioningDelegate = {
    var modalTransitioning = ANModalTransitioningObject()
    return modalTransitioning
  }()
  
  override func loadView() {
    let mainView = UIView(frame: UIScreen.mainScreen().bounds);
    mainView.backgroundColor = UIColor.whiteColor()
    view = mainView
    
    imageView = UIImageView(image: UIImage(named: "test-photo.png"))
    view.addSubview(imageView)
    
    let tapGesture = UITapGestureRecognizer(target: self, action: Selector("tapped:"))
    view.addGestureRecognizer(tapGesture)
    
    setupConstraints()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Image View"
    
    let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector("addTapped:"))
    self.navigationItem.rightBarButtonItem = addButton
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  deinit{
    
  }
  
  func tapped(sender :AnyObject){
    navigationController?.pushViewController(FirstViewController(), animated: true)
  }
  
  func addTapped(sender :AnyObject){
    let viewController = ThirdViewController(completionHandler: { [unowned self]  in
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    })
    let navController = UINavigationController(rootViewController: viewController)
    navController.modalPresentationStyle = .Custom
    navController.transitioningDelegate = self.modalTransitioning
    self.navigationController?.presentViewController(navController, animated: true, completion: nil)
  }
  
  func setupConstraints(){
    imageView.translatesAutoresizingMaskIntoConstraints = false
    let myViews = ["tableView" : imageView]
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: myViews))
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: myViews))
  }
}
