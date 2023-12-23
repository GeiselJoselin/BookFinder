//
//  DetailBookViewModel.swift
//  BookFinder
//
//  Created by Geisel Roque on 22/12/23.
//

import Foundation

protocol DetailBookViewModelProtocol {
    var bookData: BookDetailsData { get }
    var isFavorite: Bool { get set }
}


class DetailBookViewModel: DetailBookViewModelProtocol {
    
    let bookData: BookDetailsData
    var isFavorite: Bool
    
    init(volumeData: BookDetailsData) {
        self.bookData = volumeData
        let isFavorite = FavoritesManager.isBookFavorite(bookId: volumeData.id)
        self.isFavorite = isFavorite
    }
}
