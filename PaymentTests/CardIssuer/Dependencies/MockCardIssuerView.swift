//
//  MockCardIssuerView.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation
@testable import Payment

final class MockCardIssuerView: MockView, CardIssuerView {
    var presenter: CardIssuerPresenter
    var reloadCardIssuersCalls = 0
    
    init(presenter: CardIssuerPresenter) {
        self.presenter = presenter
    }
    
    func reloadCardIssuers() {
        reloadCardIssuersCalls += 1
    }
}
