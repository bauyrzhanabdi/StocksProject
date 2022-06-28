//
//  FavoritesService.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 01.06.2022.
//

import Foundation

protocol FavoritesServiceProtocol {
    func save(stock : Stock)
    func remove(stock : Stock)
    func isFavorite(for id : String) -> Bool
    func favoriteStocks() -> [Stock]
}

final class FavoritesService : FavoritesServiceProtocol {
    private lazy var path : URL = {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent("Favorites")
    }()
    
    private lazy var favorites : [Stock] = {
        do {
            let data = try Data(contentsOf: path)
            return try JSONDecoder().decode([Stock].self, from: data)
        } catch {
            print("FileManager ReadError - ", error.localizedDescription)
        }
        
        return []
    }()
    
    func save(stock: Stock) {
        favorites.append(stock)
        updateRepo(with: stock.id)
    }
    
    func remove(stock: Stock) {
        if let index = favorites.firstIndex(where: {$0.id == stock.id}) {
            favorites.remove(at: index)
            updateRepo(with: stock.id)
        }
    }
    
    func isFavorite(for id: String) -> Bool {
        favorites.contains(where: {$0.id == id})
    }
    
    func favoriteStocks() -> [Stock] {
        return favorites
    }
    
    private func updateRepo(with id : String) {
        do {
            let data = try JSONEncoder().encode(favorites)
            try data.write(to: path)
            NotificationCenter.default.post(name: NSNotification.Name.favoriteNotification, object: nil, userInfo: ["id" : id])
        } catch {
            print("FileManager WriteError - ", error.localizedDescription)
        }
    }
    
    
}
