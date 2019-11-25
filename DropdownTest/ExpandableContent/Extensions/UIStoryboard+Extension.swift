//
//  UIStoryboard+Extension.swift
//  DropdownTest
//
//  Created by Dmitryj on 25.11.2019.
//  Copyright © 2019 lmc. All rights reserved.
//

import UIKit

extension UIStoryboard {

    /// SwifterSwift: Instantiate a UIViewController using its class name
    ///
    /// - Parameter name: UIViewController type
    /// - Returns: The view controller corresponding to specified class name
    func instantiateViewController<T: UIViewController>(withClass name: T.Type) -> T? {
        return instantiateViewController(withIdentifier: String(describing: name)) as? T
    }
}
