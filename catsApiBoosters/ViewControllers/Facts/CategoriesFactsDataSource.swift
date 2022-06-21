//
//  CategoriesFactsDataSource.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 22.06.2022.
//

import Foundation
import UIKit

@MainActor class CategoriesFactsDataSource: NSObject {
	
	public var contentViewModel: CategoriesFactsViewModel
	
	init(contentViewModel: CategoriesFactsViewModel) {
		self.contentViewModel = contentViewModel
	}
}

extension CategoriesFactsDataSource {
	
	private func configure(cell: CategoryFactCollectionViewCell, at indexPath: IndexPath) {
		
		let model = contentViewModel.getCategory(at: indexPath)
		
		cell.configureCell(with: model)
	}
}

extension CategoriesFactsDataSource: UICollectionViewDataSource, UICollectionViewDelegate {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.contentViewModel.numbersOrRowsAtSection()
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.Cells.fact, for: indexPath) as! CategoryFactCollectionViewCell
		self.configure(cell: cell, at: indexPath)
		return cell
	}
}
