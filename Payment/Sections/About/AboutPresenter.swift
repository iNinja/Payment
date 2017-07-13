//
//  AboutPresenter.swift
//  payment test
//
//  Created by Ignacio Inglese on 7/12/17.
//  Copyright © 2017 Ignacio Inglese. All rights reserved.
//

import Foundation

final class AboutPresenter {
    weak var view: AboutView!
    private var interactor: AboutInteractor
    
    init(interactor: AboutInteractor) {
        self.interactor = interactor
    }
    
    var title: String { return "About".localized }
    var content: String {
        return "This is a sample about screen created programatically without a nib file.\nIt has no output or use cases since it's static and it only goes back to the previous screen.\nThe interactor has been added to keep tracking the section changes.\nConstraints have been added programatically on this screen.".localized
    }
    
    func viewLoaded() {
        
    }
    
    func viewAppeared() {
        interactor.trackImpression()
    }
}
