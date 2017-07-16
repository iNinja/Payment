//
//  TitleAndThumbCellDatasource.swift
//  Payment
//
//  Created by Ignacio Inglese on 7/16/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import UIKit

class TitleAndThumbCellDatasource: NSObject, UITableViewDataSource {
    var presenter: TitleAndThumbTablePresenter
    var cellIdentifier = "TitleAndThumbCell"
    
    init(presenter: TitleAndThumbTablePresenter) {
        self.presenter = presenter
    }
    
    func registerCell(forTableView tableView: UITableView) {
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.elementCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TitleAndThumbCell
        cell.thumbImageView.image = nil
        cell.titleLabel.text = presenter.elementTitle(at: indexPath.row)
        cell.thumbImageView.af_setImage(withURL: presenter.elementThumbURL(at: indexPath.row))
        return cell
    }
}
