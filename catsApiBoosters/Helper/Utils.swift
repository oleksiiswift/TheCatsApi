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
}

extension Utils {
	
	public static func topMostViewController() -> UIViewController? {
		guard let rootController = keyWindow()?.rootViewController else { return nil }
		return topMostViewController(for: rootController)
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
