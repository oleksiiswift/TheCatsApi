//
//  Utils.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 21.06.2022.
//

import Foundation
import UIKit

class Utils {
	
	static let application: UIApplication = .shared
	
	static let appDelegate: AppDelegate = application.delegate as! AppDelegate
	
	static let scene = UIApplication.shared.connectedScenes.first
	
	static let sceneDelegate: SceneDelegate = scene!.delegate as! SceneDelegate
	
	static let windowScene = UIApplication.shared.connectedScenes
		.filter { $0.activationState == .foregroundActive }
		.compactMap { $0 as? UIWindowScene }
	
	static func keyWindow() -> UIWindow? {
		return UIApplication.shared.connectedScenes
			.filter {$0.activationState == .foregroundActive}
			.compactMap {$0 as? UIWindowScene}
			.first?.windows.filter {$0.isKeyWindow}.first
	}
	
	static func loading() -> UIWindow? {
		return UIApplication.shared.connectedScenes
			.filter {$0.activationState == .foregroundActive}
			.compactMap {$0 as? UIWindowScene}
			.first?.windows.filter {$0.tag == 634}.first
	}
	
	static let mainScreen: UIScreen = .main
	
	static let screenBounds: CGRect = mainScreen.bounds
	
	static let screenHeight: CGFloat = screenBounds.height
	
	static let screenWidth: CGFloat = screenBounds.width
	
	static public var bottomSafeAreaHeight: CGFloat {
		return windowScene.first?.keyWindow?.safeAreaInsets.bottom ?? 0
	}
}

extension Utils {
	
	public static func topMostViewController() -> UIViewController? {
		if let loadingController = loading()?.rootViewController {
			return topMostViewController(for: loadingController)
		} else if let rootController = keyWindow()?.rootViewController {
			return topMostViewController(for: rootController)
		} else { return nil }
	}
	
	private static func topMostViewController(for controller: UIViewController) -> UIViewController {
		if let presentedController = controller.presentedViewController {
			return topMostViewController(for: presentedController)
		} else if let navigationController = controller as? UINavigationController {
			guard let topController = navigationController.topViewController else {
				return navigationController
			}
			return topMostViewController(for: topController)
		}
		return controller
	}
}
