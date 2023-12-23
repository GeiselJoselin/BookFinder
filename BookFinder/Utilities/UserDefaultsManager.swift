//
//  UserDefaultsManager.swift
//  BookFinder
//
//  Created by Geisel Roque on 22/12/23.
//

import Foundation

struct FavoritesManager {
    static let favoritesBooksKey = "FavoriteBooks"

    static func isBookFavorite(bookId: String) -> Bool {
        let favoriteBooks = getFavoriteBooks()
        return favoriteBooks.contains { $0.id == bookId }
    }

    static func getFavoriteBooks() -> [BookDetailsData] {
        if let data = UserDefaults.standard.data(forKey: favoritesBooksKey),
           let favoriteBooks = try? JSONDecoder().decode([BookDetailsData].self, from: data) {
            return favoriteBooks
        }
        return []
    }

    static func saveFavoriteBook(_ book: BookDetailsData) {
        var favoriteBooks = getFavoriteBooks()

        if let index = favoriteBooks.firstIndex(where: { $0.id == book.id }) {
            favoriteBooks.remove(at: index)
        } else {
            favoriteBooks.append(book)
        }
        
        if let encodedData = try? JSONEncoder().encode(favoriteBooks) {
            UserDefaults.standard.set(encodedData, forKey: favoritesBooksKey)
        }
    }
}
