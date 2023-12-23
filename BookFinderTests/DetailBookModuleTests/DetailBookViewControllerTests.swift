//
//  DetailBookViewControllerTests.swift
//  BookFinderTests
//
//  Created by Geisel Roque on 22/12/23.
//

import XCTest
@testable import BookFinder

class DetailBookViewControllerTests: XCTestCase {

    var viewController: DetailBookViewController!
    var mockViewModel: MockDetailBookViewModel!

    override func setUp() {
        super.setUp()
        mockViewModel = MockDetailBookViewModel(bookData: BookDetailsData(id: "1",
                                                                          volumeInfo: VolumeData(title: "Book 1",
                                                                                                 authors: ["Author 1"],
                                                                                                 description: "Description 1",
                                                                                                 imageLinks: nil)))
        
        viewController = DetailBookViewController(viewModel: mockViewModel)
        viewController.loadViewIfNeeded()
    }

    override func tearDown() {
        viewController = nil
        mockViewModel = nil
        super.tearDown()
    }

    func testViewDidLoad_SetsUpUIElements() {
        // Assert
        XCTAssertNotNil(viewController.bookImageView, "Book image view should not be nil")
        XCTAssertNotNil(viewController.titleLabel, "Title label should not be nil")
        XCTAssertNotNil(viewController.authorLabel, "Author label should not be nil")
        XCTAssertNotNil(viewController.descriptionLabel, "Description label should not be nil")
    }

    func testToggleFavorite() {
        // Arrange
        let initialFavoriteStatus = mockViewModel.isFavorite

        // Act
        viewController.toggleFavorite()

        // Assert
        XCTAssertNotEqual(initialFavoriteStatus, mockViewModel.isFavorite, "Favorite status should change after toggling")
    }

    func testGetImage_WithValidURL_SetsBookImageView() {
        // Arrange
        let expectation = self.expectation(description: "Image fetched")

        // Act
        viewController.getImage()

        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertNotNil(self.viewController.bookImageView.image, "Book image should be set after fetching from a valid URL")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetImage_WithInvalidURL_SetsNoCoverImage() {
        // Arrange
        let invalidURLViewModel = MockDetailBookViewModel(bookData:  BookDetailsData(id: "1",
                                                                                     volumeInfo: VolumeData(title: "Book 1",
                                                                                                            authors: ["Author 1"],
                                                                                                            description: "Description 1",
                                                                                                            imageLinks: BookImageModel(smallThumbnail: nil,
                                                                                                                                       thumbnail: "invalidURL"))))
        viewController = DetailBookViewController(viewModel: invalidURLViewModel)
        viewController.loadViewIfNeeded()

        // Act
        viewController.getImage()

        // Assert
        XCTAssertNil(viewController.bookImageView.image, "Book image should be set to no cover image for an invalid URL")
    }
}
