//
//  ConsoleEventTracker.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

class ConsoleEventTracker: EventTracker {
    func trackEvent(_ event: String, parameters: [String : String]?) {
        var message = "Tracking event " + event
        if let parameters = parameters {
            message += " with parameters \(parameters)"
        }
        print(message)
    }
}
