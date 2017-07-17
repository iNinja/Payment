//
//  AboutController.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import UIKit

final class AboutController: UIViewController, AboutView {
    private let label: UILabel
    let presenter: AboutPresenter
    
    init(presenter: AboutPresenter) {
        self.presenter = presenter
        label = UILabel()
        
        super.init(nibName: nil, bundle: nil)
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
    
    private func setup() {
        view.backgroundColor = .white
        navigationItem.title = presenter.title
        setupLabel()
        setupConstraints()
        
        replaceBackButton()
    }
    
    private func setupLabel() {
        label.font = UIFont.systemFont(ofSize: 20)
        label.accessibilityIdentifier = "Content"
        label.text = presenter.content
        label.numberOfLines = 0
        view.addSubview(label)
    }
    
    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }

}
