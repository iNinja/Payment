//
//  AboutInteractor.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

final class AboutInteractor {
    private let eventTracker: EventTracker
    
    init(eventTracker: EventTracker) {
        self.eventTracker = eventTracker
    }
    
    func trackImpression() {
        eventTracker.trackSectionChange(name: "About")
    }
}
