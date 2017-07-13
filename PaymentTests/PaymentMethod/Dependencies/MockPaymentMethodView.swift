//
//  MockPaymentMethodView.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation
@testable import Payment

final class MockPaymentMethodView: MockView, PaymentMethodView {
    
    let presenter: PaymentMethodPresenter
    var reloadPaymentMethodsCalls = 0
    
    init(presenter: PaymentMethodPresenter) {
        self.presenter = presenter
    }
    
    func reloadPaymentMethods() {
        reloadPaymentMethodsCalls += 1
    }
}
