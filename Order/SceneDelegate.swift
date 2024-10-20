//
//  SceneDelegate.swift
//  Order
//
//  Created by Максим Герасимов on 18.10.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let someDateTime = formatter.date(from: "2025/10/08")
        
        
               // Инициализация ViewModel с тестовыми данными
               let testOrder = Order(
                   screenTitle: "Оформление заказа",
                   promocodes: [
                       Order.Promocode(title: "HELLO35334534535354535345354апвпвапапвапапаваВАППВАПВПВПВПВАПВАПВПВПВАПВПАВПАВппавпвd", percent: 5, endDate: someDateTime, info: "Первый заказ", active: false),
                       Order.Promocode(title: "SPRING2мсмссмвавававerttretertet43", percent: 10, endDate: nil, info: "Весенняя акция", active: false),
                       Order.Promocode(title: "SPRING2мсмссмвавававerttretertet", percent: 11, endDate: nil, info: "Весенняя акция", active: false),
                       Order.Promocode(title: "SPRING3", percent: 12, endDate: nil, info: "Весенняя акция", active: false),
                       Order.Promocode(title: "SPRINg4", percent: 14, endDate: nil, info: "Весенняя акция", active: false),
                       Order.Promocode(title: "SPRING5", percent: 16, endDate: nil, info: "Весенняя акция", active: false),
                       Order.Promocode(title: "SPRING6", percent: 1, endDate: nil, info: "Весенняя акция", active: false)
                       
                   ],
                   products: [
                       Order.Product(price: 10000, title: "Продукт 1"),
                       Order.Product(price: 15000, title: "Продукт 2")
                   ],
                   paymentDiscount: 0,
                   baseDiscount: 0
               )

               let viewModel = OrderViewModel(order: testOrder)

               // Инициализация контроллера с ViewModel
               let orderViewController = OrderViewController()
               orderViewController.viewModel = viewModel

               // Инициализация окна
               window = UIWindow(windowScene: windowScene)
               window?.rootViewController = UINavigationController(rootViewController: orderViewController) // Если нужен UINavigationController
               window?.makeKeyAndVisible()
           }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

