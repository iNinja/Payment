//
//  MainOutput.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

protocol MainOutput: class {
    func showAbout()
    func showPaymentMethods(for payment: Float)
}
