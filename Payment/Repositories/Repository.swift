//
//  Repository.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/9/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

enum RepositoryError: Error {
    case ExternalError(error: Error)
    case InvalidResponse(error: Error?)
    case ParsingFailed(failingKey: String)
    case NoData
    case Unknown
}

protocol Repository {
    associatedtype Entity
    
    func getAll(_ callback: @escaping (_ response: [Entity]?, _ error: RepositoryError?) -> Void) throws
}
