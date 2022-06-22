//
//  CategoriesListViewController.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 20.06.2022.
//

import UIKit
import RealmSwift

class CategoriesListViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	private var categoriesViewModel: CategoriesViewModel!
	private var categoriesDataSource: CategoriesDataSource!
	
	private var persistantManager = PersistentManager.instance
	private var selectedCategory: AnimalCategoryModel?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		setupObservers()
		setupDelegate()
		navigationSetup()
		setupViewModel()
        setupTableView()
		setupUI()
    }
}

extension CategoriesListViewController {
	
	@objc func dateBaseUpdated() {
		self.setupViewModel()
		
		if self.categoriesViewModel.categories.count > 0 {
			UIPresenter.closePresentedWindow(of: .loader)
		} else {
			AlertManager.showAlert(of: .contentIsEmpty)
		}
	}
}

extension CategoriesListViewController {
	
	private func handleSelectContent() {
		
		self.categoriesDataSource.handlePaidSelectCatrgory = { selectedCategory in
			AlertManager.showAlert(of: .showAdd) {
				self.selectedCategory = selectedCategory
				UIPresenter.showViewController(of: .advertisement)
			}
		}
		
		self.categoriesDataSource.handleSelectCategory = { selectedCategory in
			self.showContent(selectedCategory)
		}
		
		self.categoriesDataSource.handleTryPurchsePremium = { cell in
			
			guard let indexPath = self.tableView.indexPath(for: cell) else { return }
			
			let model = self.categoriesViewModel.getCategory(at: indexPath)
			
			if model.content.isEmpty {
				AlertManager.showAlert(of: .emptyContent, completionHandler: nil)
			} else {
				AlertManager.showAlert(of: .showAdd) {
					self.selectedCategory = model
					UIPresenter.showViewController(of: .advertisement)
				}
			}
		}
	}
	
	private func showContent(_ model: AnimalCategoryModel) {
		
		let storyboard = UIStoryboard(name: Constants.Identifiers.Stroryboards.main, bundle: nil)
		let viewConroller = storyboard.instantiateViewController(withIdentifier: Constants.Identifiers.ViewControllers.categoriesFacts) as! CategoriesFactsViewController
		viewConroller.content = Array(model.content)
		viewConroller.navigationTitle = model.title ?? ""
		self.navigationController?.pushViewController(viewConroller, animated: true)
	}
}

extension CategoriesListViewController: AdvertisementListener {
	
	func advertisementDidCancel() {
		self.selectedCategory = nil
	}
	
	func advertisementTryCancel() {
		AlertManager.showAlert(of: .cancelAdd) {
			self.selectedCategory = nil
			UIPresenter.closePresentedWindow(of: .advertisement)
		}
	}
	
	func advertisementDidShow() {
	
		UIPresenter.closePresentedWindow(of: .advertisement)
		
		guard let model = self.selectedCategory else { return }
		self.showContent(model)
	}
}

extension CategoriesListViewController {
	
	private func setupViewModel() {
		
		let categories = self.persistantManager.getObjects(with: AnimalCategoryModel.self).sorted(by: {$0.title ?? "" < $1.title ?? ""})
		self.categoriesViewModel = CategoriesViewModel(categories: categories)
		self.categoriesDataSource = CategoriesDataSource(categoryViewModel: self.categoriesViewModel)
		self.handleSelectContent()
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
		
		self.navigationController?.navigationBar.prefersLargeTitles = true
		self.navigationItem.largeTitleDisplayMode = .always
		self.navigationItem.title = "Categories"
	}
	
	private func setupUI() {
		
		self.tableView.separatorStyle = .none
	}
	
	private func setupObservers() {
		
		NotificationCenter.default.addObserver(self, selector: #selector(dateBaseUpdated), name: .dateBaseDidUpdate, object: nil)
	}
	
	private func setupDelegate() {
		
		AdvertisementMediator.instance.setListener(listener: self)
	}
}

