//
//  ShareManager.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 22.06.2022.
//

import Foundation
import UIKit
import MessageUI

class ShareManager {
	
	static let shared: ShareManager = {
		let instance = ShareManager()
		return instance
	}()
	
	private var fileManager = CFileManager()
	
	public func share(factString: String?, image: UIImage?, completion: @escaping (() -> Void)) {

		var shareItems: [ShareItem] = []
		
		if let factString = factString {
			let item = ShareItem(share: factString)
			shareItems.append(item)
		}
		
		if let image = image {
			let item = ShareItem(share: image)
			shareItems.append(item)
		}
	
		let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: [])
		activityViewController.completionWithItemsHandler = { (_, _, _, _) -> Void in
			completion()
		}
		
		if !MFMailComposeViewController.canSendMail() {
			activityViewController.excludedActivityTypes = [UIActivity.ActivityType.mail]
		}
		
		DispatchQueue.main.async {
			if let topController = Utils.topMostViewController() {
				topController.present(activityViewController, animated: true, completion: nil)
			}
		}
	}
}

class ShareItem: NSObject, UIActivityItemSource {
	
	let share: Any
	
	init(share: Any) {
		self.share = share
	}
	
	func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
		return share
	}
	
	func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
		return share
	}
}
