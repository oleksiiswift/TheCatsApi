//
//  AlertDescription.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 21.06.2022.
//

import Foundation

struct AlertDescription {
	var title: String
	var description: String
	var action: String
	var cancel: String
	
	init(title: String, description: String, action: String, cancel: String) {
		self.title = title
		self.description = description
		self.action = action
		self.cancel = cancel
	}
}


