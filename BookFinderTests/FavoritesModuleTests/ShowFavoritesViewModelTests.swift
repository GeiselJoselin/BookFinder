//
//  ShowFavoritesViewModelTests.swift
//  BookFinderTests
//
//  Created by Geisel Roque on 22/12/23.
//

import XCTest
@testable import BookFinder

class ShowFavoritesViewModelTests: XCTestCase {

    var viewModel: ShowFavoritesViewModelProtocol!

    override func setUp() {
        super.setUp()
        let mockBooks: [BookDetailsData] = [
            BookDetailsData(id: "6",
                                            volumeInfo: VolumeData(title: "Book 6",
                                                                   authors: ["Author 6"],
                                                                   description: "Description 6", imageLinks: nil)),
            BookDetailsData(id: "7",
                                            volumeInfo: VolumeData(title: "Book 7",
                                                                   authors: ["Author 7"],
                                                                   description: "Description 7", imageLinks: nil))
        ]
        viewModel = ShowFavoritesViewModel(books: mockBooks)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testViewModelBooksCount() {
        // Assert
        XCTAssertEqual(viewModel.books.count, 2, "ViewModel should contain correct number of books")
    }

    func testViewModelBookAtIndex() {
        // Arrange
        let indexToCheck = 0
        let expectedBookTitle = "Book 6"

        // Act
        let book = viewModel.books[indexToCheck]

        // Assert
        XCTAssertEqual(book.volumeInfo.title, expectedBookTitle, "Book at specified index should have correct title")
    }

    func testViewModelAddBook() {
        // Arrange
        let initialCount = viewModel.books.count
        let newBook = BookDetailsData(id: "8",
                                      volumeInfo: VolumeData(title: "Book 8",
                                                             authors: ["Author 8"],
                                                             description: "Description 8", imageLinks: nil))

        // Act
        viewModel.books.append(newBook)

        // Assert
        XCTAssertEqual(viewModel.books.count, initialCount + 1, "Adding a book should increase the count")
        XCTAssertTrue(viewModel.books.contains(where: { $0.id == "8" }), "Newly added book should exist in the array")
    }

    func testViewModelRemoveBook() {
        // Arrange
        let initialCount = viewModel.books.count
        let bookToRemove = viewModel.books.first

        // Act
        if let book = bookToRemove {
            viewModel.books.removeAll(where: { $0.id == book.id })
        }

        // Assert
        XCTAssertEqual(viewModel.books.count, initialCount - 1, "Removing a book should decrease the count")
        XCTAssertFalse(viewModel.books.contains(where: { $0.id == bookToRemove?.id }), "Removed book should not exist in the array")
    }
}
