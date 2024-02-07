//
//  SceneDelegate.swift
//  ebukharev_1PW2
//
//  Created by Евгений Бухарев on 10.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let navC = UINavigationController(rootViewController: WishMakerViewController())
        window.rootViewController = navC
        self.window = window
        window.makeKeyAndVisible()
        
    }
}

