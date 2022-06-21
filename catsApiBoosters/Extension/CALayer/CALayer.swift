//
//  CALayer.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 21.06.2022.
//

import UIKit

extension CALayer {
	
	func setShadowAndCustomCorners(backgroundColor: UIColor = .black, shadow: UIColor = .black, alpha: Float = 0.5, x: CGFloat = 0, y: CGFloat = 2, blur: CGFloat, corners: UIRectCorner, radius: CGFloat = 12) {
	
		let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
		let layerMask = CAShapeLayer()
		layerMask.frame = self.bounds
		layerMask.path = path.cgPath
		layerMask.fillColor = backgroundColor.cgColor
		layerMask.name = "corners"
		masksToBounds = false
		shadowColor = shadow.cgColor
		shadowOpacity = alpha
		shadowOffset = CGSize(width: x, height: y)
		shadowRadius = blur / 2.0
		shadowPath = path.cgPath
		self.addSublayer(layerMask)
	}
}
