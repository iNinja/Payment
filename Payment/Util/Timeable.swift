//
//  Timeable.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/13/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

protocol Timeable {
    func asyncAfter(time: TimeInterval, action: @escaping () -> Void)
}

class MainThreadTimeable: Timeable {
    func asyncAfter(time: TimeInterval, action: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: action)
    }
}
