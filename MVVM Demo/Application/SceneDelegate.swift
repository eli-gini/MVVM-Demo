//
//  SceneDelegate.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
      
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let mainCoordinator = MainCoordinator(navigator: navigationController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        mainCoordinator.start()
        self.navigationController = navigationController
        self.window = window
    }
}

