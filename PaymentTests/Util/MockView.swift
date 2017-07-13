//
//  MockView.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation
@testable import Payment

class MockView: View {
    var startLoadingCalls = 0
    var stopLoadingCalls = 0
    var errorMessages: [String] = []
    var alertMessages: [String] = []
        
    func startLoading() {
        startLoadingCalls += 1
    }
    
    func stopLoading() {
        stopLoadingCalls += 1
    }
    
    func showError(message: String) {
        errorMessages.append(message)
    }
    
    func showAlert(title: String?, message: String, confirmTitle: String?, completion: (() -> Void)?) {
        alertMessages.append(message)
        completion?()
    }
}
