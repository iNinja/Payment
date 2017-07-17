//
//  InstallmentOptionInteractor.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

final class InstallmentOptionInteractor {
    private let eventTracker: EventTracker
    private let repository: InstallmentOptionRepository
    private let output: InstallmentOptionOutput
    private let processPayment: ProcessPayment
    
    init(repository: InstallmentOptionRepository, eventTracker: EventTracker, output: InstallmentOptionOutput, processPayment: ProcessPayment) {
        self.repository = repository
        self.eventTracker = eventTracker
        self.output = output
        self.processPayment = processPayment
    }
    
    func trackImpression() {
        eventTracker.trackSectionChange(name: Constants.TrackingEvents.Sections.installmentOption)
    }
    
    func getInstallmentOptions(completion: @escaping ([InstallmentOption]?, RepositoryError?) -> Void) {
        repository.getAll { (installmentOptions, error) in
            let event = error == nil ? Constants.TrackingEvents.InstallmentOptions.retrieved : Constants.TrackingEvents.InstallmentOptions.notRetrieved
            self.eventTracker.trackEvent(event, parameters: nil)
            completion(installmentOptions, error)
        }
    }
    
    func processPaymentWith(option: InstallmentOption, callback: @escaping (ProcessPaymentResult) -> Void) {
        eventTracker.trackEvent(Constants.TrackingEvents.InstallmentOptions.selected, parameters: ["installments": String(option.installments)])
        processPayment.process(withInstallmentOption: option) { (processPaymentResult) in
            self.eventTracker.trackEvent(Constants.TrackingEvents.InstallmentOptions.paymentProcessed, parameters: ["success": processPaymentResult.success.description])
            callback(processPaymentResult)
        }
    }
    
    func completePaymentFlow() {
        output.completePaymentFlow()
    }
    
    func cancelInstallmentOptionSelection(userInitiated: Bool = true) {
        if userInitiated {
            eventTracker.trackEvent(Constants.TrackingEvents.InstallmentOptions.cancelled, parameters: nil)
        }
        output.cancelInstallmentOptionSelection()
    }
}
