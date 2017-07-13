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
    @IBOutlet private var tableView: UITableView!
    let cellIdentifier = "PaymentMethodCell"
    
    init(presenter: PaymentMethodPresenter) {
        self.presenter = presenter
        
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
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        replaceBackButton()
    }
}

extension PaymentMethodController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.elementCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! PaymentMethodCell
        cell.paymentMethodImageView.image = nil
        cell.paymentMethodLabel.text = presenter.elementTitle(at: indexPath.row)
        cell.paymentMethodImageView.af_setImage(withURL: presenter.elementImageURL(at: indexPath.row))
        return cell
    }
}

extension PaymentMethodController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.viewSelectedElementAt(idx: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
