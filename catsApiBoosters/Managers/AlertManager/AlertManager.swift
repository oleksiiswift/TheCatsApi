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
	case decodingError
	case badRequestUrl
	case badServerResponse
	case unsupportedURL
	case contentIsEmpty
	case premiumIsNotAvailible
	
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
			case .decodingError:
				return .init(title: "Decoding Error",
							 description: "",
							 action: Buttons.getButtonTitle(of: .ok),
							 cancel: "")
			case .badRequestUrl:
				return .init(title: "Error!",
							 description: "Bad Bad Request Url",
							 action: Buttons.getButtonTitle(of: .ok),
							 cancel: "")
			case .badServerResponse:
				return .init(title: "Error!",
							 description: "Bad Server Error",
							 action: Buttons.getButtonTitle(of: .ok),
							 cancel: "")
			case .unsupportedURL:
				return .init(title: "Error!",
							 description: "Unsupported URL",
							 action: Buttons.getButtonTitle(of: .ok),
							 cancel: "")
			case .contentIsEmpty:
				return .init(title: "Error!",
							 description: "Content Is Empty",
							 action: Buttons.getButtonTitle(of: .ok),
							 cancel: "")
			case .premiumIsNotAvailible:
				return .init(title: "Warning",
							 description: "Life time premium is not availible",
							 action: Buttons.getButtonTitle(of: .ok),
							 cancel: "")
		}
	}
	
	var style: UIAlertController.Style {
		return .alert
	}
	
	var withCancel: Bool {
		switch self {
			case .showAdd, .cancelAdd:
				return true
			case .emptyContent, .decodingError:
				return false
			case .badRequestUrl, .badServerResponse, .unsupportedURL:
				return false
			case .contentIsEmpty, .premiumIsNotAvailible:
				return false
		}
	}
}

class AlertManager {
	
	static public func showAlert(of alertType: AlertType, optionalDescription: String = "", completionHandler: (() -> Void)? = nil) {
		
		let alertDescription = alertType.alertDescription
		let action = UIAlertAction(title: alertDescription.action, style: .default) { _ in
			completionHandler?()
		}
		
		let finalDescription = alertDescription.description.isEmpty ? optionalDescription.isEmpty ? "" : optionalDescription : alertDescription.description
		
		self.presentDefaultAlert(title: alertDescription.title, message: finalDescription, actions: [action], style: alertType.style, withCancel: alertType.withCancel)
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


