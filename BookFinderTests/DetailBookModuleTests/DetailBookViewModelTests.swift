//
//  DetailBookViewModelTests.swift
//  BookFinderTests
//
//  Created by Geisel Roque on 22/12/23.
//

import XCTest
@testable import BookFinder

class DetailBookViewModelTests: XCTestCase {

    var viewModel: DetailBookViewModelProtocol!

    override func setUp() {
        super.setUp()
        viewModel = DetailBookViewModel(volumeData: BookDetailsData(id: "1",
                                                                    volumeInfo: VolumeData(title: "Book 1",
                                                                                           authors: ["Author 1"],
                                                                                           description: "Description 1", imageLinks: nil)))
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testBookData() {
        // Assert
        XCTAssertNotNil(viewModel.bookData, "Book data should not be nil")
    }

    func testIsFavorite_WhenBookIsInFavorites() {
        // Arrange
        FavoritesManager.saveFavoriteBook(BookDetailsData(id: "1",
                                                          volumeInfo: VolumeData(title: "Book 1",
                                                                                 authors: ["Author 1"],
                                                                                 description: "Description 1",
                                                                                 imageLinks: nil)))

        // Act
        viewModel = DetailBookViewModel(volumeData: BookDetailsData(id: "1",
                                                                    volumeInfo: VolumeData(title: "Book 1",
                                                                                           authors: ["Author 1"],
                                                                                           description: "Description 1",
                                                                                           imageLinks: nil)))

        // Assert
        XCTAssertTrue(viewModel.isFavorite, "isFavorite should be true when book is in favorites")
    }

    func testIsFavorite_ToggleFavoriteStatus() {
        // Arrange
        let initialFavoriteStatus = viewModel.isFavorite

        // Act
        viewModel.isFavorite.toggle()

        // Assert
        XCTAssertNotEqual(initialFavoriteStatus, viewModel.isFavorite, "isFavorite status should toggle")
    }
}
