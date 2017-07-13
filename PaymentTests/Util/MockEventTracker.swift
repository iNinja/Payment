//
//  MockEventTracker.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation
@testable import Payment

struct TrackingEvent {
    let name: String
    let parameters: [String: String]?
}

class MockEventTracker: EventTracker {
    var trackedEvents: [TrackingEvent] = []
    
    func trackEvent(_ event: String, parameters: [String : String]?) {
        trackedEvents.append(TrackingEvent(name: event, parameters: parameters))
    }
    
    func trackedEvent(named name: String) -> Bool {
        return trackedEvents.filter { $0.name == name }.count > 0
    }
}
