//
//  HomeViewModelTests.swift
//  BookFinderTests
//
//  Created by Geisel Roque on 22/12/23.
//

import XCTest
@testable import BookFinder

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModelProtocol!

    override func setUp() {
        super.setUp()
        let mockGoogleBooksAPI = MockGoogleBooksAPI()
        viewModel = HomeViewModel(googleBooksAPI: mockGoogleBooksAPI)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testGetInfoBooks() {
        // Arrange
        let expectation = expectation(description: "Get books expectation")

        // Act
        viewModel.getInfoBooks(query: "Harry Potter")

        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(self.viewModel.books.count > 0, "Books were fetched")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3, handler: nil)
    }

    func testViewModelBooksCount() {
        // Arrange
        let mockGoogleBooksAPI = MockGoogleBooksAPI()
        let viewModel = HomeViewModel(googleBooksAPI: mockGoogleBooksAPI)

        // Act
        viewModel.getInfoBooks(query: "Swift Programming")

        // Assert
        XCTAssertEqual(viewModel.books.count, 2, "ViewModel should contain fetched books")
    }

    func testViewModelDelegate() {
        // Arrange
        let expectation = expectation(description: "ViewModel delegate expectation")
        let mockViewModel = MockHomeViewModel()
        let viewController = HomeViewController(viewModel: mockViewModel)
        viewController.loadViewIfNeeded()

        // Act
        mockViewModel.delegate = viewController
        mockViewModel.getInfoBooks(query: "Harry Potter")

        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(viewController.viewModel.books.count, 2, "Books were loaded in view model")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3, handler: nil)
    }
}
