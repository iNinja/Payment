//
//  PaymentMethod.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/9/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

enum PaymentType: String {
    case creditCard = "credit_card"
    case debitCard = "debit_card"
    case ticket = "ticket"
}

struct PaymentMethod {
    let id: String
    let type: PaymentType
    let name: String
    let thumbnailURL: URL
}
