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

    override func viewDidLoad() {
        super.viewDidLoad()
		
		viewModelSetup()
		setupUI()
		setupCollectionView()
    }

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
	
		self.navigationItem.largeTitleDisplayMode = .always
	}
}

extension CategoriesFactsViewController {
	
	private func viewModelSetup() {
		
		if let content = content {
			self.contentViewModel = CategoriesFactsViewModel(categoryContent: content)
			self.contentDataSource = CategoriesFactsDataSource(contentViewModel: self.contentViewModel)
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
	}
	
	private func setupNavigation() {
		self.navigationItem.largeTitleDisplayMode = .never
	}
	
}
