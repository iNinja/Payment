//
//  TitleAndThumbTableDelegate.swift
//  Payment
//
//  Created by Ignacio Inglese on 7/16/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import UIKit

class TitleAndThumbTableDelegate: NSObject, UITableViewDelegate {
    var presenter: TitleAndThumbTablePresenter
    
    init(presenter: TitleAndThumbTablePresenter) {
        self.presenter = presenter
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.viewSelectedElementAt(idx: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
