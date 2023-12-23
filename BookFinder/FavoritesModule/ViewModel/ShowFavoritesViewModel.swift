//
//  ShowFavoritesViewModel.swift
//  BookFinder
//
//  Created by Geisel Roque on 22/12/23.
//

import Foundation

protocol ShowFavoritesViewModelProtocol {
    var books: [BookDetailsData] { get set }
}

final class ShowFavoritesViewModel: ShowFavoritesViewModelProtocol {

    var books: [BookDetailsData]

    init(books: [BookDetailsData]) {
        self.books = books
    }
}
