//
//  PaymentMethodCell.swift
//  Payment
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import UIKit

class PaymentMethodCell: UITableViewCell {
    @IBOutlet var paymentMethodImageView: UIImageView!
    @IBOutlet var paymentMethodLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
}
