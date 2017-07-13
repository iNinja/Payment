//
//  AlamofireNetworkClient.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/9/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation
import Alamofire.Swift
import SwiftyJSON

enum NetworkClientError: Error {
    case InvalidURL
    case NoInternetConnection
    case Timeout
}

struct AlamofireNetworkClient: NetworkClient {
    private let baseURL: String
    private var defaultParameters: [String: String]?
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    init(baseURL: String, defaultParameters: [String: String]) {
        self.init(baseURL: baseURL)
        self.defaultParameters = defaultParameters
    }
    
    func get(path: String, parameters: [String : String]?, completion: @escaping (JSON?, Error?) -> Void) {
        guard let url = URL(string: path, relativeTo: URL(string: baseURL)) else {
            completion(nil, NetworkClientError.InvalidURL)
            return
        }
        
        let parameters = mergedParameters(from: parameters)
        Alamofire.request(url, method: .get, parameters: parameters).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                if let result = response.result.value {
                    completion(JSON(result), nil)
                }
                else {
                    completion(nil, response.error)
                }
                
                break
            case .failure:
                completion(nil, response.error)
                break
                
            }
        }
        
    }
    
    private func mergedParameters(from: [String: String]?) -> [String: String] {
        var parameters = defaultParameters ?? [:]
        if let fromParameters = from {
            for (key, value) in fromParameters {
                parameters[key] = value
            }
        }
        return parameters
    }
}
