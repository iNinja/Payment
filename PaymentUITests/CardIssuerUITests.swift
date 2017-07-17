//
//  CardIssuerUITests.swift
//  Payment
//
//  Created by Ignacio Inglese on 7/16/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import XCTest

class CardIssuerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launch()
        app.alerts["Welcome"].buttons["Alright"].tap()
        
        let amountTextField = app.textFields["Amount"]
        amountTextField.tap()
        amountTextField.typeText("100")
        app.buttons["Pay"].tap()
        
        let cells = app.tables.cells
        cells.staticTexts["Visa"].tap()
    }
    
    func test_InitialState() {
        let app = XCUIApplication()
        let predicate = NSPredicate(format: "count > 0")
        let tableLoad = expectation(for: predicate, evaluatedWith: app.tables.cells, handler: nil)
        
        XCTWaiter.wait(for: [tableLoad], timeout: 5)
        
        XCTAssertTrue(app.navigationBars["Select Provider"].exists)
        XCTAssertTrue(app.tables.cells.count > 0)
        XCTAssertTrue(app.staticTexts["Banco Galicia"].exists)
    }
    
    func test_SelectCardIssuer() {
        let app = XCUIApplication()
        let predicate = NSPredicate(format: "count > 0")
        let tableLoad = expectation(for: predicate, evaluatedWith: app.tables.cells, handler: nil)
        
        XCTWaiter.wait(for: [tableLoad], timeout: 5)
        app.staticTexts["Banco Galicia"].tap()
        
        XCTAssertTrue(app.navigationBars["Select Installments"].exists)
    }
    
    func test_CancelCardIssuerSelection() {
        let app = XCUIApplication()
        app.navigationBars["Select Provider"].buttons["Cancel"].tap()
        
        XCTAssertTrue(app.navigationBars["Select Payment Method"].exists)
    }
    
}
