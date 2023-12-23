//
//  MockGoogleBooksAPI.swift
//  BookFinderTests
//
//  Created by Geisel Roque on 22/12/23.
//

import Foundation
@testable import BookFinder

class MockGoogleBooksAPI: GoogleBooksAPIProtocol {
    func searchBooks(query: String, completion: @escaping (Result<[BookDetailsData], Error>) -> Void) {
        let books: [BookDetailsData] = [
            BookDetailsData(id: "1",
                            volumeInfo: VolumeData(title: "Book 1",
                                                   authors: ["Author 1"],
                                                   description: "Description 1", imageLinks: nil)),
            BookDetailsData(id: "2",
                            volumeInfo: VolumeData(title: "Book 2",
                                                   authors: ["Author 2"],
                                                   description: "Description 2", imageLinks: nil))
        ]
        completion(.success(books))
    }
}
