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
        eventTracker.trackSectionChange(name: "Installment Option")
    }
    
    func getInstallmentOptions(completion: @escaping ([InstallmentOption]?, RepositoryError?) -> Void) {
        repository.getAll { (installmentOptions, error) in
            let eventSuffix = error == nil ? "Succeeded" : "Failed"
            self.eventTracker.trackEvent("Installment Option Retrieval " + eventSuffix, parameters: nil)
            completion(installmentOptions, error)
        }
    }
    
    func processPaymentWith(option: InstallmentOption, callback: @escaping (ProcessPaymentResult) -> Void) {
        eventTracker.trackEvent("Installment Option Selected", parameters: ["installments": String(option.installments)])
        processPayment.process(withInstallmentOption: option) { (processPaymentResult) in
            self.eventTracker.trackEvent("Payment Processed", parameters: ["success": processPaymentResult.success.description])
            callback(processPaymentResult)
        }
    }
    
    func completePaymentFlow() {
        output.completePaymentFlow()
    }
    
    func cancelPaymentFlow(userInitiated: Bool = true) {
        if userInitiated {
            eventTracker.trackEvent("Installment Option Selection cancelled", parameters: nil)
        }
        output.cancelInstallmentOptionSelection()
    }
}
