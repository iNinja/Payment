//
//  MainInteractor.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

enum MainError: Error {
    case InvalidAmount
}

final class MainInteractor {
    weak var output: MainOutput?
    private let eventTracker: EventTracker
    
    init(output: MainOutput, eventTracker: EventTracker) {
        self.output = output
        self.eventTracker = eventTracker
    }
    
    func trackImpression() {
        eventTracker.trackSectionChange(name: "Main")
    }
    
    func showAbout() {
        eventTracker.trackEvent("About Selected", parameters: nil)
        output?.showAbout()
    }
    
    func trackPaymentFailure(reason: String) {
        eventTracker.trackEvent("Payment Failed", parameters: ["reason": reason])
    }
    
    func startPaymentFlow(amount: Float) throws {
        guard amount > 0 else {
            trackPaymentFailure(reason: "Invalid Amount")
            throw MainError.InvalidAmount
        }
        
        eventTracker.trackEvent("Pay Selected", parameters: ["amount": String(amount)])
        output?.showPaymentMethods(for: amount)
    }
}
