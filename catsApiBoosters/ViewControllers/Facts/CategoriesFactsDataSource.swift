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
	
	public var handleForward: ((_ cell: CategoryFactCollectionViewCell) -> Void) = { _ in}
	public var handleBackward: ((_ cell: CategoryFactCollectionViewCell) -> Void) = { _ in}

	init(contentViewModel: CategoriesFactsViewModel) {
		self.contentViewModel = contentViewModel
	}
}

extension CategoriesFactsDataSource {
	
	private func configure(cell: CategoryFactCollectionViewCell, at indexPath: IndexPath) {
		
		let model = contentViewModel.getCategory(at: indexPath)
		let imageID = model.imageChacheID
		
		if let stringURL = model.imageURL {
			Task {
				let image = try? await ImageDownloadActor().getImage(from: URL(string: stringURL), with: imageID)
				await MainActor.run {
					cell.configureCell(with: image)
				}
			}
		}
		
		var position: ElementhPosition {
			switch indexPath.row {
				case 0:
					return .first
				case contentViewModel.numbersOrRowsAtSection() - 1:
					return .last
				default:
					return .regular
			}
		}
		
		cell.configureCell(with: model, position: position)
		cell.delegate = self
	}
}

extension CategoriesFactsDataSource: CategoryFactCellDelegate {
	
	func didTapScrollForward(_ cell: CategoryFactCollectionViewCell) {
		self.handleForward(cell)
	}
	
	func didTapScrollBackward(_ cell: CategoryFactCollectionViewCell) {
		self.handleBackward(cell)
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
	
	
	func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
		
		let content = self.contentViewModel.getCategory(at: indexPath)
		let imageCacheID = content.imageChacheID
		let identifier = IndexPath(row: indexPath.row, section: indexPath.section) as NSCopying
		
		if let image = CFileManager().getImageFromCache(with: imageCacheID) {
			return UIContextMenuConfiguration(identifier: identifier) {
				return ImagePreviewViewController(item: image)
			} actionProvider: { _ in
				return self.createCellContextMenu(for: content, at: indexPath)
			}
		}
		return nil
	}
}

extension CategoriesFactsDataSource {
	
	func collectionView(_ collectionView: UICollectionView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
		
		guard let indexPath = configuration.identifier as? IndexPath, let cell = collectionView.cellForItem(at: indexPath) as? CategoryFactCollectionViewCell else { return nil}
		
		let params = UIPreviewParameters()
		params.backgroundColor = .clear
		let targetPrteview = UITargetedPreview(view: cell.contentImageView, parameters: params)
		return targetPrteview
	}
	
	func collectionView(_ collectionView: UICollectionView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
		
		guard let indexPath = configuration.identifier as? IndexPath, let cell = collectionView.cellForItem(at: indexPath) as? CategoryFactCollectionViewCell else { return nil}
		let targetPrteview = UITargetedPreview(view: cell.contentImageView)
		targetPrteview.parameters.backgroundColor = .clear
		return targetPrteview
	}
}

extension CategoriesFactsDataSource {
	
	private func createCellContextMenu(for model: AnimalContentModel, at indexPath: IndexPath) -> UIMenu {
		
		let shareActionImage = Images.Buttons.share
	
		let shareAction = UIAction(title: Buttons.getButtonTitle(of: .share), image: shareActionImage) { _ in
			self.didTapShareFact(model: model)
		}
		
		return UIMenu(title: "", children: [shareAction])
	}
	
	private func didTapShareFact(model: AnimalContentModel) {
		
		let image = CFileManager().getImageFromCache(with: model.imageChacheID)
		let fact = model.fact
		
		ShareManager.shared.share(factString: fact, image: image) {
			debugPrint("done")
		}
	}
}
