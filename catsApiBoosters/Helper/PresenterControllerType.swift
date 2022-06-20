//
//  PresenterControllerType.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 21.06.2022.
//

import UIKit

enum PresentedControllerType {
	
	case loader

	var storyboardName: String {
		switch self {
			case .loader:
				return Constants.Identifiers.Stroryboards.loader
		}
	}
	
	var viewControllerIdentifier: String {
		switch self {
			case .loader:
				return Constants.Identifiers.ViewControllers.loader
		}
	}
		
	var presentController: UIViewController {
		switch self {
			case .loader:
				return getPresentedViewController(type: .loader)
		}
	}
	
	private func getPresentedViewController(type: PresentedControllerType) -> UIViewController {
		
		let storyboard = UIStoryboard(name: type.storyboardName, bundle: nil)
		switch self {
			case .loader:
				return storyboard.instantiateViewController(withIdentifier: type.viewControllerIdentifier) as! LoaderViewController
		}
	}
}
