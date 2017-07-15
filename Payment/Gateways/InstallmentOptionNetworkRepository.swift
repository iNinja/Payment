//
//  InstallmentOptionNetworkRepository.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/9/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation
import SwiftyJSON

final class InstallmentOptionNetworkRepository: InstallmentOptionRepository, NetworkRepository {
    internal let networkClient: NetworkClient
    private let amount: String
    private let paymentMethodId: String
    private let cardIssuerId: String
    
    init(networkClient: NetworkClient, amount: Float, paymentMethodId: String, cardIssuerId: String) {
        self.networkClient = networkClient
        self.amount = String(amount)
        self.paymentMethodId = paymentMethodId
        self.cardIssuerId = cardIssuerId
    }
    
    override func getAll(_ callback: @escaping ([InstallmentOption]?, RepositoryError?) -> Void) {
        let parameters = [ "amount": amount, "payment_method_id": paymentMethodId,
                           "issuer_id": cardIssuerId ]
        networkClient.get(path: Constants.API.Endpoints.installmentOptions, parameters: parameters) { (response, error) in
            guard let response = response else {
                callback(nil, self.handleError(error))
                return
            }
            
            do {
                let data = try self.parseInstallmentOptions(json: response)
                callback(data, nil)
            }
            catch {
                callback(nil, error as? RepositoryError)
                
            }
        }
    }
    
    private func parseInstallmentOptions(json: JSON) throws -> [InstallmentOption] {
        guard let options = json.array?.first?["payer_costs"].array, options.count > 0 else { throw RepositoryError.NoData }
        
        var returnValue: [InstallmentOption] = []
        for option in options {
            returnValue.append(try parseInstallmentOption(json: option))
        }
        
        return returnValue
    }
    
    private func parseInstallmentOption(json: JSON) throws -> InstallmentOption {
        let installments = try parseInt(forKey: "installments", in: json)
        let rate = try parseFloat(forKey: "installment_rate", in: json)
        let installmentAmount = try parseFloat(forKey: "installment_amount", in: json)
        let totalAmount = try parseFloat(forKey: "total_amount", in: json)
        let recommendedMessage = try parseString(forKey: "recommended_message", in: json)
        
        return InstallmentOption(installments: installments, rate: rate, installmentAmount: installmentAmount, totalAmount: totalAmount, recommendedMessage: recommendedMessage)
    }
}
