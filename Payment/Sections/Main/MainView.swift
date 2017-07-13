//
//  MainView.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

protocol MainView: View {
    var presenter: MainPresenter { get }
    
    var userInput: String { get }
}
