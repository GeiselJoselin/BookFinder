//
//  MockDetailBookViewModel.swift
//  BookFinderTests
//
//  Created by Geisel Roque on 22/12/23.
//

import Foundation
@testable import BookFinder

class MockDetailBookViewModel: DetailBookViewModelProtocol {

    var bookData: BookDetailsData
    var isFavorite: Bool

    init(bookData: BookDetailsData, isFavorite: Bool = false) {
        self.bookData = bookData
        self.isFavorite = isFavorite
    }
}
