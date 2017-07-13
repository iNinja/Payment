//
//  MockTimeable.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation
@testable import Payment

class MockTimeable: Timeable {
    func asyncAfter(time: TimeInterval, action: @escaping () -> Void) {
        action()
    }
}
