//
//  ProcessPayment.swift
//  Payment
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

class ProcessPayment {
    private let amount: Float
    private let paymentMethod: PaymentMethod
    private let cardIssuer: CardIssuer
    private let timeable: Timeable
    
    init(amount: Float, paymentMethod: PaymentMethod, cardIssuer: CardIssuer, timeable: Timeable) {
        self.amount = amount
        self.paymentMethod = paymentMethod
        self.cardIssuer = cardIssuer
        self.timeable = timeable
    }
    
    func process(withInstallmentOption installmentOption: InstallmentOption, callback: @escaping (ProcessPaymentResult) -> Void) {
        let message = successMessage(installmentOption: installmentOption)
        let result = ProcessPaymentResult(success: true, message: message)
        timeable.asyncAfter(time: 1) { 
            callback(result)
        }
    }
    
    private func successMessage(installmentOption: InstallmentOption) -> String {
        return "You have paid $\(amount) with your \(paymentMethod.name) card from \(cardIssuer.name) in \(installmentOption.recommendedMessage)."
    }
}
