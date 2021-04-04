//
//  UserDefaultsManager.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 03.04.2021.
//

import Foundation

class UserDefaultsManager {
    private static let instance = UserDefaultsManager()
    private let favsKey = "Favourites"

    class func sharedInstance() -> UserDefaultsManager {
        return instance
    }

    private func getFavouritesArray() -> [String] {
        guard
            let favouritesAsAny = UserDefaults.standard.value(forKey: favsKey),
            let favourites = favouritesAsAny as? [String]
        else {
            return [String]()
        }
        return favourites
    }

    func addToFavourites(ticker: String) {
        var favourites = getFavouritesArray()
        if !favourites.contains(ticker) {
            favourites.append(ticker)
        }
        UserDefaults.standard.setValue(favourites, forKey: favsKey)
    }

    func removeFromFavourites(ticker: String) {
        var favourites = getFavouritesArray()
        favourites = favourites.filter {$0 != ticker}
        UserDefaults.standard.setValue(favourites, forKey: favsKey)
    }

    func checkIfFavouritesContain(ticker: String) -> Bool {
        let favourites = getFavouritesArray()
        return favourites.contains(ticker)
    }
}
