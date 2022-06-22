//
//  CategoriesViewModel.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 20.06.2022.
//

import Foundation

@MainActor class CategoriesViewModel {
	
	public let categories: [AnimalCategoryModel]
	
	init(categories: [AnimalCategoryModel]) {
		self.categories = categories
	}
	
	public func numbersOrRowsAtSection() -> Int {
		return self.categories.count
	}
	
	public func getCategory(at indexPath: IndexPath) -> AnimalCategoryModel {
		return self.categories[indexPath.row]
	}
}
