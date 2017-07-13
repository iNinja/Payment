//
//  PaymentMethodOutput.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

protocol PaymentMethodOutput {
    func cancelPaymentProcess()
    func showCardProvidersFor(paymentMethod: PaymentMethod, amount: Float)
}
