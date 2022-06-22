//
//  VisualEffectBlurView.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 21.06.2022.
//

import UIKit

class VisualEffectBlurView: UIVisualEffectView {
	
	private var visualEffect: UIVisualEffect
	private var intensity: CGFloat
	private var animator: UIViewPropertyAnimator?
	
	init(effect: UIVisualEffect, intencity: CGFloat) {
		self.visualEffect = effect
		self.intensity = intencity
		super.init(effect: nil)
	}
	
	required init?(coder: NSCoder) { nil }
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		effect = nil
		animator?.stopAnimation(true)
		animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [unowned self] in
			self.effect = visualEffect
		}
		animator?.fractionComplete = intensity
	}

	deinit {
		animator?.stopAnimation(true)
	}
}
