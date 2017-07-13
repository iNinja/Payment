//
//  InstallmentOptionTests.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import XCTest
@testable import Payment

class InstallmentOptionTests: XCTestCase {
    var view: MockInstallmentOptionView!
    var presenter: InstallmentOptionPresenter!
    var interactor: InstallmentOptionInteractor!
    var output: MockInstallmentOptionOutput!
    var eventTracker: MockEventTracker!
    var repository: InstallmentOptionRepository!
    var networkClient: MockNetworkClient!
    
    override func setUp() {
        output = MockInstallmentOptionOutput()
        eventTracker = MockEventTracker()
    }
    
    func test_LoadingViewShowsIndicatorAndReloadsTable() {
        givenANetworkClientWithValidData()
        givenAViewWithDependencies()
        
        whenLoadingTheView()
        
        XCTAssertEqual(view.startLoadingCalls, 1)
        XCTAssertEqual(view.stopLoadingCalls, 1)
        XCTAssertEqual(view.reloadInstallmentOptionCalls, 1)
    }
    
    func test_TracksViewAppearing() {
        givenANetworkClientWithValidData()
        givenAViewWithDependencies()
        
        whenTheViewAppears()
        
        XCTAssertEqual(eventTracker.trackedEvents.count, 1)
        XCTAssertTrue(eventTracker.trackedEvent(named: "Entered Section"))
        XCTAssertEqual(eventTracker.trackedEvents[0].parameters!["section"], "Installment Option")
    }
    
    func test_loadsDataCorrectly() {
        givenANetworkClientWithValidData()
        givenAViewWithDependencies()
        
        whenLoadingTheView()
        
        XCTAssertEqual(presenter.title, "Select Installments")
        XCTAssertEqual(presenter.elementCount, 5)
        XCTAssertEqual(presenter.elementTitle(at: 0), "1 cuota de $ 15,00 ($ 15,00)")
    }
    
    func test_CallsCorrectEndpoint() {
        givenANetworkClientWithValidData()
        givenAViewWithDependencies()
        
        whenLoadingTheView()
        
        XCTAssertEqual(networkClient.path, "v1/payment_methods/installments")
        XCTAssertEqual(networkClient.parameters!, ["payment_method_id": "visa", "issuer_id": "288", "amount": "100.0"])
    }
    
    func test_showsErrorOnInvalidData() {
        givenANetworkClientWithInvalidData()
        givenAViewWithDependencies()
        
        whenLoadingTheView()
        
        XCTAssertEqual(view.errorMessages.count, 1)
        XCTAssertEqual(view.errorMessages[0], "There was an error attempting to retrieve installments.\nPlease try again.")
    }
    
    func test_showsErrorOnEmptyData() {
        givenANetworkClientWithEmptyData()
        givenAViewWithDependencies()
        
        whenLoadingTheView()
        
        XCTAssertEqual(view.errorMessages.count, 1)
        XCTAssertEqual(view.errorMessages[0], "There was an error attempting to retrieve installments.\nPlease try again.")
    }
    
    func test_showsErrorOnRequestFailure() {
        givenAFailingNetworkClient()
        givenAViewWithDependencies()
        
        whenLoadingTheView()
        
        XCTAssertEqual(view.errorMessages.count, 1)
        XCTAssertEqual(view.errorMessages[0], "There was an error attempting to retrieve installments.\nPlease try again.")
    }
    
    func test_HandlesCancelAction() {
        givenANetworkClientWithValidData()
        givenALoadedViewWithDependencies()
        
        whenCancelIsSelected()
        
        XCTAssertEqual(output.cancelIntallmentOptionsSelectionCalls, 1)
        XCTAssertEqual(eventTracker.trackedEvents.count, 2) // first event is the retrieval of data
        XCTAssertTrue(eventTracker.trackedEvent(named: "Installment Option Selection cancelled"))
    }
    
    func test_HandlesDataSelection() {
        givenANetworkClientWithValidData()
        givenALoadedViewWithDependencies()
        
        whenDataIsSelected()
        
        XCTAssertEqual(output.completePaymentFlowCalls, 1)
        XCTAssertEqual(view.alertMessages.count, 1)
        XCTAssertEqual(eventTracker.trackedEvents.count, 3)
        XCTAssertTrue(eventTracker.trackedEvent(named: "Installment Option Selected"))
        XCTAssertTrue(eventTracker.trackedEvent(named: "Payment Processed"))
    }
    
    
    func givenANetworkClientWithValidData() {
        networkClient = MockNetworkClient(jsonFile: "InstallmentOptions_Valid", error: nil)
    }
    
    func givenANetworkClientWithEmptyData() {
        networkClient = MockNetworkClient(jsonFile: "InstallmentOptions_Empty", error: nil)
    }
    
    func givenANetworkClientWithInvalidData() {
        networkClient = MockNetworkClient(jsonFile: "InstallmentOptions_Invalid", error: nil)
    }
    
    func givenAFailingNetworkClient() {
        networkClient = MockNetworkClient(jsonFile: nil, error: RepositoryError.Unknown)
    }
    
    func givenAViewWithDependencies() {
        let paymentMethod = PaymentMethod(id: "visa", type: .creditCard, name: "Visa", thumbnailURL: URL(string: "http://www.google.com")!)
        let cardIssuer = CardIssuer(id: "288", name: "Tarjet Shopping", thumbnailURL: URL(string:"http://www.google.com")!)
        repository = InstallmentOptionNetworkRepository(networkClient: networkClient, amount: 100, paymentMethodId: paymentMethod.id, cardIssuerId: cardIssuer.id)
        let processPayment = ProcessPayment(amount: 100, paymentMethod: paymentMethod, cardIssuer: cardIssuer, timeable: MockTimeable())
        interactor = InstallmentOptionInteractor(repository: repository, eventTracker: eventTracker, output: output, processPayment: processPayment)
        presenter = InstallmentOptionPresenter(interactor: interactor)
        view = MockInstallmentOptionView(presenter: presenter)
        presenter.view = view
    }
    
    func givenALoadedViewWithDependencies() {
        givenAViewWithDependencies()
        
        presenter.viewLoaded()
    }
    
    func whenLoadingTheView() {
        presenter.viewLoaded()
    }
    
    func whenTheViewAppears() {
        presenter.viewAppeared()
    }
    
    func whenCancelIsSelected() {
        presenter.viewSelectedCancel()
    }
    
    func whenDataIsSelected() {
        presenter.viewSelectedElementAt(idx: 0)
    }
}
