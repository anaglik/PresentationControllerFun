//
//  FirstViewController.swift
//  PresentationControllerFun
//
//  Created by Andrzej Naglik on 05.05.2015.
//  Copyright (c) 2015 Andrzej Naglik. All rights reserved.
//

import UIKit

let cellIdentifier = "cellIdentifier"

class FirstViewController: UIViewController {
  
  let transitioningObject = ANNavigationTransitioningObject()
  
  lazy var tableView: UITableView = {
    var tableView = UITableView(frame: CGRectZero, style: .Plain)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    return tableView
  }()
  
  override func loadView() {
    let mainView = UIView(frame: UIScreen.mainScreen().bounds);
    mainView.backgroundColor = UIColor.whiteColor()
    view = mainView
    
    view.addSubview(tableView)
    setupConstraints()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "List Controller"
    setupInteractiveTransitioning()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  deinit{
    
  }
  
  func setupConstraints(){
    tableView.translatesAutoresizingMaskIntoConstraints = false
    let myViews = ["tableView" : tableView]
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0),
                                                                                          metrics: nil, views: myViews))
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0),
                                                                                          metrics: nil, views: myViews))
  }
}

// MARK : table view data source

extension FirstViewController : UITableViewDataSource{
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20;
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell
    cell.textLabel?.text = "Text \(indexPath.row+1)"
    return cell
  }
}

// MARK : table view delegate methods

extension FirstViewController : UITableViewDelegate{
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) -> Void{
    let secondViewController = SecondViewController()
    
    navigationController?.pushViewController(secondViewController, animated: true)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}

extension FirstViewController{

  func navigationController(navigationController: UINavigationController,
    animationControllerForOperation operation: UINavigationControllerOperation,
    fromViewController fromVC: UIViewController,
    toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      if(operation == .Push){
        transitioningObject.addGestureRecognizerToViewController(toVC)
      }
      transitioningObject.operationType = operation
      return transitioningObject
  }
  
  func navigationController(navigationController: UINavigationController,
    interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?{
      return transitioningObject.isTransitioning ? transitioningObject : nil
  }
  
  
}


