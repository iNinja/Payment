//
//  MockMainView.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation
@testable import Payment

final class MockMainView: MockView, MainView {
    let presenter: MainPresenter
    let userInput: String
    
    init(presenter: MainPresenter, userInput: String) {
        self.presenter = presenter
        self.userInput = userInput
    }
}
