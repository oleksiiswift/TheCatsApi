//
//  CategoriesFactsViewController.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 20.06.2022.
//

import UIKit

class CategoriesFactsViewController: UIViewController {
	
	@IBOutlet weak var collectionView: UICollectionView!
	
	public var content: [AnimalContentModel]?
	public var navigationTitle: String?
	private var contentViewModel: CategoriesFactsViewModel!
	private var contentDataSource: CategoriesFactsDataSource!
	
	private let previewColletionFlowLayout = PreviewCarouselFlowLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		setupNavigation()
		viewModelSetup()
		setupUI()
		setupCollectionView()
    }

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
	
		self.navigationItem.largeTitleDisplayMode = .always
		self.clearStoredCache()
	}
}

extension CategoriesFactsViewController {
	
	private func handleScroolingItems() {
		
		self.contentDataSource.handleForward = { cell in
			if let indexPath = self.collectionView.indexPath(for: cell) {
				if indexPath.item != self.contentViewModel.numbersOrRowsAtSection() - 1 {
					self.scrollToIndex(indexPath: IndexPath(item: indexPath.item + 1, section: indexPath.section))
				}
			}
		}
		
		self.contentDataSource.handleBackward = { cell in
			if let indexPath = self.collectionView.indexPath(for: cell) {
				if indexPath.item != 0 {
					self.scrollToIndex(indexPath: IndexPath(item: indexPath.item - 1, section: indexPath.section))
				}
			}
		}
	}
	
	func scrollToIndex(indexPath: IndexPath) {
		self.collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally, .centeredVertically], animated: true)
	}
}

extension CategoriesFactsViewController {
	
	private func clearStoredCache() {
		
		guard let content = self.content else { return }
		
		let ids = content.map({$0.imageChacheID})
		
		CFileManager().removeIdsFromCache(ids: ids)
	}
}

extension CategoriesFactsViewController {
	
	private func viewModelSetup() {
		
		if let content = content {
			self.contentViewModel = CategoriesFactsViewModel(categoryContent: content)
			self.contentDataSource = CategoriesFactsDataSource(contentViewModel: self.contentViewModel)
			self.handleScroolingItems()
			self.collectionView.delegate = self.contentDataSource
			self.collectionView.dataSource = self.contentDataSource
			self.collectionView.reloadData()
		} else {
			debugPrint("no data")
		}
	}
}

extension CategoriesFactsViewController {
	
	private func setupUI() {
		
		self.navigationItem.title = self.navigationTitle
	}
	
	private func setupCollectionView() {
		
		self.collectionView.register(UINib(nibName: Constants.Identifiers.Xibs.fact, bundle: nil), forCellWithReuseIdentifier: Constants.Identifiers.Cells.fact)
		
		let itemSize = CGSize(width: Utils.screenWidth - 20, height: Utils.screenHeight - 250)
		
		self.previewColletionFlowLayout.itemSize = itemSize
		self.previewColletionFlowLayout.scrollDirection = .horizontal
		self.previewColletionFlowLayout.minimumInteritemSpacing = 20
		self.previewColletionFlowLayout.headerReferenceSize = .zero
		self.collectionView.collectionViewLayout = previewColletionFlowLayout
		self.collectionView.showsVerticalScrollIndicator = false
		self.collectionView.showsHorizontalScrollIndicator  = false
	}
	
	private func setupNavigation() {
		self.navigationItem.largeTitleDisplayMode = .never
	}
}
