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
	public var handleSelectCategory: ((AnimalCategoryModel) -> Void) = { _ in }
	public var handlePaidSelectCatrgory: ((AnimalCategoryModel) -> Void) = { _ in }
	public var handleTryPurchsePremium: ((CategoryTableViewCell) -> Void) = { _ in}
	
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
		cell.delegate = self
		cell.configureCell(with: model)
	}
}

extension CategoriesDataSource: CategoryDelegate {
	
	func didSelectedPremiumContent(at cell: CategoryTableViewCell) {
		self.handleTryPurchsePremium(cell)
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
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let model = categoriesViewModel.getCategory(at: indexPath)

		if model.content.isEmpty {
			AlertManager.showAlert(of: .emptyContent, completionHandler: nil)
		} else {
			switch model.status {
				case .free:
					self.handleSelectCategory(model)
				case .paid:
					self.handlePaidSelectCatrgory(model)
				case .unknown:
					return
			}
		}
	}
}
