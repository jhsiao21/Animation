//
//  AppDelegate.swift
//  CoreAnimationIntro
//
//  Created by LoganMacMini on 2023-12-28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        let navigationController = UINavigationController(rootViewController: TableViewController())
        window?.rootViewController = navigationController
//        window?.rootViewController = CirclingViewController()
        return true
    }

}

