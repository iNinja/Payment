//
//  PaymentMethodView.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

protocol PaymentMethodView: View {
    var presenter: PaymentMethodPresenter { get }
    
    func reloadPaymentMethods()
}
