//
//  AppDelegate.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 20.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		self.prepareDateBase()
		self.initDataLoader()
	
		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

	}
}


extension AppDelegate {
	
	private func prepareDateBase() {
		
		PersistentManager.instance.removeAllObjects()
		CFileManager().clearDirectory(of: .cache)
		CFileManager().clearDirectory(of: .temp)
	}
	
	private func initDataLoader() {
		
		Task {
			let animalsData = await DataModelLoader.shared.getAnimalsCategories()
			
			if !animalsData.isEmpty {
				PersistentManager.instance.saveObjects(objects: animalsData) { saved in
					debugPrint("saved completed")
				}
			}
		}
	}
}
