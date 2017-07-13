//
//  AboutTests.swift
//  Payment
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import XCTest
@testable import Payment

class AboutTests: XCTestCase {
    var view: MockAboutView!
    var presenter: AboutPresenter!
    var interactor: AboutInteractor!
    var eventTracker: MockEventTracker!
    
    override func setUp() {
        super.setUp()
        
        eventTracker = MockEventTracker()
        interactor = AboutInteractor(eventTracker: eventTracker)
        presenter = AboutPresenter(interactor: interactor)
        view = MockAboutView(presenter: presenter)
        presenter.view = view
    }
    
    func test_ShowsCorrectData() {
        whenViewLoads()
        
        XCTAssertEqual(presenter.title, "About".localized)
        XCTAssertEqual(presenter.content, "This is a sample about screen created programatically without a nib file.\nIt has no output or use cases since it's static and it only goes back to the previous screen.\nThe interactor has been added to keep tracking the section changes.\nConstraints have been added programatically on this screen.".localized)
    }
    
    func test_TracksViewAppearing() {
        whenViewAppears()
        
        XCTAssertEqual(eventTracker.trackedEvents.count, 1)
        XCTAssertTrue(eventTracker.trackedEvent(named: "Entered Section"))
        XCTAssertEqual(eventTracker.trackedEvents[0].parameters!["section"], "About")
    }
    
    func whenViewAppears() {
        presenter.viewAppeared()
    }
    
    func whenViewLoads() {
        presenter.viewLoaded()
    }
    
}
