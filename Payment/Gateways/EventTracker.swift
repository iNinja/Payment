//
//  EventTracker.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

protocol EventTracker {
    func trackEvent(_ event: String, parameters: [String: String]?)
    func trackSectionChange(name: String)
}

extension EventTracker {
    func trackSectionChange(name: String) {
        trackEvent("Entered Section", parameters: ["section": name])
    }
}
