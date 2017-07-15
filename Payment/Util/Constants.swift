//
//  Constants.swift
//  Payment
//
//  Created by Ignacio Inglese on 7/15/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

struct Constants {
    struct API {
        static let url = "https://api.mercadopago.com"
        static let publicKey = "444a9ef5-8a6b-429f-abdf-587639155d88"
        
        struct Endpoints {
            static let paymentMethods = "v1/payment_methods"
            static let cardIssuers = "v1/payment_methods/card_issuers"
            static let installmentOptions = "v1/payment_methods/installments"
        }
    }
    struct TrackingEvents {
        static let enteredSection = "Entered Section"
        
        struct Sections {
            static let main = "Main"
            static let about = "About"
            static let paymentMethod = "Payment Method"
            static let cardIssuer = "Card Issuer"
            static let installmentOption = "Installment Option"
        }
        struct Main {
            static let aboutSelected = "About Selected"
            static let paySelected = "Pay Selected"
            static let paymentFailed = "Payment Failed"
        }
        struct PaymentMethods {
            static let retrieved = "Payment Methods Retrieval Succeeded"
            static let notRetrieved = "Payment Methods Retrieval Failed"
            static let selected = "Payment Method Selected"
            static let cancelled = "Payment Method Selection Cancelled"
        }
        struct CardIssuers {
            static let retrieved = "Card Issuers Retrieval Succeeded"
            static let notRetrieved = "Card Issuers Retrieval Failed"
            static let selected = "Card Issuer Selected"
            static let cancelled = "Card Issuer Selection Cancelled"
        }
        struct InstallmentOptions {
            static let retrieved = "Installment Options Retrieval Succeeded"
            static let notRetrieved = "Installment Options Retrieval Failed"
            static let selected = "Installment Option Selected"
            static let cancelled = "Installment Option Selection Cancelled"
            static let paymentProcessed = "Payment Processed"
        }
    }
}
