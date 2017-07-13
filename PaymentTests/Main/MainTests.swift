//
//  MainTests.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import XCTest
@testable import Payment

class MainTests: XCTestCase {
    var view: MockMainView!
    var presenter: MainPresenter!
    var interactor: MainInteractor!
    var output: MockMainOutput!
    var eventTracker: MockEventTracker!
    
    override func setUp() {
        output = MockMainOutput()
        eventTracker = MockEventTracker()
        interactor = MainInteractor(output: output, eventTracker: eventTracker)
        presenter = MainPresenter(interactor: interactor, timeable: MockTimeable())
    }
    
    func test_LoadingViewShowsLoadingAndAlert() {
        givenAViewWithValidUserInput()
        
        whenLoadingTheView()
        
        XCTAssertEqual(view.startLoadingCalls, 1)
        XCTAssertEqual(view.stopLoadingCalls, 1)
        XCTAssertEqual(view.alertMessages.count, 1)
    }
    
    func test_TracksViewAppearing() {
        givenAViewWithValidUserInput()
        
        whenTheViewAppears()
        
        XCTAssertEqual(eventTracker.trackedEvents.count, 1)
        XCTAssertTrue(eventTracker.trackedEvent(named: "Entered Section"))
        XCTAssertEqual(eventTracker.trackedEvents[0].parameters!["section"], "Main")
    }
    
    func test_HandlesAndTracksShowAbout() {
        givenAViewWithValidUserInput()
        
        whenAboutIsSelected()
        
        XCTAssertEqual(output.showAboutCalls, 1)
        XCTAssertEqual(eventTracker.trackedEvents.count, 1)
        XCTAssertTrue(eventTracker.trackedEvent(named: "About Selected"))
    }
    
    func test_ShowsErrorWhenAttemptingToPayWithInvalidInput() {
        givenAViewWithInvalidUserInput()
        
        whenPayIsSelected()
        
        XCTAssertEqual(output.paymentsEntered.count, 0)
        XCTAssertEqual(eventTracker.trackedEvents.count, 1)
        XCTAssertTrue(eventTracker.trackedEvent(named: "Payment Failed"))
        XCTAssertEqual(eventTracker.trackedEvents[0].parameters!["reason"], "Invalid User Input")
    }
    
    func test_ShowsErrorWhenAttemptingToPayWithNegativeInput() {
        givenAViewWithNegativeUserInput()
        
        whenPayIsSelected()
        
        XCTAssertEqual(output.paymentsEntered.count, 0)
        XCTAssertEqual(eventTracker.trackedEvents.count, 1)
        XCTAssertTrue(eventTracker.trackedEvent(named: "Payment Failed"))
        XCTAssertEqual(eventTracker.trackedEvents[0].parameters!["reason"], "Invalid Amount")
    }
    
    func test_HandlesAndTracksPaymentRequest() {
        givenAViewWithValidUserInput()
        
        whenPayIsSelected()
        
        XCTAssertEqual(output.paymentsEntered.count, 1)
        XCTAssertEqual(output.paymentsEntered[0], 100)
        XCTAssertEqual(eventTracker.trackedEvents.count, 1)
        XCTAssertTrue(eventTracker.trackedEvent(named: "Pay Selected"))
    }
    
    func givenAViewWithInvalidUserInput() {
        view = MockMainView(presenter: presenter, userInput: "abc")
        presenter.view = view
    }
    
    func givenAViewWithNegativeUserInput() {
        view = MockMainView(presenter: presenter, userInput: "-100")
        presenter.view = view
    }
    
    func givenAViewWithValidUserInput() {
        view = MockMainView(presenter: presenter, userInput: "100")
        presenter.view = view
    }
    
    func whenLoadingTheView() {
        presenter.viewLoaded()
    }
    
    func whenTheViewAppears() {
        presenter.viewAppeared()
    }
    
    func whenAboutIsSelected() {
        presenter.viewSelectedAbout()
    }
    
    func whenPayIsSelected() {
        presenter.viewSelectedPay()
    }
    
}
