//
//  CardIssuerPresenter.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

final class CardIssuerPresenter: TitleAndThumbTablePresenter {
    weak var view: CardIssuerView!
    private let interactor: CardIssuerInteractor
    private var cardIssuers: [CardIssuer] = []
    
    var elementCount: Int { return cardIssuers.count }
    var title: String { return "Select Provider".localized }
    var cancelTitle: String { return "Cancel".localized }
    
    init(interactor: CardIssuerInteractor) {
        self.interactor = interactor
    }
    
    func viewLoaded() {
        view.startLoading()
        interactor.getCardIssuers { (cardIssuers, error) in
            self.view.stopLoading()
            
            guard let cardIssuers = cardIssuers else {
                self.handleCardIssuerSelectionError(error)
                return
            }
            
            self.handleCardIssuerSelectionSuccess(cardIssuers)
        }
    }
    
    func viewAppeared() {
        interactor.trackImpression()
    }
    
    func viewSelectedCancel() {
        interactor.cancelCardIssuerSelection()
    }
    
    func viewSelectedElementAt(idx: Int) {
        interactor.continuePaymentFlowWith(issuer: cardIssuers[idx])
    }
    
    func elementTitle(at idx: Int) -> String {
        return cardIssuers[idx].name
    }
    
    func elementThumbURL(at idx: Int) -> URL {
        return cardIssuers[idx].thumbnailURL
    }
    
    private func handleCardIssuerSelectionSuccess(_ data: [CardIssuer]) {
        cardIssuers = data
        view.reloadCardIssuers()
    }
    
    private func handleCardIssuerSelectionError(_ error: RepositoryError?) {
        view.showError(message: "There was an error attempting to retrieve providers.\nPlease try again.".localized)
        interactor.cancelCardIssuerSelection(userInitiated: false)
    }

}
