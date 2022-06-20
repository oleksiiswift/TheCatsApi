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
		
		 switch presentedType {
			 case .loader:
				 Utils.sceneDelegate.loaderWindwow = UIWindow(windowScene: scene)
				 Utils.sceneDelegate.loaderWindwow?.windowLevel = .statusBar - 1
				 Utils.sceneDelegate.loaderWindwow?.rootViewController = navigationController
				 Utils.sceneDelegate.loaderWindwow?.makeKeyAndVisible()
		 }
	}
	
	public static func closePresentedWindow(of type: PresentedControllerType) {
		
		type.presentController.dismiss(animated: true) {
			switch type {
				case .loader:
					Utils.sceneDelegate.loaderWindwow = nil
			}
		}
	}
}
