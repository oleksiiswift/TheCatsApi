//
//  ImagePreviewViewController.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 22.06.2022.
//

import UIKit

class ImagePreviewViewController: UIViewController {
	
	private let imageView = UIImageView()

	override func loadView() {
		view = imageView
	}

	init(item: UIImage) {
		super.init(nibName: nil, bundle: nil)
		
		imageView.rounded()
		imageView.clipsToBounds = true
		imageView.contentMode = .scaleAspectFill
		imageView.backgroundColor = .red
		imageView.image = item
		
		let size = Utils.screenWidth - 20
		preferredContentSize = CGSize(width: size, height: size)
		self.view.backgroundColor = .clear
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
