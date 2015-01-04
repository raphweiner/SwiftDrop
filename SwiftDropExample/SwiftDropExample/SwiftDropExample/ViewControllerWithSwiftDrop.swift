//
//  ViewControllerWithSwiftDrop.swift
//  SwiftDropExample
//
//  Created by Raphael Weiner on 12/26/14.
//  Copyright (c) 2014 raphaelweiner. All rights reserved.
//

import UIKit

class ViewControllerWithSwiftDrop: UIViewController, SwiftDropDelegate {
    var swiftDrop: SwiftDrop!
    var viewControllerOne: UIViewController!
    var viewControllerTwo: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.greenColor()

        viewControllerOne = UIViewController()
        viewControllerOne.view.backgroundColor = UIColor.blueColor()
        viewControllerOne.title = "Blue View Controller"

        viewControllerTwo = UIViewController()
        viewControllerTwo.view.backgroundColor = UIColor.redColor()
        viewControllerTwo.title = "Red View Controller"

        swiftDrop = SwiftDrop()
        swiftDrop.menuItems = [viewControllerOne.title!, viewControllerTwo.title!]
        swiftDrop.navigationController = navigationController
        swiftDrop.delegate = self
    }

    func didSelectItemAt(index: Int) {
        var selectedViewController: UIViewController?

        switch index {
        case 0:
            selectedViewController = viewControllerOne
        case 1:
            selectedViewController = viewControllerTwo
        default:
            break
        }

        navigationController!.pushViewController(selectedViewController!, animated: true)
    }

}

