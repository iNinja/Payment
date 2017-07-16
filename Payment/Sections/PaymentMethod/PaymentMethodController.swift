//
//  PaymentMethodController.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import UIKit
import AlamofireImage

final class PaymentMethodController: TitleAndThumbTableController, PaymentMethodView {
    let presenter: PaymentMethodPresenter
    
    init(presenter: PaymentMethodPresenter) {
        self.presenter = presenter
        
        super.init(nibName: "PaymentMethodController", presenter: presenter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("PaymentMethodController is not meant to be instantiated from a nib")
    }
    
    func reloadPaymentMethods() {
        reloadTable()
    }
}
