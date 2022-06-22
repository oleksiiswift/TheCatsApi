//
//  ErrorHandler.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 20.06.2022.
//

import Foundation

struct ErrorHandler {
	
	enum DecodeError: Error {
		case decodingError
	}
	
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
	
	public static func handleError(of errorForKey: Error, description: String = "") {
		
		switch errorForKey {
			case DecodeError.decodingError:
				AlertManager.showAlert(of: .decodingError, optionalDescription: description)
			case NetworkingError.badServerResponse:
				AlertManager.showAlert(of: .badServerResponse)
			case NetworkingError.badRequestUrl:
				AlertManager.showAlert(of: .badRequestUrl)
			case NetworkingError.unsupportedURL:
				AlertManager.showAlert(of: .unsupportedURL)
			default:
				return
		}
	}
}
