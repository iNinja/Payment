//
//  MainPresenter.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

final class MainPresenter {
    weak var view: MainView!
    private let interactor: MainInteractor
    private let timeable: Timeable
    
    let title = "Payment Test".localized
    let aboutTitle = "About".localized
    let message = "Enter the amount".localized
    let callToAction = "Pay".localized
    
    init(interactor: MainInteractor, timeable: Timeable) {
        self.interactor = interactor
        self.timeable = timeable
    }
    
    // Just an example of having interaction with the view without ever using UIKit, fully mockable
    func viewLoaded() {
        view.startLoading()
        
        timeable.asyncAfter(time: 0.5) { 
            self.view.stopLoading()
            
            self.timeable.asyncAfter(time: 0.2) {
                self.view.showAlert(title: "Welcome".localized,
                                    message: "This is a test app using MercadoPago's API to showcase technical knowledge.".localized,
                                    confirmTitle: "Alright".localized,
                                    completion: nil)
            }
        }
    }
    
    func viewAppeared() {
        interactor.trackImpression()
    }
    
    func viewSelectedAbout() {
        interactor.showAbout()
    }
    
    func viewSelectedPay() {
        guard let amount = Float(view.userInput) else {
            interactor.trackPaymentFailure(reason: "Invalid User Input")
            view.showError(message: "Please enter a valid amount".localized)
            return
        }
        
        startPaymentFlow(amount: amount)
    }
    
    private func startPaymentFlow(amount: Float) {
        do {
            try interactor.startPaymentFlow(amount: amount)
        }
        catch {
            if let error = error as? MainError, error == .InvalidAmount {
                view.showError(message: "Amount to pay must be greater than zero.".localized)
            }
        }
    }
}
