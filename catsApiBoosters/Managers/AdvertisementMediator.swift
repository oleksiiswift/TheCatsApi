//
//  AdvertisementMediator.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 21.06.2022.
//

import Foundation

protocol AdvertisementListener {
	
	func advertisementDidCancel()
	func advertisementTryCancel()
	func advertisementDidShow()
}

class AdvertisementMediator {
	
	class var instance: AdvertisementMediator {
		struct Static {
			static let instance: AdvertisementMediator = AdvertisementMediator()
		}
		return Static.instance
	}
	
	private var listener: AdvertisementListener?
	private init() {}
	
	func setListener(listener: AdvertisementListener) {
		self.listener = listener
	}
	
	func advertisementDidCancel() {
		listener?.advertisementDidCancel()
	}
	
	func advertisementTryCancel() {
		listener?.advertisementTryCancel()
	}
	
	func advertisementDidShow() {
		listener?.advertisementDidShow()
	}
}
