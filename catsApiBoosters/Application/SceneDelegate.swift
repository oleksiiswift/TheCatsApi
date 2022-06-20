//
//  SceneDelegate.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 20.06.2022.
//

import UIKit

var currentScene: UIScene?

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	var loaderWindwow: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		
		guard let scene = (scene as? UIWindowScene) else { return }
		currentScene = scene
		self.handleStartupRouting()
	}

	func sceneDidDisconnect(_ scene: UIScene) {}

	func sceneDidBecomeActive(_ scene: UIScene) {}

	func sceneWillResignActive(_ scene: UIScene) {}

	func sceneWillEnterForeground(_ scene: UIScene) {}

	func sceneDidEnterBackground(_ scene: UIScene) {}
}

extension SceneDelegate {
	
	private func handleStartupRouting() {
		
		UIPresenter.showViewController(of: .loader)
	}
}
