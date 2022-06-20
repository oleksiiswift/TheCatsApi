//
//  CategoriesDataSource.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 20.06.2022.
//

import Foundation
import UIKit

@MainActor class CategoriesDataSource: NSObject {
	
	public var categoriesViewModel: CategoriesViewModel
	public var handleSelectCategory: (([AnimalContentModel]) -> Void) = { _ in }

	init(categoryViewModel: CategoriesViewModel) {
		self.categoriesViewModel = categoryViewModel
	}
}

extension CategoriesDataSource {
	
	private func configure(cell: CategoryTableViewCell, at indexPath: IndexPath) {
		
		let model = self.categoriesViewModel.getCategory(at: indexPath)
		let id = model.imageChacheID
		if let url = model.imageURL {
			Task {
				let image = try? await ImageDownloadActor().getImage(from: URL(string: url), with: id)
				await MainActor.run {
					cell.configure(with: image)
				}
			}
		}
		cell.configureCell(with: model)
	}
}

extension CategoriesDataSource: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.categoriesViewModel.numbersOrRowsAtSection()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.Cells.category, for: indexPath) as! CategoryTableViewCell
		self.configure(cell: cell, at: indexPath)
		return cell
	}
}
