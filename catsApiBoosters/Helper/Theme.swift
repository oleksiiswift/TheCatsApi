//
//  Theme.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 21.06.2022.
//

import UIKit

struct Theme {

	static var cellBackGroundColor: UIColor {
		return UIColor().colorFromHexString("ECF0F6")
	}
	
	static var topShadowColor: UIColor {
		return UIColor().colorFromHexString("FFFFFF")
	}
	
	static var sideShadowColor: UIColor {
		return UIColor().colorFromHexString("C2C8D3")
	}
	
	static var titleTextColor: UIColor {
		return UIColor().colorFromHexString("374058")
	}
	
	static var subTitleTextColor: UIColor {
		return UIColor().colorFromHexString("374058").withAlphaComponent(0.5)
	}
	
	static var containerBackgroundColor: UIColor {
		return UIColor().colorFromHexString("EDEDED")
	}
	
	static var premiumButtonLinkColor: UIColor {
		return UIColor().colorFromHexString("2D539F")
	}
	
	static var progressCircleBackgroundColor: UIColor {
		return UIColor().colorFromHexString("DDDFE4")
	}
	
	static var progressCircleColor: UIColor {
		return UIColor().colorFromHexString("51AED6")
	}
	
	static var clearColor: UIColor {
		return .clear
	}
}

