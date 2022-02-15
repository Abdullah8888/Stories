//
//  AppDelegate.swift
//  Stories
//
//  Created by Abdullah on 10/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: StoriesViewController(view: StoriesView()))
        window?.makeKeyAndVisible()
        FirebaseService.shared.configure()
        return true
    }

}
