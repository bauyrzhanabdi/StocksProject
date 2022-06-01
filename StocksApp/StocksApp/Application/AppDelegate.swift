//
//  AppDelegate.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 25.05.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = TabBarViewController()
        window?.rootViewController = ModuleBuilder.shared.tabBarController()
        window?.makeKeyAndVisible()
        return true
    }
}

