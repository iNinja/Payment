//
//  PaymentMethodController.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import UIKit
import AlamofireImage

final class PaymentMethodController: UIViewController, PaymentMethodView {
    let presenter: PaymentMethodPresenter
    let tableDatasource: TitleAndThumbCellDatasource
    let tableDelegate: TitleAndThumbCellDelegate
    
    @IBOutlet private var tableView: UITableView!
    
    init(presenter: PaymentMethodPresenter) {
        self.presenter = presenter
        tableDatasource = TitleAndThumbCellDatasource(presenter: presenter)
        tableDelegate = TitleAndThumbCellDelegate(presenter: presenter)
        
        super.init(nibName: "PaymentMethodController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        presenter.viewLoaded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.viewAppeared()
    }
    
    func reloadPaymentMethods() {
        tableView.reloadData()
    }
    
    private func setup() {
        navigationItem.title = presenter.title
        
        tableView.dataSource = tableDatasource
        tableView.delegate = tableDelegate
        tableDatasource.registerCell(forTableView: tableView)
        
        replaceBackButton()
    }
}
