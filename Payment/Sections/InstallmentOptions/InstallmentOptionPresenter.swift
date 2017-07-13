//
//  InstallmentOptionPresenter.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

final class InstallmentOptionPresenter {
    weak var view: InstallmentOptionView!
    private let interactor: InstallmentOptionInteractor
    private var installmentOptions: [InstallmentOption] = []
    
    var elementCount: Int { return installmentOptions.count }
    var title: String { return "Select Installments".localized }
    
    init(interactor: InstallmentOptionInteractor) {
        self.interactor = interactor
    }
    
    func viewLoaded() {
        view.startLoading()
        interactor.getInstallmentOptions { (installmentOptions, error) in
            guard let installmentOptions = installmentOptions else {
                self.handleError(error)
                return
            }
            
            self.handleSuccess(installmentOptions)
        }
    }
    
    func viewAppeared() {
        interactor.trackImpression()
    }
    
    func viewSelectedCancel() {
        interactor.cancelPaymentFlow()
    }
    
    func viewSelectedElementAt(idx: Int) {
        view.startLoading()
        interactor.processPaymentWith(option: installmentOptions[idx]) { (processPaymentResult) in
            self.view.stopLoading()
            self.view.showAlert(title: "Success", message: processPaymentResult.message, confirmTitle: nil) {
                self.interactor.completePaymentFlow()
            }
        }
    }
    
    func elementTitle(at idx: Int) -> String {
        return installmentOptions[idx].recommendedMessage
    }
    
    private func handleSuccess(_ data: [InstallmentOption]) {
        installmentOptions = data
        view.reloadInstallmentOptions()
        view.stopLoading()
    }
    
    private func handleError(_ error: RepositoryError?) {
        view.stopLoading()
        view.showError(message: "There was an error attempting to retrieve installments.\nPlease try again.".localized)
        interactor.cancelPaymentFlow(userInitiated: false)
    }
    
}
