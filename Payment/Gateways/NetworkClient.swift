//
//  NetworkClient.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/9/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol NetworkClient {
    typealias CompletionBlock = (_ response: JSON?, _ error: Error?) -> Void
    
    func get(path: String, parameters: [String: String]?, completion: @escaping CompletionBlock)
}
