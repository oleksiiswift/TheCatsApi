//
//  UIPresenter.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 21.06.2022.
//

import UIKit

class UIPresenter {
	
	public static func showViewController(of presentedType: PresentedControllerType, scenePresenter: Bool = true) {
		
		 guard let scene = currentScene as? UIWindowScene else { return }
		 
		 let viewController = presentedType.presentController
		 let navigationController = UINavigationController.init(rootViewController: viewController)
		
		 Utils.sceneDelegate.presenterWindow = UIWindow(windowScene: scene)
		 Utils.sceneDelegate.presenterWindow?.windowLevel = .statusBar - 1
		 Utils.sceneDelegate.presenterWindow?.rootViewController = navigationController
		 Utils.sceneDelegate.presenterWindow?.makeKeyAndVisible()
	}
	
	public static func closePresentedWindow(of type: PresentedControllerType) {
		
		type.presentController.dismiss(animated: true) {
			Utils.sceneDelegate.presenterWindow = nil
		}
	}
	
	public static func showBluredActivityIndicator(in view: UIView) {
		
		ActivityIndicatorView.setupIndicator(indicator: .large, color: .black.withAlphaComponent(0.6), size: CGSize(width: 40, height: 40), presented: view)
	}
	
	public static func hideIndicator() {
		
		ActivityIndicatorView.removeIndicator()
	}
}
