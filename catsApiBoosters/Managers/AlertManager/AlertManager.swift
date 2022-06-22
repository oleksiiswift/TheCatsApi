//
//  AlertManager.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 20.06.2022.
//

import Foundation
import UIKit

enum AlertType {
	
	case showAdd
	case emptyContent
	case cancelAdd
	
	var alertDescription: AlertDescription {
		switch self {
			case .showAdd:
				return .init(title: "Watch Ad to continue",
							 description: "By tapping \(ButtonType.add.rawValue) your agree to watch advertisement",
							 action: Buttons.getButtonTitle(of: .add),
							 cancel: Buttons.getButtonTitle(of: .cancel))
			case .emptyContent:
				return .init(title: "Coming Soon",
							 description: "Content will be availibe later!",
							 action: Buttons.getButtonTitle(of: .ok),
							 cancel: "")
			case .cancelAdd:
				return .init(title: "Cancel watch add",
							 description: "by skipping add, category will not recieve",
							 action: Buttons.getButtonTitle(of: .skip),
							 cancel: Buttons.getButtonTitle(of: .cancel))
		}
	}
	
	var style: UIAlertController.Style {
		return .alert
	}
	
	var withCancel: Bool {
		switch self {
			case .showAdd, .cancelAdd:
				return true
			case .emptyContent:
				return false
		}
	}
}

class AlertManager {
	
	static public func showAlert(of alertType: AlertType, completionHandler: (() -> Void)? = nil) {
		
		let description = alertType.alertDescription
		let action = UIAlertAction(title: description.action, style: .default) { _ in
			completionHandler?()
		}
		
		self.presentDefaultAlert(title: description.title, message: description.description, actions: [action], style: alertType.style, withCancel: alertType.withCancel)
	}
	
	private static func presentDefaultAlert(title: String, message: String, actions: [UIAlertAction], style: UIAlertController.Style, withCancel: Bool) {
		
		let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
		
		actions.forEach {
			alertController.addAction($0)
		}
		
		let cancelAction = UIAlertAction(title: Buttons.getButtonTitle(of: .cancel), style: .cancel)
		withCancel ?  alertController.addAction(cancelAction) : ()
		
		DispatchQueue.main.async {
			if let topController = Utils.topMostViewController() {
				topController.present(alertController, animated: true)
			}
		}
	}
}


