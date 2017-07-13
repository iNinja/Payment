//
//  MainController.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import UIKit

final class MainController: UIViewController, MainView {
    internal let presenter: MainPresenter
    internal var userInput: String { return textfield.text ?? "" }
    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var textfield: UITextField!
    @IBOutlet private var button: UIButton!
    
    init(presenter: MainPresenter) {
        self.presenter = presenter
        super.init(nibName: "MainController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This view is not meant to be instantiated from a decoder.")
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        textfield.text = ""
    }
    
    private func setup() {
        navigationItem.title = presenter.title
        navigationItem.rightBarButtonItem = aboutButtonItem()
        messageLabel.text = presenter.message
        button.setTitle(presenter.callToAction, for: .normal)
        
        replaceBackButton()
    }
    
    private func aboutButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(title: presenter.aboutTitle,
                               style: .plain,
                               target: self,
                               action: #selector(aboutTapped))
    }
    
    @IBAction private func payTapped() {
        presenter.viewSelectedPay()
    }
    
    @objc private func aboutTapped() {
        presenter.viewSelectedAbout()
    }
}
