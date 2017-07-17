//
//  InstallmentOptionUITests.swift
//  Payment
//
//  Created by Ignacio Inglese on 7/16/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import XCTest

class InstallmentOptionUITests: XCTestCase {
        
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
        cells.staticTexts["Banco Galicia"].tap()
    }
    
    func test_InitialState() {
        let app = XCUIApplication()
        let predicate = NSPredicate(format: "count > 0")
        let tableLoad = expectation(for: predicate, evaluatedWith: app.tables.cells, handler: nil)
        
        XCTWaiter.wait(for: [tableLoad], timeout: 5)
        
        XCTAssertTrue(app.navigationBars["Select Installments"].exists)
        XCTAssertTrue(app.tables.cells.count > 0)
    }
    
    func test_SelectPaymentMethod() {
        let app = XCUIApplication()
        let predicate = NSPredicate(format: "count > 0")
        let tableLoad = expectation(for: predicate, evaluatedWith: app.tables.cells, handler: nil)
        
        XCTWaiter.wait(for: [tableLoad], timeout: 5)
        app.tables.cells.element(boundBy: 0).tap()
        
        let alertShow = expectation(for: predicate, evaluatedWith: app.alerts, handler: nil)
        XCTWaiter.wait(for: [alertShow], timeout: 5)
        
        XCTAssertTrue(app.alerts["Success"].exists)
        XCTAssertEqual(app.alerts["Success"].staticTexts.element(boundBy: 1).label, "You have paid $100.0 with your Visa card from Banco Galicia in 1 cuota de $ 100,00 ($ 100,00).")
        
        app.alerts["Success"].buttons["OK"].tap()
        
        XCTAssertTrue(app.navigationBars["Payment Test"].exists)
    }
    
    func test_CancelPaymentMethodSelection() {
        let app = XCUIApplication()
        app.navigationBars["Select Installments"].buttons["Cancel"].tap()
        
        XCTAssertTrue(app.navigationBars["Select Provider"].exists)
    }
    
}
