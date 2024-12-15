//
//  SceneDelegate.swift
//  Order
//
//  Created by Максим Герасимов on 18.10.2024.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        
        let mainView = MainView()  // Ваш экран SwiftUI
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: mainView)
            self.window = window
            window.makeKeyAndVisible()
            
            
        }
    }
}

