//
//  HomeViewControllerTests.swift
//  BookFinderTests
//
//  Created by Geisel Roque on 22/12/23.
//

import XCTest
@testable import BookFinder

class HomeViewControllerTests: XCTestCase {

    var viewController: HomeViewController!

    override func setUp() {
        super.setUp()
        let mockViewModel = MockHomeViewModel()
        viewController = HomeViewController(viewModel: mockViewModel)
        viewController.loadViewIfNeeded()
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    func testTableView() {
        // Arrange
        let tableView = viewController.tableView

        // Act
        let numberOfRows = viewController.tableView(tableView, numberOfRowsInSection: 0)

        // Assert
        XCTAssertEqual(numberOfRows, 0, "Initially, no rows in table view")
    }

    func testNoResultsViewHidden() {
        // Arrange
        viewController.loadViewIfNeeded()

        // Act & Assert
        XCTAssertTrue(viewController.noResultsImageView.isHidden, "No results view should be initially hidden")
    }
}
