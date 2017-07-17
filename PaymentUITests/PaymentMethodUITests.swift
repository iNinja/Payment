//
//  PaymentMethodUITests.swift
//  Payment
//
//  Created by Ignacio Inglese on 7/16/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import XCTest

class PaymentMethodUITests: XCTestCase {
        
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
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_InitialState() {
        let app = XCUIApplication()
        let predicate = NSPredicate(format: "count > 0")
        let tableLoad = expectation(for: predicate, evaluatedWith: app.tables.cells, handler: nil)
        
        XCTWaiter.wait(for: [tableLoad], timeout: 5)
        
        XCTAssertTrue(app.navigationBars["Select Payment Method"].exists)
        XCTAssertTrue(app.tables.cells.count > 0)
        XCTAssertTrue(app.staticTexts["Visa"].exists)
    }
    
    func test_SelectPaymentMethod() {
        let app = XCUIApplication()
        let predicate = NSPredicate(format: "count > 0")
        let tableLoad = expectation(for: predicate, evaluatedWith: app.tables.cells, handler: nil)
        
        XCTWaiter.wait(for: [tableLoad], timeout: 5)
        app.staticTexts["Visa"].tap()
        
        XCTAssertTrue(app.navigationBars["Select Provider"].exists)
    }
    
    func test_CancelPaymentMethodSelection() {
        let app = XCUIApplication()
        app.navigationBars["Select Payment Method"].buttons["Cancel"].tap()
        
        XCTAssertTrue(app.navigationBars["Payment Test"].exists)
    }
    
}
