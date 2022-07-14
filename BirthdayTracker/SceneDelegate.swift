//
//  SceneDelegate.swift
//  BirthdayTracker
//
//  Created by roman Khilchenko on 06.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        
        let viewController = ViewController()
        let navigationController = UINavigationController()
        let window = UIWindow(windowScene: windowScene)
        
        navigationController.viewControllers = [viewController]
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
    
}
