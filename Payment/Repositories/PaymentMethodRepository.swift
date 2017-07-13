//
//  PaymentMethodRepository.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

class PaymentMethodRepository: Repository {
    func getAll(_ callback: @escaping ([PaymentMethod]?, RepositoryError?) -> Void) {
        // Empty implementation since I can't use a protocol with associated type as the type for a variable
    }
}
