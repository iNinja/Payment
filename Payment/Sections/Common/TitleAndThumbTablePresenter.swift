//
//  TitleAndThumbTablePresenter.swift
//  Payment
//
//  Created by Ignacio Inglese on 7/16/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

protocol TitleAndThumbTablePresenter {
    var title: String { get }
    var cancelTitle: String { get }
    var elementCount: Int { get }
    
    func elementTitle(at idx: Int) -> String
    func elementThumbURL(at idx: Int) -> URL
    func viewSelectedElementAt(idx: Int)
    func viewSelectedCancel()
    
    func viewLoaded()
    func viewAppeared()
    
}
