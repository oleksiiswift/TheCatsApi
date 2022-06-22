//
//  ActivityIndicatorView.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 21.06.2022.
//

import UIKit

class ActivityIndicatorView: NSObject {
	
	private static var activityIndicatorView = UIActivityIndicatorView()
	
	private static var activityIndicatorLoaded: Bool = false
		
	public static func setupIndicator(indicator style: UIActivityIndicatorView.Style, color: UIColor, size: CGSize, presented view: UIView) {
		
		guard !activityIndicatorLoaded else { return }
		
		activityIndicatorView.style = style
		activityIndicatorView.color = color
		activityIndicatorView.frame = CGRect(origin: .zero, size: size)
		activityIndicatorView.center = view.center
		view.addSubview(activityIndicatorView)
		view.bringSubviewToFront(activityIndicatorView)
		activityIndicatorView.startAnimating()
		activityIndicatorLoaded = !activityIndicatorLoaded
	}
	
	public static func removeIndicator() {
		
		activityIndicatorView.stopAnimating()
		activityIndicatorView.removeFromSuperview()
		activityIndicatorLoaded = false
	}
}
