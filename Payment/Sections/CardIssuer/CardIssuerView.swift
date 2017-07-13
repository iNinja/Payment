//
//  CardIssuerView.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

protocol CardIssuerView: View {
    var presenter: CardIssuerPresenter { get }
    
    func reloadCardIssuers()
}
