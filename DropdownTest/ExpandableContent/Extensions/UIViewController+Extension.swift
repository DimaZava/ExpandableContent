//
//  UIViewController+Extension.swift
//  DropdownTest
//
//  Created by Dmitryj on 25.11.2019.
//  Copyright © 2019 lmc. All rights reserved.
//

import UIKit

extension UIViewController {

    /// SwifterSwift: Helper method to add a UIViewController as a childViewController.
    ///
    /// - Parameters:
    ///   - child: the view controller to add as a child
    ///   - containerView: the containerView for the child viewcontroller's root view.
    func addChildViewController(_ child: UIViewController, toContainerView containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }
}
