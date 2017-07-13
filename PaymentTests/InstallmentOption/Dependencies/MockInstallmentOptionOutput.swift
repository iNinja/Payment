//
//  MockInstallmentOptionOutput.swift
//  Payment
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation
@testable import Payment

class MockInstallmentOptionOutput: InstallmentOptionOutput {
    var cancelIntallmentOptionsSelectionCalls = 0
    var completePaymentFlowCalls = 0
    
    func cancelInstallmentOptionSelection() {
        cancelIntallmentOptionsSelectionCalls += 1
    }
    
    func completePaymentFlow() {
        completePaymentFlowCalls += 1
    }
}
