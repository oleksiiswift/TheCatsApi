//
//  CategoriesListViewController.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 20.06.2022.
//

import UIKit

class CategoriesListViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	private var categoriesViewModel: CategoriesViewModel!
	private var categoriesDataSource: CategoriesDataSource!
	
	private var persistantManager = PersistentManager.instance

    override func viewDidLoad() {
        super.viewDidLoad()

		setupObservers()
		setupViewModel()
        setupTableView()
		setupUI()
    }
}

extension CategoriesListViewController {
	
	@objc func dateBaseUpdated() {
		self.setupViewModel()
		UIPresenter.closePresentedWindow(of: .loader)
	}
}

extension CategoriesListViewController {
	
	private func setupViewModel() {
		
		let categories = self.persistantManager.getObjects(with: AnimalCategoryModel.self)
		self.categoriesViewModel = CategoriesViewModel(categories: categories)
		self.categoriesDataSource = CategoriesDataSource(categoryViewModel: self.categoriesViewModel)
		
		self.tableView.delegate = self.categoriesDataSource
		self.tableView.dataSource = self.categoriesDataSource
		self.tableView.reloadData()
	}
}

extension CategoriesListViewController {
	
	private func setupTableView() {
		
		self.tableView.register(UINib(nibName: Constants.Identifiers.Xibs.category, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.Cells.category)
	}
}

extension CategoriesListViewController {
	
	private func navigationSetup() {
		
		
	}
	
	private func setupUI() {
		
		
	}
	
	private func setupObservers() {
		
		NotificationCenter.default.addObserver(self, selector: #selector(dateBaseUpdated), name: .dateBaseDidUpdate, object: nil)
	}
}
