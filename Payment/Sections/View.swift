//
//  View.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

protocol View: class {
    func showError(message: String)
    func showAlert(title: String?, message: String, confirmTitle: String?, completion: (() -> Void)?)
    func startLoading()
    func stopLoading()
}
