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
    var cancelTitle: String { return "Cancel".localized }
    
    init(interactor: InstallmentOptionInteractor) {
        self.interactor = interactor
    }
    
    func viewLoaded() {
        view.startLoading()
        interactor.getInstallmentOptions { (installmentOptions, error) in
            self.view.stopLoading()
            guard let installmentOptions = installmentOptions else {
                self.handleInstallmentOptionSelectionError(error)
                return
            }
            
            self.handleInstallmentOptionSelectionSuccess(installmentOptions)
        }
    }
    
    func viewAppeared() {
        interactor.trackImpression()
    }
    
    func viewSelectedCancel() {
        interactor.cancelInstallmentOptionSelection()
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
    
    private func handleInstallmentOptionSelectionSuccess(_ data: [InstallmentOption]) {
        installmentOptions = data
        view.reloadInstallmentOptions()
    }
    
    private func handleInstallmentOptionSelectionError(_ error: RepositoryError?) {
        view.showError(message: "There was an error attempting to retrieve installments.\nPlease try again.".localized)
        interactor.cancelInstallmentOptionSelection(userInitiated: false)
    }
    
}
