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
		}
	}
}

struct Buttons {
	
	static func getButtonTitle(of buttonType: ButtonType) -> String {
		return buttonType.rawValue
	}
}
