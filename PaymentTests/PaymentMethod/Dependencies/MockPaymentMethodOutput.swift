//
//  MockPaymentMethodOutput.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation
@testable import Payment

final class MockPaymentMethodOutput: PaymentMethodOutput {
    
    var cancelPaymentProcessCalls = 0
    var paymentMethodsEntered: [PaymentMethod] = []
    var amountsEntered: [Float] = []
    
    func cancelPaymentProcess() {
        cancelPaymentProcessCalls += 1
    }
    
    func showCardProvidersFor(paymentMethod: PaymentMethod, amount: Float) {
        paymentMethodsEntered.append(paymentMethod)
        amountsEntered.append(amount)
    }
}
