//
//  AppDelegate.swift
//  SwiftDropExample
//
//  Created by Raphael Weiner on 12/26/14.
//  Copyright (c) 2014 raphaelweiner. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        window = UIWindow(frame: UIScreen.mainScreen().bounds)

        if let window = window {
            window.rootViewController = UINavigationController(rootViewController: ViewControllerWithSwiftDrop())
            window.makeKeyAndVisible()
        }

        return true
    }


}

