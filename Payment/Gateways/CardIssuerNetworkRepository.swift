//
//  CardIssuerNetworkRepository.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/9/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation
import SwiftyJSON

final class CardIssuerNetworkRepository: CardIssuerRepository, NetworkRepository {
    internal let networkClient: NetworkClient
    private let paymentMethodId: String
    
    init(networkClient: NetworkClient, paymentMethodId: String) {
        self.networkClient = networkClient
        self.paymentMethodId = paymentMethodId
    }
    
    override func getAll(_ callback: @escaping ([CardIssuer]?, RepositoryError?) -> Void) {
        let parameters = ["payment_method_id": paymentMethodId]
        networkClient.get(path: Constants.API.Endpoints.cardIssuers, parameters: parameters) { (response, error) in
            guard let response = response else {
                callback(nil, self.handleError(error))
                return
            }
            
            do {
                let data = try self.parseCardIssuers(json: response)
                callback(data, nil)
            }
            catch {
                callback(nil, error as? RepositoryError)
            }
        }
    }
    
    private func parseCardIssuers(json: JSON) throws -> [CardIssuer] {
        guard let methods = json.array, methods.count > 0 else { throw RepositoryError.NoData }
        
        var returnValue: [CardIssuer] = []
        for method in methods {
            returnValue.append(try parseCardIssuer(json: method))
        }
        
        return returnValue
    }
    
    private func parseCardIssuer(json: JSON) throws -> CardIssuer {
        let id = try parseString(forKey: "id", in: json)
        let name = try parseString(forKey: "name", in: json)
        let thumbnail = try parseURL(forKey: "secure_thumbnail", in: json)
        
        return CardIssuer(id: id, name: name, thumbnailURL: thumbnail)
    }
}
