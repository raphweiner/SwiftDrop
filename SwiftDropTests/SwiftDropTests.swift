//
//  SwiftDropTests.swift
//  SwiftDropTests
//
//  Created by Raphael Weiner on 12/25/14.
//  Copyright (c) 2014 raphaelweiner. All rights reserved.
//


import UIKit
import XCTest


class FakeSwiftDropDelegate: NSObject, SwiftDropDelegate {
    var lastSelectedItemIndex: Int?

    func didSelectItemAt(index: Int) {
        lastSelectedItemIndex = index
    }
}


class SwiftDropTests: XCTestCase {
    var subject: SwiftDrop!
    var delegate: FakeSwiftDropDelegate!
    var topViewController: UIViewController!
    var navigationController: UINavigationController!

    override func setUp() {
        super.setUp()

        topViewController = UIViewController()
        navigationController = UINavigationController(rootViewController: topViewController)
        delegate = FakeSwiftDropDelegate()
        subject = SwiftDrop()
        subject.menuItems = ["Settings", "Logout"]
        subject.delegate = delegate
        subject.navigationController = navigationController
    }

    func test_configuresNavigationBarButtonItem() {
        let barButtonItem = navigationController.navigationBar.topItem!.leftBarButtonItem

        XCTAssertNotNil(barButtonItem, "leftBarButtonItem should be configured")
        XCTAssertEqual(barButtonItem!.target as SwiftDrop, subject, "leftBarButtonItem target should be the swiftDrop")
        XCTAssertEqual(barButtonItem!.action, Selector("toggle"), "leftBarButtonItem action should be toggle")
    }

    func test_showsMenu() {
        XCTAssertNil(subject.menuView.superview, "menuView should not be visible")
        XCTAssertNil(subject.overlayBackground.superview, "overlayBackground should not be visible")

        subject.show()

        XCTAssertEqual(subject.menuView.superview!, topViewController.view, "menuView should be a subview of the topViewController")
        XCTAssertEqual(subject.overlayBackground.superview!, topViewController.view, "overlayBackground should be a subview of the topViewController")
    }

    func test_menuView() {
        XCTAssertEqual(subject.menuView.numberOfSections(), 1, "dropdown should have one section")
        XCTAssertEqual(subject.menuView.visibleCells().count, 2, "dropdown should show menu items")

        let firstCell = subject.menuView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        XCTAssertEqual(firstCell!.textLabel!.text!, "Settings", "first item should have the correct title")

        let secondCell = subject.menuView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))
        XCTAssertEqual(secondCell!.textLabel!.text!, "Logout", "second item should have the correct title")
    }

    func test_hidesMenu() {
        subject.show()
        subject.hide()

        NSRunLoop.currentRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 1))

        XCTAssertNil(subject.menuView.superview, "menuView should not be visible")
        XCTAssertNil(subject.overlayBackground.superview, "overlayBackground should not be visible")
    }

    func test_delegate() {
        subject.show()

        subject.tableView(subject.menuView, didSelectRowAtIndexPath: NSIndexPath(forRow: 1, inSection: 0))

        NSRunLoop.currentRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 1))

        XCTAssertEqual(delegate.lastSelectedItemIndex!, 1, "tapping an item should inform the delegate")
        XCTAssertNil(subject.menuView.superview, "menuView should not be visible")
        XCTAssertNil(subject.overlayBackground.superview, "overlayBackground should not be visible")
    }
    
}
