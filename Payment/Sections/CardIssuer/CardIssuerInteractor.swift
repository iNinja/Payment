//
//  CardIssuerInteractor.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

final class CardIssuerInteractor {
    private let eventTracker: EventTracker
    private let repository: CardIssuerRepository
    private let output: CardIssuerOutput
    private let amount: Float
    private let paymentMethod: PaymentMethod
    
    init(repository: CardIssuerRepository, eventTracker: EventTracker, output: CardIssuerOutput, amount: Float, paymentMethod: PaymentMethod) {
        self.repository = repository
        self.eventTracker = eventTracker
        self.output = output
        self.amount = amount
        self.paymentMethod = paymentMethod
    }
    
    func trackImpression() {
        eventTracker.trackSectionChange(name: "Card Issuer")
    }
    
    func getCardIssuers(completion: @escaping ([CardIssuer]?, RepositoryError?) -> Void) {
        repository.getAll { (cardIssuers, error) in
            let eventSuffix = error == nil ? "Succeeded" : "Failed"
            self.eventTracker.trackEvent("Card Issuer Retrieval " + eventSuffix, parameters: nil)
            completion(cardIssuers, error)
        }
    }
    
    func continuePaymentFlowWith(issuer: CardIssuer) {
        eventTracker.trackEvent("Card Issuer Selected", parameters: ["id": issuer.id])
        output.showInstallmentOptionsFor(paymentMethod: paymentMethod, cardIssuer: issuer, amount: amount)
    }
    
    func cancelPaymentFlow(userInitiated: Bool = true) {
        if userInitiated {
            eventTracker.trackEvent("Card Issuer Selection cancelled", parameters: nil)
        }
        output.cancelCardIssuerSelection()
    }
}