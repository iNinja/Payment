//
//  AppCoordinator.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    fileprivate let navigationController: UINavigationController
    fileprivate let eventTracker = ConsoleEventTracker()
    fileprivate let networkClient = AlamofireNetworkClient(baseURL: "https://api.mercadopago.com", defaultParameters: ["public_key": "444a9ef5-8a6b-429f-abdf-587639155d88"])
    
    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        navigationController.viewControllers = [mainController()]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func mainController() -> MainController {
        let interactor = MainInteractor(output: self, eventTracker: eventTracker)
        let presenter = MainPresenter(interactor: interactor, timeable: MainThreadTimeable())
        let view = MainController(presenter: presenter)
        presenter.view = view
        return view
    }
}

// Each of this extensions could go in its own file
extension AppCoordinator: MainOutput {
    func showAbout() {
        let interactor = AboutInteractor(eventTracker: eventTracker)
        let presenter = AboutPresenter(interactor: interactor)
        let view = AboutController(presenter: presenter)
        presenter.view = view
        navigationController.pushViewController(view, animated: true)
    }
    
    func showPaymentMethods(for payment: Float) {
        let repository = PaymentMethodNetworkRepository(networkClient: networkClient)
        let interactor = PaymentMethodInteractor(repository: repository, eventTracker: eventTracker, output: self, amount: payment)
        let presenter = PaymentMethodPresenter(interactor: interactor)
        let view = PaymentMethodController(presenter: presenter)
        presenter.view = view
        navigationController.pushViewController(view, animated: true)
    }
}

extension AppCoordinator: PaymentMethodOutput {
    func cancelPaymentProcess() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func showCardProvidersFor(paymentMethod: PaymentMethod, amount: Float) {
        let repository = CardIssuerNetworkRepository(networkClient: networkClient, paymentMethodId: paymentMethod.id)
        let interactor = CardIssuerInteractor(repository: repository, eventTracker: eventTracker, output: self, amount: amount, paymentMethod: paymentMethod)
        let presenter = CardIssuerPresenter(interactor: interactor)
        let view = CardIssuerController(presenter: presenter)
        presenter.view = view
        navigationController.pushViewController(view, animated: true)
    }
}

extension AppCoordinator: CardIssuerOutput {
    func cancelCardIssuerSelection() {
        navigationController.popViewController(animated: true)
    }
    
    func showInstallmentOptionsFor(paymentMethod: PaymentMethod, cardIssuer: CardIssuer, amount: Float) {
        let repository = InstallmentOptionNetworkRepository(networkClient: networkClient, amount: amount, paymentMethodId: paymentMethod.id , cardIssuerId: cardIssuer.id)
        let processPayment = ProcessPayment(amount: amount, paymentMethod: paymentMethod, cardIssuer: cardIssuer, timeable: MainThreadTimeable())
        let interactor = InstallmentOptionInteractor(repository: repository, eventTracker: eventTracker, output: self, processPayment: processPayment)
        let presenter = InstallmentOptionPresenter(interactor: interactor)
        let view = InstallmentOptionController(presenter: presenter)
        presenter.view = view
        navigationController.pushViewController(view, animated: true)
    }
}

extension AppCoordinator: InstallmentOptionOutput {
    func cancelInstallmentOptionSelection() {
        navigationController.popViewController(animated: true)
    }
    
    func completePaymentFlow() {
        navigationController.popToRootViewController(animated: true)
    }
}
