//
//  UIFont+MonoSpace.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 21.06.2022.
//

import UIKit

extension UIFont {
	public func withMonospacedNumbers() -> Self {
		let monospacedFeature: [UIFontDescriptor.FeatureKey: Any]
		
			monospacedFeature = [
				.type: kNumberSpacingType,
				.selector: kMonospacedNumbersSelector
			]
		
		let descriptor = fontDescriptor.addingAttributes([
			.featureSettings: [monospacedFeature]
		])

		return Self(descriptor: descriptor, size: 0)
	}
}
