//
//  ButtonType.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 21.06.2022.
//

import Foundation

enum ButtonType {
	case cancel
	case ok
	case add
	case skip
	case share
	
	var rawValue: String {
		switch self {
			case .cancel:
				return "Cancel"
			case .ok:
				return "OK"
			case .add:
				return "Show Ad"
			case .skip:
				return "Skip"
			case .share:
				return "Share"
		}
	}
}

struct Buttons {
	
	static func getButtonTitle(of buttonType: ButtonType) -> String {
		return buttonType.rawValue
	}
}
