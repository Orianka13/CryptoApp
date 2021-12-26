//
//  SceneDelegate.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private enum Colors {
        static let mainColor = UIColor(red: 103/255, green: 222/255, blue: 165/255, alpha: 1)
    }
    
    private enum Fonts {
        static let titleFont = UIFont(name: "HiraginoSans-W3", size: 18)
    }
    

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        self.window?.windowScene = windowScene
        
        
        let vc = AuthAssembly.build()
        let navVC = UINavigationController(rootViewController: vc)
        
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.mainColor,
                                                   NSAttributedString.Key.font: Fonts.titleFont ?? .systemFont(ofSize: 20)]
        navVC.navigationBar.barTintColor = .black
        
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        let coreDS = CoreDataStack()
        coreDS.saveContext()
    }
}

