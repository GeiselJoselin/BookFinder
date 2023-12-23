//
//  iOSCoordinatorFactory.swift
//  BookFinder
//
//  Created by Geisel Roque on 21/12/23.
//

import UIKit

protocol ViewControllerFactory {
    func homeViewController() -> UIViewController
    func detailBookViewController(bookData: VolumeData) -> UIViewController
}

class CoordinatorFactory: ViewControllerFactory {
    
    func homeViewController() -> UIViewController {
        let googleAPI = GoogleBooksAPI()
        let viewModel = HomeViewModel(googleBooksAPI: googleAPI)
        let homeViewController = HomeViewController(viewModel: viewModel)
        return homeViewController
    }
    
    func detailBookViewController(bookData: VolumeData) -> UIViewController {
        let viewModel = DetailBookViewModel(volumeData: bookData)
        let detailBookViewController = DetailBookViewController(viewModel: viewModel)
        return detailBookViewController
    }
}
