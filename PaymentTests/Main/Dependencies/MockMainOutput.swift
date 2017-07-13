//
//  MockMainOutput.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation
@testable import Payment

class MockMainOutput: MainOutput {
    
    var showAboutCalls = 0
    var paymentsEntered: [Float] = []
    
    func showAbout() {
        showAboutCalls += 1
    }
    
    func showPaymentMethods(for payment: Float) {
        paymentsEntered.append(payment)
    }
    
    func enteredPaymentFor(amount: Float) -> Bool {
        return paymentsEntered.filter { $0 == amount }.count > 0
    }
}
