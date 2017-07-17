//
//  NetworkRepository.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/9/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol NetworkRepository: Repository {
    var networkClient: NetworkClient { get }
    
    func parseString(forKey key: String, in json: JSON) throws -> String
    func parseInt(forKey key: String, in json: JSON) throws -> Int
    func parseFloat(forKey key: String, in json: JSON) throws -> Float
    func parseURL(forKey key: String, in json: JSON) throws -> URL
    func handleError(_ error: Error?) -> RepositoryError
}

extension NetworkRepository {
    func parseString(forKey key: String, in json: JSON) throws -> String {
        guard let string = json[key].string else { throw RepositoryError.ParsingFailed(failingKey: key) }
        
        return string
    }
    
    func parseInt(forKey key: String, in json: JSON) throws -> Int {
        guard let integer = json[key].int else { throw RepositoryError.ParsingFailed(failingKey: key) }
        
        return integer
    }
    
    func parseFloat(forKey key: String, in json: JSON) throws -> Float {
        guard let float = json[key].float else { throw RepositoryError.ParsingFailed(failingKey: key) }
        
        return float
    }
    
    func parseURL(forKey key: String, in json: JSON) throws -> URL {
        guard let string = json[key].string, let url = URL(string: string) else { throw RepositoryError.ParsingFailed(failingKey: key) }
        
        return url
    }
    
    func handleError(_ error: Error?) -> RepositoryError {
        if let error = error as? NetworkClientError {
            return .ExternalError(error: error)
        }
        else {
            return .Unknown
        }
    }
}
