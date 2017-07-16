//
//  UIViewControllerExtensions.swift
//  Payment
//
//  Created by Ignacio Inglese on 7/16/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import UIKit

extension UIViewController {
    func replaceBackButton() {
        let backBarButtonItem = UIBarButtonItem(title: "Back".localized, style: .plain, target: nil, action: nil)
        backBarButtonItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.clear], for: .normal)
        backBarButtonItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.clear], for: .highlighted)
        navigationItem.backBarButtonItem = backBarButtonItem
    }
}
