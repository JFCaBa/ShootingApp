//
//  SceneDelegate.swift
//  ShootingApp
//
//  Created by Jose on 26/10/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        
        window.rootViewController = navigationController
        self.window = window
        
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.start()
        
        window.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        
        Web3Service.shared.handleDeeplink(url)
        
        Task { @MainActor in
            NotificationCenter.default.post(
                name: NSNotification.Name("MetaMaskDidConnect"),
                object: nil
            )
        }
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
        SoundManager.shared.resumeAudioEngine()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        SoundManager.shared.pauseAudioEngine()
        
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

