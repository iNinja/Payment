//
//  MockAboutView.swift
//  Payment
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation
@testable import Payment

class MockAboutView: MockView, AboutView {
    var presenter: AboutPresenter
    
    init(presenter: AboutPresenter) {
        self.presenter = presenter
    }
}
