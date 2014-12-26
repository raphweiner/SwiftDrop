//
//  SwiftDrop.swift
//  SwiftDrop
//
//  Created by Raphael Weiner on 12/25/14.
//  Copyright (c) 2014 raphaelweiner. All rights reserved.
//


import Foundation
import UIKit


protocol SwiftDropDelegate {
    func didSelectItemAt(index: Int)
}


class SwiftDrop: NSObject, UITableViewDataSource, UITableViewDelegate {

    enum DropState {
        case Hidden
        case Visible
    }

    //  Configure these properties

    var menuItems: Array<String>!

    var delegate: SwiftDropDelegate!

    var navigationController: UINavigationController! {
        didSet {
            let barButtonItem = UIBarButtonItem()
            barButtonItem.image = UIImage(named: "drop-toggle")
            barButtonItem.target = self
            barButtonItem.action = Selector("toggle")
            navigationController.navigationBar.topItem!.leftBarButtonItem = barButtonItem
        }
    }

    // MARK: Properties

    var dropState: DropState! = .Hidden

    lazy var menuView: UITableView = {
        var menuView = UITableView()
        menuView.estimatedRowHeight = 44
        menuView.dataSource = self
        menuView.delegate = self
        menuView.frame = CGRectMake(
            0,
            0,
            self.navigationController.navigationBar.frame.width,
            CGFloat(menuView.numberOfRowsInSection(0)) * CGFloat(menuView.estimatedRowHeight)
        )
        return menuView
        }()

    lazy var overlayBackground: UIView = {
        var overlayBackground = UIView()
        overlayBackground.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: Selector("hide"))
        )
        overlayBackground.frame = CGRectMake(
            0,
            0,
            self.navigationController.navigationBar.frame.size.width,
            1000
        )
        overlayBackground.backgroundColor = UIColor.blackColor()
        return overlayBackground
        }()

    //  MARK: Show / Hide Menu

    func toggle() {
        if (dropState == .Visible) {
            hide()
        } else {
            show()
        }
    }

    func show() {
        dropState = .Visible
        navigationController.topViewController.view.addSubview(overlayBackground)
        navigationController.topViewController.view.addSubview(menuView)
        overlayBackground.alpha = 0

        var menuFrame = menuView.frame
        menuFrame.origin.y = navigationController.navigationBar.frame.size.height + UIApplication.sharedApplication().statusBarFrame.height

        UIView.animateWithDuration(
            0.35,
            delay: 0.0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 4.0,
            options: .CurveEaseInOut,
            animations: {
                self.menuView.frame = menuFrame
                self.overlayBackground.alpha = 0.5
            },
            completion:nil
        )
    }

    func hide() {
        dropState = .Hidden

        var menuFrame = menuView.frame
        menuFrame.origin.y = navigationController.navigationBar.frame.size.height - menuFrame.size.height

        UIView.animateWithDuration(
            0.35,
            delay: 0.05,
            usingSpringWithDamping: 2.0,
            initialSpringVelocity: 4.0,
            options: .CurveEaseInOut,
            animations: {
                self.menuView.frame = menuFrame
                self.overlayBackground.alpha = 0
            },
            completion: { finished in
                self.menuView.removeFromSuperview()
                self.overlayBackground.removeFromSuperview()
        })
    }

    // MARK: UITableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell") as UITableViewCell?
        if (cell == nil) {
            cell = UITableViewCell(style:.Default, reuseIdentifier:"UITableViewCell")
        }

        cell!.textLabel!.text = menuItems[indexPath.row]
        return cell!
    }

    // MARK: UITableViewDelegate

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate.didSelectItemAt(indexPath.row)
        hide()
        tableView.deselectRowAtIndexPath(indexPath, animated:false)
    }
    
}
