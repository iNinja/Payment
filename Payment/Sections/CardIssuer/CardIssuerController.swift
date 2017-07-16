//
//  CardIssuerController.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import UIKit

final class CardIssuerController: TitleAndThumbTableController, CardIssuerView {
    let presenter: CardIssuerPresenter
    
    init(presenter: CardIssuerPresenter) {
        self.presenter = presenter
        
        super.init(nibName: "CardIssuerController", presenter: presenter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("CardIssuerController is not meant to be instantiated from a nib.")
    }
    
    func reloadCardIssuers() {
        reloadTable()
    }
}
