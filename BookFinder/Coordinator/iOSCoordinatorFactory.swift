//
//  iOSCoordinatorFactory.swift
//  BookFinder
//
//  Created by Geisel Roque on 21/12/23.
//

import UIKit

protocol ViewControllerFactory {
    func homeViewController() -> UIViewController
}

class CoordinatorFactory: ViewControllerFactory {
    
    func homeViewController() -> UIViewController {
        let googleAPI = GoogleBooksAPI()
        let homeViewController = HomeViewController()
        return homeViewController
    }
}
