//
//  InstallmentOptionRepository.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

class InstallmentOptionRepository: Repository {
    func getAll(_ callback: @escaping ([InstallmentOption]?, RepositoryError?) -> Void) {
        // Empty implementation since I can't use a protocol with associated type as the type for a variable
    }
}
