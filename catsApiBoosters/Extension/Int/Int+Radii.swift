//
//  Int+Radii.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 21.06.2022.
//

import UIKit

extension Int {
	
	var radii : CGFloat {
		return CGFloat(self) * .pi / 180
	}
}
