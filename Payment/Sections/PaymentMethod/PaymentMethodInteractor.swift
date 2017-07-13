//
//  PaymentMethodInteractor.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

final class PaymentMethodInteractor {
    private let eventTracker: EventTracker
    private let repository: PaymentMethodRepository
    private let output: PaymentMethodOutput
    private let amount: Float
    
    init(repository: PaymentMethodRepository, eventTracker: EventTracker, output: PaymentMethodOutput, amount: Float) {
        self.repository = repository
        self.eventTracker = eventTracker
        self.output = output
        self.amount = amount
    }
    
    func trackImpression() {
        eventTracker.trackSectionChange(name: "Payment Method")
    }
    
    func getPaymentMethods(completion: @escaping ([PaymentMethod]?, RepositoryError?) -> Void) {
        repository.getAll { (paymentMethods, error) in
            let eventSuffix = error == nil ? "Succeeded" : "Failed"
            self.eventTracker.trackEvent("Payment Method Retrieval " + eventSuffix, parameters: nil)
            completion(paymentMethods, error)
        }
    }
    
    func continuePaymentFlowWith(method: PaymentMethod) {
        eventTracker.trackEvent("Payment Method Selected", parameters: ["id": method.id])
        output.showCardProvidersFor(paymentMethod: method, amount: amount)
    }
    
    func cancelPaymentFlow(userInitiated: Bool = true) {
        if userInitiated {
            eventTracker.trackEvent("Payment Method Selection cancelled", parameters: nil)
        }
        output.cancelPaymentProcess()
    }
}
