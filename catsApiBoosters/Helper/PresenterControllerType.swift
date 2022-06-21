//
//  PresenterControllerType.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 21.06.2022.
//

import UIKit

enum PresentedControllerType {
	
	case loader
	case advertisement
	
	var storyboardName: String {
		switch self {
			case .loader:
				return Constants.Identifiers.Stroryboards.loader
			case .advertisement:
				return Constants.Identifiers.Stroryboards.loader
		}
	}
	
	var viewControllerIdentifier: String {
		switch self {
			case .loader:
				return Constants.Identifiers.ViewControllers.loader
			case .advertisement:
				return Constants.Identifiers.ViewControllers.advertisement
		}
	}
		
	var presentController: UIViewController {
				return getPresentedViewController(type: self)
	}
	
	private func getPresentedViewController(type: PresentedControllerType) -> UIViewController {
		
		let storyboard = UIStoryboard(name: type.storyboardName, bundle: nil)
		switch self {
			case .loader:
				return storyboard.instantiateViewController(withIdentifier: type.viewControllerIdentifier) as! LoaderViewController
			case .advertisement:
				return storyboard.instantiateViewController(withIdentifier: type.viewControllerIdentifier) as! AdvertisementViewController
		}
	}
}
