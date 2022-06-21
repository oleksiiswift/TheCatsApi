//
//  LoaderViewController.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 21.06.2022.
//

import UIKit

class LoaderViewController: UIViewController {
	
    override func viewDidLoad() {
        super.viewDidLoad()

		setupUI()
		blurSetup()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		showIndicator()
	}
}

extension LoaderViewController {
	
	private func showIndicator() {
		
		UIPresenter.showBluredActivityIndicator(in: self.view)
	}
}

extension LoaderViewController {
	
	private func setupUI() {
		
		self.view.backgroundColor = .clear
	}
	
	private func blurSetup() {
		
		let blurContainerView = UIView()
		let blurEffect = UIBlurEffect(style: .light)
		let visualEffectView = VisualEffectBlurView(effect: blurEffect, intencity: 1.0)
		visualEffectView.frame = self.view.bounds
		let dimmerView = UIView()
		dimmerView.backgroundColor = .black.withAlphaComponent(0.4)
		dimmerView.frame = self.view.bounds
		blurContainerView.addSubview(visualEffectView)
		blurContainerView.addSubview(dimmerView)
		self.view.addSubview(blurContainerView)
		self.view.sendSubviewToBack(blurContainerView)
	}
}

