//
//  MockCardIssuerOutput.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation
@testable import Payment

final class MockCardIssuerOutput: CardIssuerOutput {
    
    var cancelCardIssuerSelectionCalls = 0
    var cardIssuersEntered: [CardIssuer] = []
    
    func cancelCardIssuerSelection() {
        cancelCardIssuerSelectionCalls += 1
    }
    
    func showInstallmentOptionsFor(paymentMethod: PaymentMethod, cardIssuer: CardIssuer, amount: Float) {
        cardIssuersEntered.append(cardIssuer)
    }
}
