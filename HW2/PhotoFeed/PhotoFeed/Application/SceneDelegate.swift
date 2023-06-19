//
//  SceneDelegate.swift
//  PhotoFeed
//
//  Created by Mereke on 31.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

            guard let windowScene = (scene as? UIWindowScene) else { return }

            let tabBarController = UITabBarController()

            let homeVC = ViewController()
            homeVC.title = "Home"
            let homeNav = UINavigationController(rootViewController: homeVC)
            homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)

            let mediaVC = UIViewController()
            mediaVC.title = "Media"
            mediaVC.view.backgroundColor = .white
            let mediaNav = UINavigationController(rootViewController: mediaVC)
            mediaNav.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "square.grid.2x2.fill"), tag: 1)

            let profileVC = UIViewController()
            profileVC.title = "Profile"
            profileVC.view.backgroundColor = .white
            let profileNav = UINavigationController(rootViewController: profileVC)
            profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 2)

            tabBarController.viewControllers = [homeNav, mediaNav, profileNav]

            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
        }

}

