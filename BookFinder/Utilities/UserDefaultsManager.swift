//
//  UserDefaultsManager.swift
//  BookFinder
//
//  Created by Geisel Roque on 22/12/23.
//

import Foundation

struct FavoritesManager {
    static let favoritesKey = "FavoriteBooks"

    static func getFavoriteStatus(for bookId: String) -> Bool {
        let favorites = UserDefaults.standard.dictionary(forKey: favoritesKey) as? [String: Bool] ?? [:]
        return favorites[bookId] ?? false
    }

    static func setFavoriteStatus(_ isFavorite: Bool, for bookId: String) {
        var favorites = UserDefaults.standard.dictionary(forKey: favoritesKey) as? [String: Bool] ?? [:]
        favorites[bookId] = isFavorite
        UserDefaults.standard.setValue(favorites, forKey: favoritesKey)
    }
}
