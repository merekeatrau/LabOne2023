//
//  SceneDelegate.swift
//  SettingsVIP
//
//  Created by Mereke on 08.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let settingsVC = SettingsViewController()
        let navController = UINavigationController(rootViewController: settingsVC)
        settingsVC.title = "Settings"
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}

