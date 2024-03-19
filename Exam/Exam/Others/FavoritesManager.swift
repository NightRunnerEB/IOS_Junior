//
//  UserDefaultsManager.swift
//  Exam
//
//  Created by Евгений Бухарев on 19.03.2024.
//

import Foundation
import UIKit


class FavoritesManager {
    static let shared = FavoritesManager()
    
    private init() { }
    
    private let favoritesKey = "favorites"
    
    // Сохранение массива избранных URL в UserDefaults
    func saveFavorites(_ urls: [String]) {
        UserDefaults.standard.set(urls, forKey: favoritesKey)
    }
    
    // Получение массива избранных URL из UserDefaults
    func getFavorites() -> [String] {
        return UserDefaults.standard.array(forKey: favoritesKey) as? [String] ?? []
    }
}
