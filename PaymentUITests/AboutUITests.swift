//
//  AboutUITests.swift
//  Payment
//
//  Created by Ignacio Inglese on 7/16/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import XCTest

class AboutUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launch()
        
        app.alerts["Welcome"].buttons["Alright"].tap()
        app.navigationBars["Payment Test"].buttons["About"].tap()
    }

    
    func test_initialState() {
        let app = XCUIApplication()
        
        XCTAssertTrue(app.navigationBars["About"].exists)
        XCTAssertEqual(app.staticTexts["Content"].label, "This is a sample about screen created programatically without a nib file. It has no output or use cases since it's static and it only goes back to the previous screen. The interactor has been added to keep tracking the section changes. Constraints have been added programatically on this screen.")
        
    }
    
}
