//
//  ErrorHandler.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 20.06.2022.
//

import Foundation

struct ErrorHandler {
	
	enum NetworkingError: Error {
		case badRequestUrl
		case badServerResponse
		case unsupportedURL
	}
	
	enum ImageLoadError: Error {
		case urlError
		case chacheIDError
		case error
	}
}

extension ErrorHandler {
	
	
	public static func handleError(of errorForKey: Error) {
		
		debugPrint(errorForKey)
	}
}
