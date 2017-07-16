//
//  TitleAndThumbTableController.swift
//  Payment
//
//  Created by Ignacio Inglese on 7/16/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import UIKit

class TitleAndThumbTableController: UIViewController {
    let tableDatasource: TitleAndThumbTableDatasource
    let tableDelegate: TitleAndThumbTableDelegate
    let tablePresenter: TitleAndThumbTablePresenter
    
    
    @IBOutlet private var tableView: UITableView!
    
    init(nibName: String, presenter: TitleAndThumbTablePresenter) {
        tablePresenter = presenter
        tableDatasource = TitleAndThumbTableDatasource(presenter: tablePresenter)
        tableDelegate = TitleAndThumbTableDelegate(presenter: tablePresenter)
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("TitleAndThumbTableController is not meant to be intantiated from a nib.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        tablePresenter.viewLoaded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tablePresenter.viewAppeared()
    }
    
    func setup() {
        navigationItem.title = tablePresenter.title
        
        tableView.dataSource = tableDatasource
        tableView.delegate = tableDelegate
        tableDatasource.registerCell(forTableView: tableView)
        
        replaceBackButton()
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
}
