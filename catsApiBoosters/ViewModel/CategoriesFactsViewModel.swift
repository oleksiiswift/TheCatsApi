//
//  CategoriesFactsViewModel.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 22.06.2022.
//

import Foundation


@MainActor class CategoriesFactsViewModel {
	
	public let categoryContent: [AnimalContentModel]
	
	init(categoryContent: [AnimalContentModel]) {
		self.categoryContent = categoryContent
	}
	
	public func numbersOrRowsAtSection() -> Int {
		return self.categoryContent.count
	}
	
	public func getCategory(at indexPath: IndexPath) -> AnimalContentModel {
		return self.categoryContent[indexPath.row]
	}
}
