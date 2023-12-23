//
//  MockShowFavoriteViewModel.swift
//  BookFinderTests
//
//  Created by Geisel Roque on 22/12/23.
//

import Foundation
@testable import BookFinder

class MockShowFavoritesViewModel: ShowFavoritesViewModelProtocol {

    var books: [BookDetailsData]

    var didOpenDetailBook = false
    var selectedBook: BookDetailsData?

    init(books: [BookDetailsData] = []) {
        self.books = books
    }

}

