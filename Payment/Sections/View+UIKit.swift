//
//  View+UIKit.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import UIKit
import SVProgressHUD

extension View where Self: UIViewController {
    func startLoading() {
        SVProgressHUD.show()
    }
    
    func stopLoading() {
        SVProgressHUD.dismiss()
    }
    
    func showAlert(title: String?, message: String, confirmTitle: String?, completion: (() -> Void)?) {
        let buttonTitle = confirmTitle ?? "OK".localized
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { (alertAction) in
            completion?()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func showError(message: String) {
        showAlert(title: "Error".localized, message: message, confirmTitle: "OK".localized, completion: nil)
    }
}
