//
//  DataModelLoader.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 20.06.2022.
//

import Foundation

class DataModelLoader {
	
	static let shared: DataModelLoader = {
		let instance = DataModelLoader()
		return instance
	}()
	
	private func loadData(from url: URL?) async throws -> Data {
		
		guard let url = url else { throw ErrorHandler.NetworkingError.badRequestUrl}
		let urlSession = URLSession.shared
		let (data, response) = try await urlSession.data(from: url)
		guard let httpResponse = response as? HTTPURLResponse, (200..<400).contains(httpResponse.statusCode) else { throw ErrorHandler.NetworkingError.badServerResponse}
		return data
	}
	
	
	@MainActor public func getAnimalsCategories() async -> [AnimalCategoryModel] {
		
		let apiUrl = URL(string: Constants.Links.apiLink)
		let decoder = JSONDecoder()
		
		do {
			let data = try await self.loadData(from: apiUrl)
			let animals = try decoder.decode([AnimalCategoryModel].self, from: data)
			return animals
		} catch {
			ErrorHandler.handleError(of: error, description: error.localizedDescription)
		}
		return []
	}
}


