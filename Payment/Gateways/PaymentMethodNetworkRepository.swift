//
//  PaymentMethodNetworkRepository.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/9/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation
import SwiftyJSON

final class PaymentMethodNetworkRepository: PaymentMethodRepository, NetworkRepository {
    internal let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
        super.init()
    }
    
    override func getAll(_ callback: @escaping ([PaymentMethod]?, RepositoryError?) -> Void) {
        super.getAll { (cardIssuer, error) in }
        
        networkClient.get(path: Constants.API.Endpoints.paymentMethods, parameters: nil) { (response, error) in
            guard let response = response else {
                callback(nil, self.handleError(error))
                return
            }
            
            do {
                // Filtering out cards that currently have no issuers. Swap the commented 
                // lines to get all the credit cards.
                let data = try self.parsePaymentMethods(json: response)
//                    .filter { $0.type == .creditCard }
                    .filter { ["visa", "master", "amex", "cabal"].contains($0.id) }
                callback(data, nil)
            }
            catch {
                callback(nil, error as? RepositoryError)
            }
        }
    }
    
    private func parsePaymentMethods(json: JSON) throws -> [PaymentMethod] {
        guard let methods = json.array, methods.count > 0 else { throw RepositoryError.NoData }
        
        var returnValue: [PaymentMethod] = []
        for method in methods {
            returnValue.append(try parsePaymentMethod(json: method))
        }
        
        return returnValue
    }
    
    private func parsePaymentMethod(json: JSON) throws -> PaymentMethod {
        let id = try parseString(forKey: "id", in: json)
        let name = try parseString(forKey: "name", in: json)
        let thumbnail = try parseURL(forKey: "secure_thumbnail", in: json)
        let type = try parsePaymentType(forKey: "payment_type_id", in: json)
        
        return PaymentMethod(id: id, type: type, name: name, thumbnailURL: thumbnail)
    }
    
    private func parsePaymentType(forKey key: String, in json: JSON) throws -> PaymentType {
        let typeId = try parseString(forKey: key, in: json)
        guard let type = PaymentType(rawValue: typeId) else { throw RepositoryError.ParsingFailed(failingKey: key) }
            
        return type
    }
}
