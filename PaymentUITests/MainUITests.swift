//
//  MainUITests.swift
//  PaymentUITests
//
//  Created by Ignacio Inglese on 7/16/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import XCTest

class MainUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func test_InitialState() {
        let app = XCUIApplication()
        let element = app.alerts.element
        
        XCTAssertEqual(element.label, "Welcome")
        XCTAssertTrue(element.staticTexts["This is a test app using MercadoPago's API to showcase technical knowledge."].exists)
        XCTAssertTrue(app.navigationBars["Payment Test"].exists)
    }
    
    func test_InvalidInput() {
        let app = XCUIApplication()
        app.alerts["Welcome"].buttons["Alright"].tap()
        
        let amountTextField = app.textFields["Amount"]
        amountTextField.tap()
        amountTextField.typeText("-1")
        app.buttons["Pay"].tap()
        
        let element = XCUIApplication().alerts.element
        XCTAssertEqual(element.label, "Error")
        XCTAssertTrue(element.staticTexts["Amount to pay must be greater than zero."].exists)
    }
    
    func test_EmptyInput() {
        let app = XCUIApplication()
        app.alerts["Welcome"].buttons["Alright"].tap()
        
        app.buttons["Pay"].tap()
        
        let element = XCUIApplication().alerts.element
        XCTAssertEqual(element.label, "Error")
        XCTAssertTrue(element.staticTexts["Please enter a valid amount"].exists)
    }
    
    func test_About() {
        
        let app = XCUIApplication()
        app.alerts["Welcome"].buttons["Alright"].tap()
        app.navigationBars["Payment Test"].buttons["About"].tap()
        
        XCTAssertTrue(app.navigationBars["About"].exists)
    }
    
    func test_ValidInput() {
        
        let app = XCUIApplication()
        app.alerts["Welcome"].buttons["Alright"].tap()
        
        let amountTextField = app.textFields["Amount"]
        amountTextField.tap()
        amountTextField.typeText("100")
        app.buttons["Pay"].tap()
        
        XCTAssertTrue(app.navigationBars["Select Payment Method"].exists)
    }
}
