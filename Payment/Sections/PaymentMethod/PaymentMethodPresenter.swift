//
//  PaymentMethodPresenter.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

final class PaymentMethodPresenter: TitleAndThumbTablePresenter {
    weak var view: PaymentMethodView!
    private let interactor: PaymentMethodInteractor
    private var paymentMethods: [PaymentMethod] = []
    
    var elementCount: Int { return paymentMethods.count }
    var title: String { return "Select Payment Method".localized }
    var cancelTitle: String { return "Cancel".localized }
    
    init(interactor: PaymentMethodInteractor) {
        self.interactor = interactor
    }
    
    func viewLoaded() {
        view.startLoading()
        interactor.getPaymentMethods { (paymentMethods, error) in
            self.view.stopLoading()
            guard let paymentMethods = paymentMethods else {
                self.handlePaymentMethodSelectionError(error)
                return
            }
            
            self.handlePaymentMethodSelectionSuccess(paymentMethods)
        }
    }
    
    func viewAppeared() {
        interactor.trackImpression()
    }
    
    func viewSelectedCancel() {
        interactor.cancelPaymentMethodSelection()
    }
    
    func viewSelectedElementAt(idx: Int) {
        interactor.continuePaymentFlowWith(method: paymentMethods[idx])
    }
    
    func elementTitle(at idx: Int) -> String {
        return paymentMethods[idx].name
    }
    
    func elementThumbURL(at idx: Int) -> URL {
        return paymentMethods[idx].thumbnailURL
    }
    
    private func handlePaymentMethodSelectionSuccess(_ data: [PaymentMethod]) {
        paymentMethods = data
        view.reloadPaymentMethods()
    }
    
    private func handlePaymentMethodSelectionError(_ error: RepositoryError?) {
        view.showError(message: "There was an error attempting to retrieve payment methods.\nPlease try again.".localized)
        interactor.cancelPaymentMethodSelection(userInitiated: false)
    }
}
