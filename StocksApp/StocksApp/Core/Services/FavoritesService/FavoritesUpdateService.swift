//
//  FavoritesUpdateService.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 03.06.2022.
//

import Foundation

@objc protocol FavoritesUpdateServiceProtocol {
    func setFavorite(notification : Notification)
}

extension FavoritesUpdateServiceProtocol {
    func startObservingFavoriteNotifications() {
        NotificationCenter.default.addObserver(self, selector:
                                               #selector(setFavorite),
                                               name: NSNotification.Name.favoriteNotification,
                                               object: nil)
    }
}

extension NSNotification.Name {
    static let favoriteNotification = NSNotification.Name("set-favorite")
}

extension Notification {
    var stockID : String? {
        guard let userInfo = userInfo,
              let id = userInfo["id"] as? String
        else { return nil }
        
        return id
     }
}
