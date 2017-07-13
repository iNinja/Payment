//
//  MockNetworkClient.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation
@testable import Payment
import SwiftyJSON

class MockNetworkClient: NetworkClient {
    private let json: JSON?
    private let error: Error?
    
    var path: String!
    var parameters: [String: String]?
    
    
    init(jsonFile: String?, error: Error?) {
        if let error = error {
            self.error = error
            self.json = nil
        }
        else {
            let url = Bundle(for: type(of: self)).url(forResource: jsonFile, withExtension: "json")!
            let data = try! Data(contentsOf: url)
            self.json = JSON(data: data)
            self.error = nil
        }
    }
    
    func get(path: String, parameters: [String : String]?, completion: @escaping NetworkClient.CompletionBlock) {
        self.path = path
        self.parameters = parameters
        
        completion(json, error)
    }
}
