//
//  ShowFavoritesViewControllerTests.swift
//  BookFinderTests
//
//  Created by Geisel Roque on 22/12/23.
//

import XCTest
@testable import BookFinder 

class ShowFavoritesViewControllerTests: XCTestCase {
    
    var viewController: ShowFavoritesViewController!
    var mockViewModel: MockShowFavoritesViewModel!

    override func setUp() {
        super.setUp()
        mockViewModel = MockShowFavoritesViewModel()
        viewController = ShowFavoritesViewController(viewModel: mockViewModel)
        viewController.loadViewIfNeeded()
    }

    override func tearDown() {
        viewController = nil
        mockViewModel = nil
        super.tearDown()
    }

    func testTableViewDataSource() {
        // Arrange & Act
        let tableView = viewController.tableView
        let numberOfRows = viewController.tableView(tableView, numberOfRowsInSection: 0)

        // Assert
        XCTAssertEqual(numberOfRows, mockViewModel.books.count, "Number of rows in table view should match data source count")
    }

    func testHasFavoritesBooks() {
        // Arrange
        let mockBook = BookDetailsData(id: "5",
                                        volumeInfo: VolumeData(title: "Book 5",
                                                               authors: ["Author 5"],
                                                               description: "Description 5", imageLinks: nil))
        mockViewModel.books = [mockBook]

        // Assert
        XCTAssertFalse(mockViewModel.books.isEmpty)
        XCTAssertEqual(mockViewModel.books.first?.id, mockBook.id)
    }

    func testNoFavoritesBooks() {
        // Arrange
        mockViewModel.books = []

        // Assert
        XCTAssertTrue(mockViewModel.books.isEmpty)
    }
}
