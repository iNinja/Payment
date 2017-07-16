//
//  PaymentMethodTests.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import XCTest
@testable import Payment

class PaymentMethodTests: XCTestCase {
    var view: MockPaymentMethodView!
    var presenter: PaymentMethodPresenter!
    var interactor: PaymentMethodInteractor!
    var output: MockPaymentMethodOutput!
    var eventTracker: MockEventTracker!
    var repository: PaymentMethodRepository!
    var networkClient: MockNetworkClient!
    
    override func setUp() {
        output = MockPaymentMethodOutput()
        eventTracker = MockEventTracker()
    }
    
    func test_LoadingViewShowsIndicatorAndReloadsTable() {
        givenANetworkClientWithValidData()
        givenAViewWithDependencies()
        
        whenLoadingTheView()
        
        XCTAssertEqual(view.startLoadingCalls, 1)
        XCTAssertEqual(view.stopLoadingCalls, 1)
        XCTAssertEqual(view.reloadPaymentMethodsCalls, 1)
    }
    
    func test_TracksViewAppearing() {
        givenANetworkClientWithValidData()
        givenAViewWithDependencies()
        
        whenTheViewAppears()
        
        XCTAssertEqual(eventTracker.trackedEvents.count, 1)
        XCTAssertTrue(eventTracker.trackedEvent(named: "Entered Section"))
        XCTAssertEqual(eventTracker.trackedEvents[0].parameters!["section"], "Payment Method")
    }
    
    func test_loadsDataCorrectly() {
        givenANetworkClientWithValidData()
        givenAViewWithDependencies()
        
        whenLoadingTheView()
        
        XCTAssertEqual(presenter.title, "Select Payment Method")
        XCTAssertEqual(presenter.elementCount, 4)
        XCTAssertEqual(presenter.elementTitle(at: 0), "Visa")
        XCTAssertEqual(presenter.elementThumbURL(at: 0).absoluteString, "https://www.mercadopago.com/org-img/MP3/API/logos/visa.gif")
    }
    
    func test_CallsCorrectEndpoint() {
        givenANetworkClientWithValidData()
        givenAViewWithDependencies()
        
        whenLoadingTheView()
        
        XCTAssertEqual(networkClient.path, "v1/payment_methods")
    }
    
    func test_showsErrorOnInvalidData() {
        givenANetworkClientWithInvalidData()
        givenAViewWithDependencies()
        
        whenLoadingTheView()
        
        XCTAssertEqual(view.errorMessages.count, 1)
        XCTAssertEqual(view.errorMessages[0], "There was an error attempting to retrieve payment methods.\nPlease try again.")
    }
    
    func test_showsErrorOnEmptyData() {
        givenANetworkClientWithEmptyData()
        givenAViewWithDependencies()
        
        whenLoadingTheView()
        
        XCTAssertEqual(view.errorMessages.count, 1)
        XCTAssertEqual(view.errorMessages[0], "There was an error attempting to retrieve payment methods.\nPlease try again.")
    }
    
    func test_showsErrorOnRequestFailure() {
        givenAFailingNetworkClient()
        givenAViewWithDependencies()
        
        whenLoadingTheView()
        
        XCTAssertEqual(view.errorMessages.count, 1)
        XCTAssertEqual(view.errorMessages[0], "There was an error attempting to retrieve payment methods.\nPlease try again.")
    }
    
    func test_HandlesCancelAction() {
        givenANetworkClientWithValidData()
        givenALoadedViewWithDependencies()
        
        whenCancelIsSelected()
        
        XCTAssertEqual(output.cancelPaymentProcessCalls, 1)
        XCTAssertEqual(eventTracker.trackedEvents.count, 2) // first event is the retrieval of data
        XCTAssertTrue(eventTracker.trackedEvent(named: "Payment Method Selection Cancelled"))
    }
    
    func test_HandlesDataSelection() {
        givenANetworkClientWithValidData()
        givenALoadedViewWithDependencies()
        
        whenDataIsSelected()
        
        XCTAssertEqual(output.amountsEntered.count, 1)
        XCTAssertEqual(output.paymentMethodsEntered[0].id, "visa")
        XCTAssertEqual(eventTracker.trackedEvents.count, 2) // first event is the retrieval of data
        XCTAssertTrue(eventTracker.trackedEvent(named: "Payment Method Selected"))
    }

    
    func givenANetworkClientWithValidData() {
        networkClient = MockNetworkClient(jsonFile: "PaymentMethods_Valid", error: nil)
    }
    
    func givenANetworkClientWithEmptyData() {
        networkClient = MockNetworkClient(jsonFile: "PaymentMethods_Empty", error: nil)
    }
    
    func givenANetworkClientWithInvalidData() {
        networkClient = MockNetworkClient(jsonFile: "PaymentMethods_Invalid", error: nil)
    }
    
    func givenAFailingNetworkClient() {
        networkClient = MockNetworkClient(jsonFile: nil, error: RepositoryError.Unknown)
    }
    
    func givenAViewWithDependencies() {
        repository = PaymentMethodNetworkRepository(networkClient: networkClient)
        interactor = PaymentMethodInteractor(repository: repository, eventTracker: eventTracker, output: output, amount: 100)
        presenter = PaymentMethodPresenter(interactor: interactor)
        view = MockPaymentMethodView(presenter: presenter)
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
