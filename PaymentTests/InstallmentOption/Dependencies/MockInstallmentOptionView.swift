//
//  MockInstallmentOptionView.swift
//  Payment
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation
@testable import Payment

class MockInstallmentOptionView: MockView, InstallmentOptionView {
    var presenter: InstallmentOptionPresenter
    var reloadInstallmentOptionCalls = 0
    
    init(presenter: InstallmentOptionPresenter) {
        self.presenter = presenter
    }
    
    func reloadInstallmentOptions() {
        reloadInstallmentOptionCalls += 1
    }
}
