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
        eventTracker.trackSectionChange(name: Constants.TrackingEvents.Sections.paymentMethod)
    }
    
    func getPaymentMethods(completion: @escaping ([PaymentMethod]?, RepositoryError?) -> Void) {
        repository.getAll { (paymentMethods, error) in
            let event = error == nil ? Constants.TrackingEvents.PaymentMethods.retrieved : Constants.TrackingEvents.PaymentMethods.notRetrieved
            self.eventTracker.trackEvent(event, parameters: nil)
            completion(paymentMethods, error)
        }
    }
    
    func continuePaymentFlowWith(method: PaymentMethod) {
        eventTracker.trackEvent(Constants.TrackingEvents.PaymentMethods.selected, parameters: ["id": method.id])
        output.showCardProvidersFor(paymentMethod: method, amount: amount)
    }
    
    func cancelPaymentFlow(userInitiated: Bool = true) {
        if userInitiated {
            eventTracker.trackEvent(Constants.TrackingEvents.PaymentMethods.cancelled, parameters: nil)
        }
        output.cancelPaymentProcess()
    }
}
