//
//  MockHomeViewModel.swift
//  BookFinderTests
//
//  Created by Geisel Roque on 22/12/23.
//

import Foundation
@testable import BookFinder

class MockHomeViewModel: HomeViewModelProtocol {
    var books: [BookDetailsData] = []
    weak var delegate: HomeViewModelDelegate?

    func getInfoBooks(query: String) {
        self.books = [
            BookDetailsData(id: "3",
                            volumeInfo: VolumeData(title: "Book 3",
                                                   authors: ["Author 3"],
                                                   description: "Description 3", imageLinks: nil)),
            BookDetailsData(id: "4",
                            volumeInfo: VolumeData(title: "Book 4",
                                                   authors: ["Author 4"],
                                                   description: "Description 4", imageLinks: nil))
        ]
        delegate?.didLoadData()
    }
}
