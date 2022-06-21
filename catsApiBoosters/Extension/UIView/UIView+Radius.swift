//
//  UIView+Radius.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 21.06.2022.
//

import UIKit

extension UIView {
	
	func setCorner(_ radius: CGFloat) {
		self.layer.cornerRadius = radius
		self.clipsToBounds = true
	}
	
	func rounded() {
		layer.cornerRadius = frame.height / 2
		layer.masksToBounds = true
	}
}
