//
//  CardIssuerTests.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import XCTest
@testable import Payment

class CardIssuerTests: XCTestCase {
    var view: MockCardIssuerView!
    var presenter: CardIssuerPresenter!
    var interactor: CardIssuerInteractor!
    var output: MockCardIssuerOutput!
    var eventTracker: MockEventTracker!
    var repository: CardIssuerRepository!
    var networkClient: MockNetworkClient!
    
    override func setUp() {
        output = MockCardIssuerOutput()
        eventTracker = MockEventTracker()
    }
    
    func test_LoadingViewShowsIndicatorAndReloadsTable() {
        givenANetworkClientWithValidData()
        givenAViewWithDependencies()
        
        whenLoadingTheView()
        
        XCTAssertEqual(view.startLoadingCalls, 1)
        XCTAssertEqual(view.stopLoadingCalls, 1)
        XCTAssertEqual(view.reloadCardIssuersCalls, 1)
    }
    
    func test_TracksViewAppearing() {
        givenANetworkClientWithValidData()
        givenAViewWithDependencies()
        
        whenTheViewAppears()
        
        XCTAssertEqual(eventTracker.trackedEvents.count, 1)
        XCTAssertTrue(eventTracker.trackedEvent(named: "Entered Section"))
        XCTAssertEqual(eventTracker.trackedEvents[0].parameters!["section"], "Card Issuer")
    }
    
    func test_loadsDataCorrectly() {
        givenANetworkClientWithValidData()
        givenAViewWithDependencies()
        
        whenLoadingTheView()
        
        XCTAssertEqual(presenter.title, "Select Provider")
        XCTAssertEqual(presenter.elementCount, 27)
        XCTAssertEqual(presenter.elementTitle(at: 0), "Tarjeta Shopping")
        XCTAssertEqual(presenter.elementImageURL(at: 0).absoluteString, "https://www.mercadopago.com/org-img/MP3/API/logos/288.gif")
    }
    
    func test_CallsCorrectEndpoint() {
        givenANetworkClientWithValidData()
        givenAViewWithDependencies()
        
        whenLoadingTheView()
        
        XCTAssertEqual(networkClient.path, "v1/payment_methods/card_issuers")
        XCTAssertEqual(networkClient.parameters!, ["payment_method_id": "visa"])
    }
    
    func test_showsErrorOnInvalidData() {
        givenANetworkClientWithInvalidData()
        givenAViewWithDependencies()
        
        whenLoadingTheView()
        
        XCTAssertEqual(view.errorMessages.count, 1)
        XCTAssertEqual(view.errorMessages[0], "There was an error attempting to retrieve providers.\nPlease try again.")
    }
    
    func test_showsErrorOnEmptyData() {
        givenANetworkClientWithEmptyData()
        givenAViewWithDependencies()
        
        whenLoadingTheView()
        
        XCTAssertEqual(view.errorMessages.count, 1)
        XCTAssertEqual(view.errorMessages[0], "There was an error attempting to retrieve providers.\nPlease try again.")
    }
    
    func test_showsErrorOnRequestFailure() {
        givenAFailingNetworkClient()
        givenAViewWithDependencies()
        
        whenLoadingTheView()
        
        XCTAssertEqual(view.errorMessages.count, 1)
        XCTAssertEqual(view.errorMessages[0], "There was an error attempting to retrieve providers.\nPlease try again.")
    }
    
    func test_HandlesCancelAction() {
        givenANetworkClientWithValidData()
        givenALoadedViewWithDependencies()
        
        whenCancelIsSelected()
        
        XCTAssertEqual(output.cancelCardIssuerSelectionCalls, 1)
        XCTAssertEqual(eventTracker.trackedEvents.count, 2) // first event is the retrieval of data
        XCTAssertTrue(eventTracker.trackedEvent(named: "Card Issuer Selection Cancelled"))
    }
    
    func test_HandlesDataSelection() {
        givenANetworkClientWithValidData()
        givenALoadedViewWithDependencies()
        
        whenDataIsSelected()
        
        XCTAssertEqual(output.cardIssuersEntered.count, 1)
        XCTAssertEqual(eventTracker.trackedEvents.count, 2) // first event is the retrieval of data
        XCTAssertTrue(eventTracker.trackedEvent(named: "Card Issuer Selected"))
    }
    
    
    func givenANetworkClientWithValidData() {
        networkClient = MockNetworkClient(jsonFile: "CardIssuers_Valid", error: nil)
    }
    
    func givenANetworkClientWithEmptyData() {
        networkClient = MockNetworkClient(jsonFile: "CardIssuers_Empty", error: nil)
    }
    
    func givenANetworkClientWithInvalidData() {
        networkClient = MockNetworkClient(jsonFile: "CardIssuers_Invalid", error: nil)
    }
    
    func givenAFailingNetworkClient() {
        networkClient = MockNetworkClient(jsonFile: nil, error: RepositoryError.Unknown)
    }
    
    func givenAViewWithDependencies() {
        let paymentMethod = PaymentMethod(id: "visa", type: .creditCard, name: "Visa", thumbnailURL: URL(string: "http://www.google.com")!)
        repository = CardIssuerNetworkRepository(networkClient: networkClient, paymentMethodId: paymentMethod.id)
        interactor = CardIssuerInteractor(repository: repository, eventTracker: eventTracker, output: output, amount: 100, paymentMethod: paymentMethod)
        presenter = CardIssuerPresenter(interactor: interactor)
        view = MockCardIssuerView(presenter: presenter)
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
