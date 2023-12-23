//
//  HomeViewModel.swift
//  BookFinder
//
//  Created by Geisel Roque on 22/12/23.
//

import Foundation

protocol HomeViewModelProtocol {
    var books: [BookDetailsData] { get set }
    var delegate: HomeViewModelDelegate? { get set }
    func getInfoBooks(query: String)
}

protocol HomeViewModelDelegate: AnyObject {
    func didLoadData()
}

final class HomeViewModel: HomeViewModelProtocol {

    private let googleBooksAPI: GoogleBooksAPI
    weak var delegate: HomeViewModelDelegate?
    var books: [BookDetailsData] = []

    init(googleBooksAPI: GoogleBooksAPI) {
        self.googleBooksAPI = googleBooksAPI
    }
    
    func getInfoBooks(query: String) {
        googleBooksAPI.searchBooks(query: query) { [weak self] result in
            print("El resultado es: ", result)
            guard let self else { return }
            switch result {
                case .success(let books):
                    self.books = books
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
            }
            self.delegate?.didLoadData()
        }
    }
}
