//
//  InstallmentOptionController.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import UIKit

class InstallmentOptionController: UIViewController, InstallmentOptionView {
    let presenter: InstallmentOptionPresenter
    @IBOutlet private var tableView: UITableView!
    let cellIdentifier = "Cell"
    
    init(presenter: InstallmentOptionPresenter) {
        self.presenter = presenter
        
        super.init(nibName: "InstallmentOptionController", bundle: nil)
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
    
    func reloadInstallmentOptions() {
        tableView.reloadData()
    }
    
    private func setup() {
        navigationItem.title = presenter.title
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: presenter.cancelTitle, style: .plain, target: self, action: #selector(cancelTapped))
    }
    
    @objc func cancelTapped() {
        presenter.viewSelectedCancel()
    }
}

extension InstallmentOptionController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.elementCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        cell.textLabel?.text = presenter.elementTitle(at: indexPath.row)
        return cell
    }
}

extension InstallmentOptionController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.viewSelectedElementAt(idx: indexPath.row)
    }
}
