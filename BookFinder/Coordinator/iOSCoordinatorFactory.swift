//
//  iOSCoordinatorFactory.swift
//  BookFinder
//
//  Created by Geisel Roque on 21/12/23.
//

import UIKit

protocol ViewControllerFactory {
    func homeViewController() -> UIViewController
    func detailBookViewController(bookData: BookDetailsData) -> UIViewController
    func showFavoritesViewController() -> UIViewController
}

class CoordinatorFactory: ViewControllerFactory {
    
    func homeViewController() -> UIViewController {
        let googleAPI = GoogleBooksAPI()
        let viewModel = HomeViewModel(googleBooksAPI: googleAPI)
        let homeViewController = HomeViewController(viewModel: viewModel)
        return homeViewController
    }
    
    func detailBookViewController(bookData: BookDetailsData) -> UIViewController {
        let viewModel = DetailBookViewModel(volumeData: bookData)
        let detailBookViewController = DetailBookViewController(viewModel: viewModel)
        return detailBookViewController
    }

    func showFavoritesViewController() -> UIViewController {
        let books = FavoritesManager.getFavoriteBooks()
        let viewModel = ShowFavoritesViewModel(books: books)
        let showFavoritesViewController = ShowFavoritesViewController(viewModel: viewModel)
        return showFavoritesViewController
    }
}
